vim.g.mapleader = " "

vim.cmd("set runtimepath^=~/.vim runtimepath+=~/.vim/after")
vim.cmd("let &packpath = &runtimepath")
vim.cmd("source ~/.vimrc")

-- Enable auto-reload
vim.o.autoread = true
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
  command = "checktime"
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None"
})
-- reload done

--vim.opt.colorcolumn = "79"

local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug 'mg979/vim-visual-multi'
Plug 'http://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/preservim/nerdtree' 
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/mbbill/undotree'
Plug 'neoclide/coc.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'Exafunction/windsurf.vim'
Plug 'christoomey/vim-tmux-navigator'

Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug "leoluz/nvim-dap-go"
Plug "theHamsta/nvim-dap-virtual-text"

Plug 'catppuccin/nvim'

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'cdelledonne/vim-cmake'
Plug 'numToStr/Comment.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'windwp/nvim-autopairs'
vim.call('plug#end')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Automatic bracket/brace
require("nvim-autopairs").setup({})

-- colorscheme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

require("plugins.dap-go")
require("plugins.dap-cpp")

require('plugins.treesitter')

-- Make sure Comment.nvim is set up
require('Comment').setup()

-- windsurf API URL
vim.cmd[[let g:codeium_server_config = {
  \'portal_url': 'https://codeium.delllabs.net',
  \'api_url': 'https://codeium.delllabs.net/_route/api_server' }
]]

-- customise the comment addition
vim.keymap.set('n', '<leader>c', 'gcc', { noremap = false, silent = true })

-- Import lspconfig
local lspconfig = require('lspconfig')

-- Configure gopls (go lang)
lspconfig.gopls.setup({
	cmd = {"gopls"}, -- Ensure gopls is in your PATH
	filetypes = {"go", "gomod"},
	root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

lspconfig.clangd.setup({
	cmd = {"clangd"}, -- Ensure clangd is in your PATH
	filetypes = {"c", "cpp"},
	root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
})

local cmp = require('cmp')
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
	})
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf }

        -- Go to definition
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- Show references
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- Show documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- Rename symbol
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    end
})

-- custom rename command
vim.api.nvim_create_user_command("Rename", function(opts)
  local oldname = vim.fn.expand("%:p")
  local newname = vim.fn.expand("%:h") .. "/" .. opts.args
  vim.cmd("saveas " .. newname)
  vim.fn.delete(oldname)
  print("Renamed to " .. opts.args)
end, { nargs = 1 })

