vim.g.mapleader = " "
vim.opt.smartcase = true

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
vim.cmd("highlight Todo ctermfg=Blue guifg=Red gui=bold")


-- Files and backup
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitright = true

--[[
  Native Vim Colorschemes
  default, ron, evening, morning, blue, darkblue, elflord, industry
  delek, koehler, pablo, peachpuff, slate, torte, zellner, desert
  habamax, murphy
--]]
vim.cmd("colorscheme habamax")
vim.cmd("highlight MatchParen guifg=none guibg=darkgrey gui=bold")
vim.opt.termguicolors = true


-- Status Bar
vim.opt.laststatus = 2
vim.opt.showmode = false

-- Lemonade clipboard (for ssh)
vim.opt.clipboard= "unnamedplus"
vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy",
  },
  paste = {
    ["+"] = "wl-paste",
    ["*"] = "wl-paste",
  },
  cache_enabled = true,
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

-- 80 Column Line Limit
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    vim.opt_local.colorcolumn = "80"
  end,
})

-- Search current file for a string
vim.api.nvim_create_user_command("Search", function(opts)
  vim.cmd("vimgrep /\\c" .. opts.args .. "/gj %")
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

-- Halligan folder rsync command --
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "/home/ajrom/halligan/*",
    command = "!halligan_sync push % &"
})


----[[----------]]-----
-------- LATEX --------
----[[----------]]-----
vim.api.nvim_create_user_command("LatexView", function()
    local texfile = vim.fn.expand("%")
    local pdffile = vim.fn.expand("%:r") .. ".pdf"
    vim.fn.jobstart({ "latexmk", "-pdf", "-pvc", "-interaction=nonstopmode", texfile }, { detach = true })
    os.execute("zathura " .. pdffile .. " &> /dev/null &")
end, {})
vim.keymap.set("n", "<leader>lv", ":LatexView<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ls", ":! pkill -f latexmk<CR>", { noremap = true, silent = true })


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

vim.opt.path:append("**")
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "list", "full" }



-- Undo highlights
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>")

-- Regex commands/copen
vim.keymap.set("n", "<leader>c", ":cclose<CR>", { desc = "Close quickfix list" })
vim.keymap.set("n", "<leader>s", ":Search ", { desc = "Search current file" })
vim.keymap.set("n", "<leader>cn", ":cnext<CR>", { desc = "Go to next result" })
vim.keymap.set("n", "<leader>cp", ":cprev<CR>", { desc = "Go to previous result" })

vim.keymap.set("n", "<leader>f", function()
  local file = vim.fn.input("Open file: ", "", "file")
  vim.cmd("tabnew " .. file)
end, { desc = "Open file in new tab" })


