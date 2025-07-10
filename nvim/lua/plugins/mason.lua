return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "gopls",
      "lua-language-server",
      "stylua",
      "goimports",
      "gomodifytags",
    },
  },
}
