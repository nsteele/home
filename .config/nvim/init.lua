-- Auto install of lazyvim --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
      spec = {

        -- Add your plugins here --
        --
        -- { "folke/which-key.nvim" },
	 {"nvim-lua/plenary.nvim"},
	 {"christoomey/vim-tmux-navigator"},
         { 
           "nvim-treesitter/nvim-treesitter",
	   build = ":TSUpdate",
	   config = function()
             require("nvim-treesitter.configs").setup({
               highlight = {
                 enable = true,
               },
               ensure_installed = {
                 "python",
                 "cpp",
                 -- Add other languages here
               },
               auto_install = true,
             })
             end,
         },
         {
           "nvim-telescope/telescope.nvim",
           cmd = "Telescope",
           dependencies = {
             "nvim-lua/plenary.nvim",
           },
           config = function()
             require("telescope").setup({
               defaults = {
                 mappings = {
                   i = {
                     ["<C-k>"] = "move_selection_previous",
                     ["<C-j>"] = "move_selection_next",
                   },
                 },
               },
             })
           end,
         },
	 { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
	 {
           "folke/tokyonight.nvim",
           priority = 1000, -- make sure to load this before all the other start plugins
           config = function()
             local bg = "#011628"
             local bg_dark = "#011423"
             local bg_highlight = "#143652"
             local bg_search = "#0A64AC"
             local bg_visual = "#275378"
             local fg = "#CBE0F0"
             local fg_dark = "#B4D0E9"
             local fg_gutter = "#627E97"
             local border = "#547998"

             require("tokyonight").setup({
               style = "night",
               on_colors = function(colors)
                 colors.bg = bg
                 colors.bg_dark = bg_dark
                 colors.bg_float = bg_dark
                 colors.bg_highlight = bg_highlight
                 colors.bg_popup = bg_dark
                 colors.bg_search = bg_search
                 colors.bg_sidebar = bg_dark
                 colors.bg_statusline = bg_dark
                 colors.bg_visual = bg_visual
                 colors.border = border
                 colors.fg = fg
                 colors.fg_dark = fg_dark
                 colors.fg_float = fg
                 colors.fg_gutter = fg_gutter
                 colors.fg_sidebar = fg_dark
               end,
             })
             -- load the colorscheme here
             vim.cmd([[colorscheme tokyonight]])
           end,
         },
	 -- {
	 --         "samharju/synthweave.nvim",
	 --         lazy = false, -- Load this during startup if it's your main colorscheme
	 --         priority = 1000,
	 --         config = function()
	 --        	 vim.cmd.colorscheme("synthweave")
	 --         end,
	 -- },
      },
      checker = { enabled = true },
})


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
vim.keymap.set('n', '<leader>p', ':Telescope find_files<CR>') -- Easy fuzzy file search

-- Settings for faster grepping
if vim.fn.executable('rg') ~= 0 then
  vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden --multiline-dotall'
elseif vim.fn.executable('ag') ~= 0 then
  vim.opt.grepprg = 'ag --vimgrep --smart-case --hidden'
end

-- Settings for yanking to/from system clipboard
vim.keymap.set('n', '<leader>y', '"+y') -- Copy to system clipboard

-- Read extra init.lua if available
local extra_init_path = vim.fn.expand('~/.config/nvim/extra_init.lua')
if vim.fn.filereadable(extra_init_path) == 1 then
  dofile(extra_init_path)
end
