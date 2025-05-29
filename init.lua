vim.cmd("set runtimepath^=~/.vim runtimepath+=~/.vim/after")
vim.cmd("let &packpath = &runtimepath")
vim.cmd("source ~/.vimrc")

local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
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
vim.call('plug#end')

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
