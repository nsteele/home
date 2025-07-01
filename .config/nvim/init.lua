-- Basic Behavior
vim.opt.number = true -- Show line numbers
vim.opt.wrap = true -- Wrap lines
vim.opt.encoding = 'utf-8' -- Set encoding to UTF-8
vim.opt.wildmenu = true -- Visual autocomplete for command menu
vim.opt.lazyredraw = true -- Redraw only when necessary
vim.opt.laststatus = 2 -- Always show statusline
vim.opt.ruler = true -- Show line and column number of the cursor
vim.opt.visualbell = true -- Blink cursor on error
vim.opt.backspace = { 'indent', 'eol', 'start' } -- Backspace over everything in insert mode
vim.opt.tabstop = 4 -- 4 spaces for tabs
vim.opt.shiftwidth = 3 -- 4 spaces for indents
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting a new one
vim.opt.cursorline = true -- highlight the current cursor line

-- Appearance
vim.opt.termguicolors = true -- Enable true colors
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.cmd("let g:netrw_liststyle = 3")

-- Highlight unnecessary whitespace in C and C++ files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.opt_local.cino = 'g0'
    vim.opt_local.cinoptions = 'g0'
    vim.cmd [[match ErrorMsg /\s\+$/]]
  end,
})

-- Key Bindings
vim.keymap.set('n', 'j', 'gj') -- Move vertically by visual line
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('i', 'jj', '<Esc>') -- Easy escape
vim.g.mapleader = ' ' -- Use SPACE as leader key

-- Settings for faster grepping
if vim.fn.executable('rg') ~= 0 then
  vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden --multiline-dotall'
elseif vim.fn.executable('ag') ~= 0 then
  vim.opt.grepprg = 'ag --vimgrep --smart-case --hidden'
end

-- Settings for yanking to/from system clipboard
vim.keymap.set('n', '<leader>y', '"+y') -- Copy to system clipboard

-- Auto install of lazyvim --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "plugins" }, { import = "plugins.lsp" } }, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- Highlight trailing whitespace in markdown files
vim.cmd [[
  highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd FileType markdown match ExtraWhitespace /\s\+$/
]]

-- Read extra init.lua if available
local extra_init_path = vim.fn.expand('~/.config/nvim/extra_init.lua')
if vim.fn.filereadable(extra_init_path) == 1 then
  dofile(extra_init_path)
end
