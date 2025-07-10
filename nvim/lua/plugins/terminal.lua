return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle Floating Terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle Horizontal Terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Toggle Vertical Terminal" },
    { "<leader>gg", "<cmd>LazyGitToggle<CR>", desc = "LazyGit (Float)" },
  },
  opts = {
    open_mapping = [[<C-\>]],
    start_in_insert = true,
    direction = "float",
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    shade_terminals = true,
    persist_size = true,
    shell = vim.o.shell,
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "curved",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _G.LazyGitToggle()
      lazygit:toggle()
    end

    -- 🔥 FIX: Daftarkan command-nya
    vim.api.nvim_create_user_command("LazyGitToggle", function()
      LazyGitToggle()
    end, {})
  end,
}
