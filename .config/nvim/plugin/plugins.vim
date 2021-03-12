call plug#begin('~/.config/nvim/plugged')

" Addons
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'goldfeld/vim-seek'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" Plug 'vimwiki/vimwiki'
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'mileszs/ack.vim' " project wide search
Plug 'neomake/neomake' " async running stuff
Plug 'tpope/vim-dispatch' " async running stuff
Plug 'itchyny/lightline.vim' " lightline
" (python) autocomplete and syntax check (async)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

Plug 'Chiel92/vim-autoformat' " autoformat code
Plug 'lervag/vimtex' " the latex plugin
Plug 'KeitaNakamura/tex-conceal.vim' " better concealing in latex
Plug 'SirVer/ultisnips' " Snippets engine.
" Snippets are separated from the engine. Add this if you want them:
" Plug 'honza/vim-snippets'
Plug 'christoomey/vim-tmux-navigator' " Tmux integration
" Plug 'benmills/vimux' " run code and stuff in a tmux split
Plug 'tpope/vim-eunuch' " File system navigation
Plug 'ntpeters/vim-better-whitespace' " Syntax errors
Plug 'junegunn/goyo.vim' " Zen mode
Plug 'plasticboy/vim-markdown' " Markdwon support
Plug 'tpope/vim-fugitive' " Git support
Plug 'junegunn/gv.vim'
" Plug 'jreybert/vimagit'  " the other git plugin
Plug 'ludovicchabant/vim-gutentags' " Tags support
Plug 'andymass/vim-matchup'  " Better parenmtach
" Themes
Plug 'ap/vim-css-color' " hex color blocks in vim
Plug 'itchyny/landscape.vim'
Plug 'morhetz/gruvbox'
" Plug 'altercation/vim-colors-solarized'
" Plug 'icymind/NeoSolarized'
" Plug 'lifepillar/vim-solarized8'
" Plug 'joshdick/onedark.vim'

call plug#end()
