------------------------------------------------------------
-- Leader
------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------------------------------------------------------
-- Core options
------------------------------------------------------------
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.clipboard = "unnamedplus"
opt.updatetime = 250
opt.signcolumn = "yes"
opt.autoread = true
opt.list = true
opt.backspace=indent,eol,start
opt.syntax = on
opt.ignorecase = true
opt.smartcase = true

------------------------------------------------------------
-- Auto-reload files
------------------------------------------------------------
vim.api.nvim_create_autocmd(
  { "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" },
  { command = "checktime" }
)

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

------------------------------------------------------------
-- lazy.nvim bootstrap
------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

------------------------------------------------------------
-- Plugins
------------------------------------------------------------
require("lazy").setup("plugins")

