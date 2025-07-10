return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local luasnip = require("luasnip")
    luasnip.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })

    require("luasnip.loaders.from_vscode").lazy_load()

    -- Keymaps
    vim.keymap.set({ "i", "s" }, "<C-n>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<C-p>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true })

    vim.keymap.set("i", "<C-l>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end)
  end,
}
