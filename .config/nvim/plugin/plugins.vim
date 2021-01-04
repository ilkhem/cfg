call plug#begin('~/.config/nvim/plugged')

" Addons
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Plug 'ervandew/supertab'

" async running stuff
Plug 'neomake/neomake'
Plug 'tpope/vim-dispatch'

" lightline
Plug 'itchyny/lightline.vim'

" (python) autocomplete and syntax check (async)
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

" autoformat code
Plug 'Chiel92/vim-autoformat'

" latex
Plug 'lervag/vimtex'

" Snippets engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Tmux integration
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" Syntax highlighting
Plug 'elzr/vim-json'
" Plug 'tpope/vim-markdown'

" File system navigation
Plug 'tpope/vim-eunuch'

" Syntax errors
" Plug 'vim-syntastic/syntastic'  " not async
Plug 'ntpeters/vim-better-whitespace'

" Markdown support
Plug 'junegunn/goyo.vim'

" Git support
Plug 'tpope/vim-fugitive'

" Tags support
Plug 'ludovicchabant/vim-gutentags'

" Better parenmtach
Plug 'andymass/vim-matchup'

" Themes
Plug 'altercation/vim-colors-solarized'
Plug 'icymind/NeoSolarized'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/landscape.vim'

call plug#end()
