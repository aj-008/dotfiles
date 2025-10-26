vim.g.mapleader = " "


-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true

-- Tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8
vim.opt.smartindent = true

-- Highlights
vim.opt.cursorline = true
vim.opt.showmatch = true

-- Files and backup
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitright = true

--[[
  Native Vim Colorschemes
  Default, ron, evening, morning, blue, darkblue, elflord,
  delek, koehler, pablo, peachpuff, slate, torte, zellner
--]]
vim.cmd("colorscheme slate")
vim.cmd("highlight MatchParen guifg=none guibg=darkgrey gui=bold")
vim.opt.termguicolors = true

-- Status Bar
vim.opt.laststatus = 2
vim.opt.showmode = false

-- Lemonade clipboard (for ssh)
vim.opt.clipboard= "unnamedplus"
vim.g.clipboard = {
  name = "lemonade",
  copy = {
    ["+"] = "lemonade copy",
    ["*"] = "lemonade copy",
  },
  paste = {
    ["+"] = "lemonade paste",
    ["*"] = "lemonade paste",
  },
  cache_enabled = 0,
}

----[[----------]]-----
------ FUNCTIONS ------
----[[----------]]-----
--
-- Clear trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Set CWD to files dir
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd("lcd %:p:h")
  end,
})

-- C Syntax Highlighting
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.cmd("syntax enable")
    vim.cmd("syntax on")
    vim.opt_local.cindent = true
    vim.opt.smartcase = true
  end,
})
vim.cmd("highlight Todo ctermfg=Blue guifg=Red gui=bold")

-- 80 Column Line Limit
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    vim.opt_local.colorcolumn = "80"
  end,
})

-- Search current dir for a string
vim.api.nvim_create_user_command("CSearch", function(opts)
  vim.cmd("vimgrep /" .. opts.args .. "/gj **/*.c **/*.h")
  vim.cmd("copen")
end, { nargs = 1 })

-- Autocomplete file header
vim.api.nvim_create_user_command("CHeader", function()
  local filename = vim.fn.expand("%:t")
  local date = os.date("%B %d, %Y")
  local header = {
    "/**************************************************************",
    " *",
    " *                     " .. filename,
    " *",
    " *     Assignment: ",
    " *     Authors:  Partner 1, Partner 2 (partner01, partner02)",
    " *     Date:     " .. date,
    " *",
    " *     Summary:",
    " *",
    " *     ",
    " *",
    " **************************************************************/",
    "",
  }
  vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
end, {})



----[[----------]]-----
------- KEYMAPS -------
----[[----------]]-----

-- Buffer navigation
vim.keymap.set("n", "<leader>p", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>n", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>v", ":vnew<CR>", { noremap = true, silent = true })
-- Switch between split files naturally (ctrl + direction)
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "p", "P", { noremap = true })

vim.opt.path:append("**")
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "list", "full" }
vim.keymap.set("n", "<leader>f", ":find ", { desc = "Find file recursively" })


-- Undo highlights
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Swap paste to feel better (inline)
vim.keymap.set("n", "p", "P", { noremap = true })





