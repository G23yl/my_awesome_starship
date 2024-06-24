return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "BufEnter", "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require "cmp"

    local luasnip = require "luasnip"

    local lspkind = require "lspkind"

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    cmp.setup {
      completion = {
        completeopt = "menu, menuone, preview, noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm {
                select = true,
              }
            end
          else
            fallback()
          end
        end),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      -- sources for autocompletion
      sources = cmp.config.sources {
        { name = "nvim_lsp" }, -- lsp
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
        { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
        { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
        { name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
        { name = "calc" }, -- source for math calculation
      },
      -- configure lspkind for vs-code like icons
      formatting = {
        format = lspkind.cmp_format {
          maxwidth = 50,
          ellipsis_char = "...",
        },
      },
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" } end,
      }),
    }
  end,
}
