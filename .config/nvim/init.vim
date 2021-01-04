source ~/.config/nvim/plugin/plugins.vim

let mapleader =","
let maplocalleader =","

" Some basics:
set nocompatible
set encoding=utf-8
set number relativenumber
syntax on
filetype plugin on
set number
set mouse=a
set ts=4

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" set background=dark
colorscheme landscape

" Showcase comments in italics
highlight Comment cterm=italic gui=italic


" Enable autocompletion:
set wildmode=longest,list,full
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" persistent undo
set undodir=~/.config/nvim/undo/
set undofile
set undolevels=1000
set undoreload=10000

" misc
set autoindent
set expandtab
set cursorline
set showmatch
set autoread                          " Auto reload changed files
set wildmenu                          " Tab autocomplete in command mode
set splitright                        " Open new splits to the right
set splitbelow                        " Open new splits to the bottom
set history=500
set hlsearch                          " Highlight search results
" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set ignorecase smartcase              " Search queries intelligently set case
set incsearch                         " Show search results as you type
set timeoutlen=1000 ttimeoutlen=0     " Remove timeout when hitting escape
set showcmd                           " Show size of visual selection
let python_highlight_all=1

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Get off my lawn - helpful when learning Vim :)
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" configure neovim to use pyenv
let g:python3_host_prog = expand('$HOME/.pyenv/versions/3.8.0/envs/neovim3/bin/python')
let g:python_host_prog = expand('$HOME/.pyenv/versions/2.7.14/envs/neovim2/bin/python')



""" NERD TREE
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"""JEDI-VIM
"<leader>n from nerd tree overwritten by jedi-vim
let g:jedi#usages_command = "<leader>f"

""" VIM-DISPATCH
autocmd FileType python let b:dispatch = 'python %'
map <leader>m :Dispatch<CR>

""" DEOPLETE
" call deoplete manually
"call deoplete#custom#option({
"      \ 'auto_complete_popup': 'manual',
"      \ })
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"



""" VIMTEX
" configure deoplete with vimtex
call deoplete#custom#var('omni', 'input_patterns', {
        \ 'tex': g:vimtex#re#deoplete
        \})
let g:vimtex_complete_close_braces = 1

let g:matchup_override_vimtex = 1

" nvr to work with latex callbacks for nvim
let g:vimtex_compiler_progname = 'nvr'

" configure viewer depending on OS (only for linux and macOS)
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux"
        " setup okular
        let g:vimtex_view_general_viewer = 'okular'
        let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
        let g:vimtex_view_general_options_latexmk = '--unique'
else
        " assume it is macOS
        " source is https://github.com/jdhao/nvim-config/blob/master/plugins.vim
        " let g:vimtex_view_method = "skim"
        let g:vimtex_view_general_viewer
                \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'

        " This adds a callback hook that updates Skim after compilation
        let g:vimtex_compiler_callback_hooks = ['UpdateSkim']

        function! UpdateSkim(status)
            if !a:status | return | endif

            let l:out = b:vimtex.out()
            let l:tex = expand('%:p')
            let l:cmd = [g:vimtex_view_general_viewer, '-r']

            if !empty(system('pgrep Skim'))
                call extend(l:cmd, ['-g'])
            endif

            if has('nvim')
                call jobstart(l:cmd + [line('.'), l:out, l:tex])
            elseif has('job')
                call job_start(l:cmd + [line('.'), l:out, l:tex])
            else
                call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
            endif
        endfunction
endif

" TOC settings
" let g:vimtex_toc_config = {
"       \ 'name' : 'TOC',
"       \ 'layers' : ['content', 'todo', 'include'],
"       \ 'resize' : 1,
"       \ 'split_width' : 50,
"       \ 'todo_sorted' : 0,
"       \ 'show_help' : 1,
"       \ 'show_numbers' : 1,
"       \ 'mode' : 2,
"       \}

" add ysc and yse from surround.vim
augroup latexSurround
     autocmd!
     autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
     let b:surround_{char2nr("e")}
       \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
     let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction



""" ULTISNIPPETS
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-space>"
let g:UltiSnipsJumpBackwardTrigger="<s-space>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Configuration for custom snippets directory, see
" https://jdhao.github.io/2019/04/17/neovim_snippet_s1/ for details.
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'my_snippets']


""" LIGHTLINE
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ }
set noshowmode  " remove --insert-- and --visual-- because lightline has them
