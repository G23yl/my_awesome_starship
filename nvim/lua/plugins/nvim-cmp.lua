-- return {
--   "hrsh7th/nvim-cmp",
--   event = { "InsertEnter", "BufEnter", "BufReadPre", "BufNewFile" },
--   dependencies = {
--     "hrsh7th/cmp-buffer", -- source for text in buffer
--     "hrsh7th/cmp-path", -- source for file system paths
--     "L3MON4D3/LuaSnip", -- snippet engine
--     "saadparwaiz1/cmp_luasnip", -- for autocompletion
--     "rafamadriz/friendly-snippets", -- useful snippets
--     "onsails/lspkind.nvim", -- vs-code like pictograms
--   },
--   config = function()
--     local cmp = require "cmp"
--
--     local luasnip = require "luasnip"
--
--     local lspkind = require "lspkind"
--
--     -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
--     require("luasnip.loaders.from_vscode").lazy_load()
--
--     local has_words_before = function()
--       unpack = unpack or table.unpack
--       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
--     end
--
--     cmp.setup {
--       completion = {
--         completeopt = "menu, menuone, preview, noselect",
--       },
--       snippet = { -- configure how nvim-cmp interacts with snippet engine
--         expand = function(args) luasnip.lsp_expand(args.body) end,
--       },
--       window = {
--         completion = cmp.config.window.bordered(),
--         documentation = cmp.config.window.bordered(),
--       },
--       mapping = cmp.mapping.preset.insert {
--         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-e>"] = cmp.mapping.abort(),
--         ["<CR>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             if luasnip.expandable() then
--               luasnip.expand()
--             else
--               cmp.confirm {
--                 select = true,
--               }
--             end
--           else
--             fallback()
--           end
--         end),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_next_item()
--           elseif luasnip.locally_jumpable(1) then
--             luasnip.jump(1)
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif luasnip.locally_jumpable(-1) then
--             luasnip.jump(-1)
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--       },
--       -- sources for autocompletion
--       sources = cmp.config.sources {
--         { name = "nvim_lsp" }, -- lsp
--         { name = "luasnip" }, -- snippets
--         { name = "buffer" }, -- text within current buffer
--         { name = "path" }, -- file system paths
--         { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
--         { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
--         { name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
--         { name = "calc" }, -- source for math calculation
--       },
--       -- configure lspkind for vs-code like icons
--       formatting = {
--         format = lspkind.cmp_format {
--           maxwidth = 50,
--           ellipsis_char = "...",
--         },
--       },
--       vim.api.nvim_create_autocmd("BufEnter", {
--         callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" } end,
--       }),
--     }
--   end,
-- }
return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-calc",
    },
    opts = function(_, opts) table.insert(opts.sources, { name = "calc" }) end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "onsails/lspkind.nvim",
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      -- local lspkind = require "lspkind"
      opts = vim.tbl_deep_extend("force", opts or {}, {
        sources = cmp.config.sources {
          { name = "nvim_lsp", priority = 1000, group_index = 1 },
          { name = "buffer", priority = 500, group_index = 2 },
          { name = "luasnip", priority = 750, group_index = 1 },
          { name = "path", priority = 250, group_index = 1 },
          { name = "calc", priority = 100 },
        },
        mapping = {
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then cmp.select_next_item { behavior = cmp.SelectBehavior.Select } end
              cmp.confirm { select = true }
            else
              fallback()
            end
          end, { "i", "s", "c" }),
        },
        window = {
          documentation = cmp.config.window.bordered {
            border = {
              { "", "DiagnosticHint" },
              { "─", "Comment" },
              { "╮", "Comment" },
              { "│", "Comment" },
              { "╯", "Comment" },
              { "─", "Comment" },
              { "╰", "Comment" },
              { "|", "Comment" },
            },
          },
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
          },
          vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" }),
          vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#2c2f34" }),
          vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true }),
          vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true }),
          vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true }),
          vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true }),
          vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" }),
          vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" }),
          vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" }),
          vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" }),
          vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" }),
          vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" }),
          vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" }),
          vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" }),
          vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" }),
          vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" }),
          vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" }),
          vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" }),
          vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" }),
          vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" }),
          vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" }),
          vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" }),
          vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" }),
          vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" }),
          vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" }),
          vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" }),
          vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" }),
          vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" }),
          vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" }),
          vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" }),
          vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" }),
        },
        preselect = cmp.PreselectMode.None,
        completion = {
          keyword_length = 1,
          completeopt = "menu,menuone,noinsert,noselect",
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          -- format = lspkind.cmp_format({
          --   mode = "symbol_text",
          --   preset = "codicons",
          --   before = function(entry, vim_item)
          --     if vim.tbl_contains({ "path" }, entry.source.name) then
          --       local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
          --       if icon then
          --         vim_item.kind = icon
          --         vim_item.kind_hl_group = hl_group
          --         return vim_item
          --       end
          --     end
          --     vim_item.menu = ({
          --       buffer = "[Buffer]",
          --       luasnip = "[Snippets]",
          --       nvim_lsp = "[LSP]",
          --       path = "[Path]",
          --       calc = "[Calc]",
          --     })[entry.source.name]
          --
          --     vim_item.dup = ({
          --       buffer = 1,
          --       path = 1,
          --       nvim_lsp = 0,
          --       snippets = 1,
          --     })[entry.source.name] or 0
          --     return vim_item
          --   end,
          -- }),
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format { mode = "symbol_text", maxwidth = 50 }(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
          end,
        },
      })
      return opts
    end,
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   keys = { ":", "/", "?" },
  --   dependencies = {
  --     "hrsh7th/cmp-cmdline",
  --   },
  --   config = function(_, opts)
  --     local cmp = require("cmp")
  --
  --     cmp.setup(opts)
  --     cmp.setup.cmdline("/", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = "buffer" },
  --       },
  --     })
  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = "path" },
  --       }, {
  --         {
  --           name = "cmdline",
  --           option = {
  --             ignore_cmds = { "Man", "!" },
  --           },
  --         },
  --       }),
  --     })
  --   end,
  -- },
}
