return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.sections.lualine_x = {
      { "encoding" },
      { "filetype" },
      {
        function()
          return ""
        end,
      },
    }
  end,
}
