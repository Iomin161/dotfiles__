require("catppuccin").setup({
  flavour = "mocha", -- choose your desired flavor (other options: latte, frappe, macchiato, mocha)
  transparent_background = false,
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
      },
    },
    cmp = true,
    -- add more integrations as needed
  },
})

vim.cmd("colorscheme catppuccin")
