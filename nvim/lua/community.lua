-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.recipes.neovide" },
  { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.completion.cmp-cmdline" },
  { import = "astrocommunity.indent.indent-blankline-nvim" },
  { import = "astrocommunity.indent.mini-indentscope" },
  -- { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- import/override with your plugins folder
}
