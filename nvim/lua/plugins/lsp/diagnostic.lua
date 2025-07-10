return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      virtual_lines = true,
      update_in_insert = false,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    },
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      float = {
        border = "rounded",
        source = "always",
      },
    })

    -- Tampilkan diagnostic float saat cursor berhenti (seperti VSCode)
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = 0,
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end,
    })
  end,
}
