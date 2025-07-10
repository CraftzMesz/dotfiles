-- ================================
-- 🧠 Custom Keymaps - Safe for LazyVim
-- ================================
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- === Buffer Navigation ===
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })

-- === Terminal ===
map("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle Terminal" })

-- === Trouble Diagnostics ===
map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Toggle Trouble" })
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Workspace Diagnostics" })

-- === LSP Utility ===
map("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save File" })
map("n", "<leader>wf", function()
  vim.lsp.buf.format({ async = true })
  vim.cmd("w")
end, { desc = "Format + Save" })

-- === Productivity ===
map("n", "<A-a>", "ggVG", { desc = "Select All" })
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- === Struct Comment + JSON Tag (gomodifytags) ===
map("n", "<leader>cT", function()
  local struct = vim.fn.expand("<cword>")
  local file = vim.fn.expand("%:p")
  local line = vim.fn.search("\\v^type\\s+" .. struct .. "\\s+struct", "bn")

  if line > 1 then
    local prev = vim.api.nvim_buf_get_lines(0, line - 2, line - 1, false)[1]
    if not prev:match("^//") then
      local comment = "// " .. struct .. " is auto-generated struct"
      vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, { comment })
    end
  end

  vim.fn.jobstart({
    "gomodifytags",
    "-file",
    file,
    "-struct",
    struct,
    "-add-tags",
    "json",
    "-w",
  }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.notify("✅ JSON tags added to struct: " .. struct, vim.log.levels.INFO, { title = "gomodifytags" })
        vim.cmd("edit!") -- Reload buffer
      end
    end,
    on_stderr = function(_, err)
      if err then
        vim.notify(table.concat(err, "\n"), vim.log.levels.ERROR, { title = "gomodifytags error" })
      end
    end,
  })
end, { desc = "Add comment + JSON tags to struct", noremap = true, silent = true })

-- === Telescope (tidak override default LazyVim Telescope) ===
-- Uncomment kalau ingin override dengan gaya kamu:
-- map("n", "<leader>fF", "<cmd>Telescope find_files<CR>", { desc = "Find File (custom)" })
-- map("n", "<leader>fG", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep (custom)" })
