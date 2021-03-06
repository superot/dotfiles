set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/nvim-lua/popup.nvim'
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/norcalli/nvim-colorizer.lua'
Plug 'https://github.com/nvim-telescope/telescope.nvim'

Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}

Plug 'https://github.com/tpope/vim-sensible' 
Plug 'https://github.com/tpope/vim-dispatch' 
Plug 'https://github.com/tpope/vim-sleuth'
Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'https://github.com/tpope/vim-markdown'
Plug 'https://github.com/tpope/vim-fugitive' 

Plug 'https://github.com/sainnhe/sonokai'
Plug 'https://github.com/rakr/vim-one'
Plug 'https://github.com/joshdick/onedark.vim'
Plug 'https://github.com/sonph/onehalf', { 'rtp': 'vim' }
Plug 'https://github.com/itchyny/lightline.vim'

Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/jmcantrell/vim-virtualenv'
Plug 'https://github.com/ervandew/supertab'
Plug 'https://github.com/tmhedberg/SimpylFold'

Plug 'https://github.com/jiangmiao/auto-pairs'

Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'

Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/vim-python/python-syntax'
Plug 'https://github.com/PProvost/vim-ps1'
Plug 'https://github.com/StanAngeloff/php.vim'
Plug 'https://github.com/arzg/vim-sh', { 'for': 'go'  }
Plug 'https://github.com/fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'https://github.com/numirias/semshi'


call plug#end()

filetype plugin indent on

syntax enable
syntax on

set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set termguicolors
set t_Co=256
set nowrap
set noswapfile
set noshowmode
set nobackup
set nowritebackup
set lazyredraw
set pumheight=15
set ruler
set cmdheight=1
set splitbelow
set splitright
set confirm
set autoread
set wildmenu
set encoding=utf-8
set fileencoding=utf-8
set scrolloff=4
set colorcolumn=85
set laststatus=2
set tabstop=4 softtabstop=4 shiftwidth=4
set smarttab
set smartcase
set smartindent
set expandtab
set guicursor=
set clipboard=unnamedplus
set undodir=~/.vim/undodir
set undofile
set signcolumn=yes
set rnu nu
set cursorline
set fileformat=unix
set formatoptions-=cro
set complete+=kspell
set shortmess+=c
set completeopt=menu,noinsert,noselect
set showcmd
set noshowmode
set timeout
set timeoutlen=3000
set updatetime=300
set foldmethod=indent
set foldlevel=1

if has('nvim')
    let g:python3_host_prog = '~/.venv/bin/python'
endif

let g:mapleader = "\\"

" _colorscheme_
source $HOME/.vim/colors/themes.vim

" _vim_fugitive_
nmap <leader>]h :diffget //3<CR>
nmap <leader>[u :diffget //2<CR>
nmap <leader>]s :G<CR>
command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>

" _vim_markdown_
let g:markdown_syntax_conceal = 1
let g:markdown_minlines = 75

" _coc_
if exists(':CocEnable')
    if has_key(g:plugs, 'coc.nvim')
        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction
        function! s:show_documentation()
            if (index(['vim', 'help'], &filetype) >= 0)
                execute 'h' expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction
        autocmd BufAdd * if getfsize(expand('<afile>')) > 1024*1024 |
                    \ let b:coc_enabled=0 endif
        autocmd FileType python let b:coc_root_patterns = ['.git', '.env', '~/.venv']
        autocmd CursorHold * silent call CocActionAsync('highlight')
        let g:coc_global_extensions = ['coc-git', 'coc-highlight', 'coc-vimlsp']
        augroup coc-config
            autocmd!
            autocmd VimEnter * nmap <silent> <leader>gd <Plug>(coc-definition)
            autocmd VimEnter * nmap <silent> <leader>gi <Plug>(coc-implementation)
            autocmd VimEnter * nmap <silent> <leader>su <Plug>(coc-references)
        augroup END
    endif
    autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
endif

" ------------------------
" ##### KEYBOARD MAP #####
" ------------------------
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>GFiles<cr>
nnoremap <Leader>r] :w<CR>:CocCommand python.execInTerminal<CR>
nnoremap <Leader>rp :w<Bar>execute 'silent !tmux send-keys -t dev:debug "python %" Enter'<CR>


" _indentline_
let g:indentLine_enabled = 1
let g:indentLine_color_gui = '#424554'
let g:indentLine_char = ''
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_leadingSpaceChar = '∙'
let g:indentLine_maxLines = 1

" _simpyfold_
let g:SimpylFold_docstring_preview = 0
let g:SimpylFold_fold_import = 0
let g:SimpylFold_fold_docstring = 0

" _python_
autocmd FileType python let b:dispatch = 'python %'
let g:semshi#filetypes = ['python']
let g:semshi#excluded_hl_groups = ['local']

" _supertab_
let g:SuperTabDefaultCompletionType = 'context'
autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \ endif

" _auto_pairs_
au FileType php let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php': '?>'})
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': 
    \ ['--layout=reverse', '--info=inline']}, <bang>0)
