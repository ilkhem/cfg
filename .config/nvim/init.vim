" install vimplug if not on the system
if ! filereadable(glob("$HOME/.config/nvim/autoload/plug.vim"))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p $HOME/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
" source the plugins
source ~/.config/nvim/plugin/plugins.vim

let mapleader ="\<Space>"
let maplocalleader =","


" Some basics:
set nocompatible
set encoding=utf-8
set number relativenumber
syntax on
filetype plugin on
set mouse=a
set ts=4
set clipboard+=unnamedplus

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
:nnoremap <silent> <Return> :nohlsearch<Bar>:echo<CR>
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
let g:python3_host_prog = expand('$HOME/.pyenv/versions/3.8.7/envs/neovim3/bin/python')
let g:python_host_prog = expand('$HOME/.pyenv/versions/2.7.18/envs/neovim2/bin/python')


" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_gb<CR>

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufRead,BufNewFile xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost .Xresources,.Xdefaults,Xresources,Xdefaults,xresources,xdefaults !xrdb %
"""""" PLUGINS CONFIG

""" GOYO plugin makes text more readable when writing prose:
map <leader>z :Goyo<CR>
" Enable Goyo by default for mutt writing
" autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
" autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
" autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
" autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

""" NERD TREE
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"""JEDI-VIM
let g:jedi#smart_auto_mappings = 1
"<leader>n from nerd tree overwritten by jedi-vim
let g:jedi#usages_command = "<leader>u"
"<leader>s from easymotion overwritten by jedi-vim
let g:jedi#goto_stubs_command = "<leader>t"
let g:jedi#show_call_signatures = 2
let g:jedi#show_call_signatures_delay = 250
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
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
" nvr to work with latex callbacks for nvim
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'zathura'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" let g:vimtex_view_general_options_latexmk = '--unique'

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

set conceallevel=1
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none


""" ULTISNIPPETS
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-space>"
let g:UltiSnipsJumpBackwardTrigger="<s-space>"
" let g:UltiSnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Configuration for custom snippets directory, see
" https://jdhao.github.io/2019/04/17/neovim_snippet_s1/ for details.
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'my_snippets']


""" LIGHTLINE
" let g:lightline = {
"       \ 'colorscheme': 'landscape',
"       \ }
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'gitbranch', 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
set noshowmode  " remove --insert-- and --visual-- because lightline has them



""" EASYMOTION
map  <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0


""" VIM-SEEK
let g:seek_enable_jumps = 1


""" LeaderF
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 1
let g:Lf_UseVersionControlTool = 1
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
" let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader><space><space>"
noremap <leader><space>b :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>`        :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR><CR>
noremap <leader><space>r :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader><space>m :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
noremap <leader><space>T :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader><space>t :<C-U><C-R>=printf("Leaderf tag %s", "")<CR><CR>
noremap <leader><space>l :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader><space>s :<C-U><C-R>=printf("Leaderf searchHistory %s", "")<CR><CR>
noremap <leader><space>c :<C-U><C-R>=printf("Leaderf cmdHistory %s", "")<CR><CR>
noremap <leader><space>f :<C-U><C-R>=printf("Leaderf! rg -e %s ", "")<CR>
noremap <leader><space>F :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR><CR>




""" ACK + RIPGREP
" let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
" " Auto close the Quickfix list after pressing '<enter>' on a list item
" let g:ack_autoclose = 1
" " Any empty ack search will search for the work the cursor is on
" let g:ack_use_cword_for_empty_search = 1
" " Don't jump to first match
" cnoreabbrev Ack Ack!
" " Maps <leader>. so we're ready to type the search keyword
" nnoremap <Leader>. :Ack!<Space>
" " Navigate quickfix list with ease
" nnoremap <silent> [q :cprevious<CR>
" nnoremap <silent> ]q :cnext<CR>


""" CtrlP
" let g:ctrlp_map = '<leader><space>'


""" WHICHKEY
" nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

""" AUTOMAKE suckless programs
" autocmd BufWritePost ~/.source/dwm-6.2/config.def.h !cd ~/.source/dwm-6.2/; sudo make clean install
" autocmd BufWritePost ~/.source/st-0.8.4/config.def.h !cd ~/.source/st-0.8.4; sudo -A make clean install
