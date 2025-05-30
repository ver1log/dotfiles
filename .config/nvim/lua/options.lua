vim.wo.number = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.cmd.syntax('enable')
vim.cmd('colorscheme tokyonight')
vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
]]
