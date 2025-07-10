return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = true,
    },

    servers = {
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
            },
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
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

          -- 🔧 LSP Mappings (basic)
          map("gd", vim.lsp.buf.definition, "Goto Definition")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")

          -- 🩺 Diagnostic Navigasi
          map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
          map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
          map("gl", vim.diagnostic.open_float, "Hover Diagnostic")
          map("<leader>de", vim.diagnostic.open_float, "Show Diagnostic (Float)")
          map("<leader>dq", vim.diagnostic.setloclist, "Diagnostics to Loclist")
          map("<leader>dl", function()
            vim.cmd("lopen")
          end, "Open Location List")
          map("<leader>dc", vim.diagnostic.reset, "Clear Diagnostics")

          -- 🪄 Tampilkan float diagnostic otomatis saat diam
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            callback = function()
              vim.diagnostic.open_float(nil, {
                focusable = false,
                border = "rounded",
                source = "always",
                prefix = "● ",
              })
            end,
          })
        end, "gopls")

        require("lspconfig").gopls.setup(opts)
        return true
      end,

      lua_ls = function(_, opts)
        require("lspconfig").lua_ls.setup(opts)
        return true
      end,
    },
  },
}
