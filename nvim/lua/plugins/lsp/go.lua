return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
            },
            analyses = {
              unusedparams = true,
              nilness = true,
            },
          },
        },
      },
    },
    setup = {
      gopls = function(_, opts)
        require("lazyvim.util").lsp.on_attach(function(client, bufnr)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
          end
          map("gd", vim.lsp.buf.definition, "Goto Definition")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
        end, "gopls")

        require("lspconfig").gopls.setup(opts)
        return true -- ← supaya LazyVim gak override lagi
      end,
    },
  },
}
