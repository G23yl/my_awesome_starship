return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>tt", ":ToggleTerm direction=tab<CR>", desc = "Tab terminal" },
  },
  opts = {
    size = 13,
    open_mapping = [[<c-\>]],
    shade_filetypes = {},
    shade_terminals = false,
    -- shading_factor = "1",
    start_in_insert = true,
    persist_size = true,
    -- direction = "float",
    -- direction = "horizontal",
  },
}
