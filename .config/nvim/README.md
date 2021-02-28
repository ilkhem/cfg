# My NVIM config

## Keybindings
- nerdtree <leader>n: nerdtree

- easymotion:
        + <leader>f: em-f
        + <leader>s: em-s
        + <leader>/: em-n
        + <leader>w: em-w
        + <leader>L: em-jk
        + <leader>j: em-j
        + <leader>k: em-k

- jedi: <localleader>+defaults

- vimtex: <localleader>+defaults

- dispatch
        + <leader>x: make/compile/eXecute

- LeaderF:
        + <leader>p: general
        + <leader>r: recent
        + <leader>l: line
        + <leader>m: methods/functions
        + <leader>t: tags
        + <leader>T: tags in buffer
        + <leader>c: cmd history
        + <leader><space>C: run latest cmd in history (should be used with care, since latest command can be a :q!)
        + <leader>S: search history
        + <leader>b: buffers
        + <leader>\`: switch to last buffer
        + <leader>u: rg word under cursor
        + <leader>.: rg in project

- Fugitive:
        + <leader>gs: status
        + <leader>gf: accept left diff
        + <leader>gj: accept right diff


