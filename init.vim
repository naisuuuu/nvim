scriptencoding utf-8

"""""""""""
"  VIMRC  "
"""""""""""

if !filereadable($HOME . '/.config/nvim/autoload/plug.vim')
    silent !curl -fLo  ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup PlugInstall
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    augroup End
endif

"""""""""""""
"  PLUGINS  "
"""""""""""""

call plug#begin('~/.config/nvim/plugged')

" fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

" general
Plug 'ap/vim-css-color'
" Plug 'chrisbra/NrrwRgn'
Plug 'editorconfig/editorconfig-vim'
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree'
Plug 'nicwest/vim-camelsnek'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'markonm/traces.vim'

" lang
Plug 'dense-analysis/ale'

" fs
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" theme
Plug 'huyvohcmc/atlas.vim'

" lightline
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

call plug#end()


""""""""""""""""""
"  KEY MAPPINGS  "
""""""""""""""""""

" disable arrow keys
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

" enable mouse scroll in normal mode
map <silent> <ScrollWheelUp> <C-y>
map <silent> <ScrollWheelDown> <C-e>

" new tab
nnoremap <silent> <C-w>t :tabnew<CR>
nnoremap <silent> <C-w><C-t> :tabnew<CR>

" keep selection after indenting
xnoremap <silent> < <gv
xnoremap <silent> > >gv

" remove trailing whitespaces
nnoremap <silent> <F3> mz:keepp %s/\\\@1<!\s\+$//e<CR>`z

" show highlight group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" run last macro
nnoremap Q @@

" toggle nohlsearch
nnoremap <silent> <C-h> :<C-u>nohlsearch<CR>

" remap leader to space
nnoremap <Space> <Nop>
let mapleader = ' '


"""""""""""""""""""""
"  PLUGIN SETTINGS  "
"""""""""""""""""""""

"" fzf

" default key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }

" customize the options used by 'git log'
let g:fzf_commits_log_options = '--graph --color=always --pretty=lo'

" command bindings
nnoremap <leader>s/ :History/<CR>
nnoremap <leader>s: :History:<CR>
nnoremap <leader>sb :Buffers<CR>
nnoremap <leader>sc :Colors<CR>
nnoremap <leader>sf :Files<CR>
nnoremap <leader>sg :GFiles<CR>
nnoremap <leader>sh :Helptags<CR>
nnoremap <leader>sl :BLines<CR>
nnoremap <leader>sm :Marks<CR>
nnoremap <leader>ss :History<CR>
nnoremap <leader>st :Tags<CR>
nnoremap <leader>sw :Windows<CR>

"" lightline
let g:lightline = {}

let g:lightline.active = {
            \   'left':  [ [ 'mode', 'paste' ],
            \              [ 'filename' ],
            \              [ 'gitbranch', 'gitversion', 'readonly' ] ],
            \   'right': [ [ 'linter_checking',
            \                'linter_errors',
            \                'linter_warnings',
            \                'linter_infos' ],
            \              [ 'wordcount',
            \                'longline',
            \                'mixedindent',
            \                'trailing',
            \                'lineinfo' ],
            \              [ 'fileencoding', 'filetype' ] ]
            \ }

let g:lightline.inactive = {
            \   'left':  [ [ 'filename' ],
            \              [ 'gitbranch' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'filetype' ] ]
            \ }

let g:lightline.tabline = {
            \   'left': [ [ 'tabs' ] ],
            \   'right': [ [ 'relativepath' ] ]
            \ }

let g:lightline.tab = {
            \   'active': [ 'tabnum', 'filename', 'modified' ],
            \   'inactive': [ 'tabnum', 'filename', 'modified' ]
            \ }

let g:lightline.component = {}

let g:lightline.component_visible_condition = {}

let g:lightline.component_function = {
            \   'mode':         'status#mode',
            \   'percent':      'status#percent',
            \   'fileencoding': 'status#fileencoding',
            \   'filetype':     'status#filetype',
            \   'gitbranch':    'status#gitbranch',
            \   'readonly':     'status#readonly',
            \   'filename':     'status#filename',
            \   'gitversion':   'status#gitversion',
            \   'trailing':     'status#trailing',
            \   'mixedindent':  'status#mixedindent',
            \   'longline':     'status#longline',
            \   'wordcount':    'status#wordcount',
            \ }

let g:lightline.component_expand = {
            \   'linter_checking': 'lightline#ale#checking',
            \   'linter_infos':    'lightline#ale#infos',
            \   'linter_warnings': 'lightline#ale#warnings',
            \   'linter_errors':   'lightline#ale#errors',
            \   'linter_ok':       'lightline#ale#ok',
            \ }

let g:lightline.component_type = {
            \   'linter_checking': 'right',
            \   'linter_infos':    'right',
            \   'linter_warnings': 'warning',
            \   'linter_errors':   'error',
            \   'linter_ok':       'right',
            \ }

let g:lightline#ale#indicator_checking = '...'
let g:lightline#ale#indicator_infos = '~~'
let g:lightline#ale#indicator_warnings = '--'
let g:lightline#ale#indicator_errors = '>>'
let g:lightline#ale#indicator_ok = 'OK'

"" vim-gitgutter
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '◢'
let g:gitgutter_sign_removed_first_line = '◥'
let g:gitgutter_sign_modified_removed = '┻'

"" incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#consistent_n_direction = 1
let g:incsearch#separate_highlight = 1
let g:incsearch#smart_backward_word = 1
let g:incsearch#no_inc_hlsearch = 1

"" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"" pear-tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

"" editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

"" NERDTree
map <leader>n :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeWinSize = 25
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeChDirMode = 3
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalMenu = 0

let g:NERDTreeGitStatusIndicatorMapCustom = {
            \     'Modified'  : '~',
            \     'Staged'    : '✚',
            \     'Untracked' : '✭',
            \     'Renamed'   : '➜',
            \     'Unmerged'  : '═',
            \     'Deleted'   : '-',
            \     'Dirty'     : '~',
            \     'Clean'     : '✔',
            \     'Ignored'   : '•',
            \     'Unknown'   : '?'
            \ }

augroup NERDTreeMod
    autocmd!
    " automatically close NERDTree if its the only open buffer
    autocmd BufEnter * call s:NERDCloseIfOnlyControlWinLeft()
augroup END

function! s:NERDCloseIfOnlyControlWinLeft()
    if winnr('$') != 1
        return
    endif
    if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
                \ || &buftype ==? 'quickfix'
        q
    endif
endfunction

"""""""""""""""""""""""
"  LANGUAGE SETTINGS  "
"""""""""""""""""""""""

"" ALE
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_info = '~~'
let g:ale_set_highlights = 1
let g:ale_set_signs = 1

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_fix_on_save = 1

let g:ale_echo_cursor = 1
" use preview window to display hover info (instead of echo)
let g:ale_hover_to_preview = 1
" use loclist instead of quickfix
let g:ale_set_loclist = 1

let g:ale_completion_enabled = 1

" Disable auto-detection of virtualenvironments. ${VIRTUAL_ENV} is always used
let g:ale_virtualenv_dir_names = []

" buffer window related keybindings
nnoremap <silent> <leader>d  :ALEGoToDefinition<CR>
nnoremap <silent> <leader>dd :ALEGoToDefinition<CR>
nnoremap <silent> <leader>dt :ALEGoToDefinitionInTab<CR>
nnoremap <silent> <leader>ds :ALEGoToDefinitionInSplit<CR>
nnoremap <silent> <leader>dv :ALEGoToDefinitionInVSplit<CR>

" preview window related keybindings
nnoremap <silent> <leader>r        :ALERename<CR>
nnoremap <silent> <leader>         :ALEHover<CR>
nnoremap <silent> <leader><leader> :ALEHover<CR>
nnoremap <silent> <leader>a        :ALEDetail<CR>
nnoremap <silent> <leader>ad       :ALEDetail<CR>
nnoremap          <leader>at       :ALEToggle<CR>
nnoremap          <leader>ai       :ALEInfo<CR>
nnoremap          <leader>as       :ALESymbolSearch<space>
nnoremap          <leader>ar       :ALEFindReferences<CR>

" loclist related keybindings
nnoremap <silent> <leader>e :lopen<CR>
nnoremap <silent> <C-j>     :ALENextWrap<CR>
nnoremap <silent> <C-k>     :ALEPreviousWrap<CR>
nnoremap <silent> <leader>J :ALELast<CR>
nnoremap <silent> <leader>K :ALEFirst<CR>

" closing loclist and pwindow
nnoremap <silent> <leader>q  :pclose<bar> :lclose<CR>
nnoremap <silent> <leader>qa :pclose<bar> :lclose<CR>
nnoremap <silent> <leader>qq :pclose<CR>
nnoremap <silent> <leader>qe :lclose<CR>

hi! link ALEErrorSign WarningMsg


""""""""""""""
"  SETTINGS  "
""""""""""""""

" line numbering
set number
set relativenumber

" enable true colors (required by material theme)
if (has('termguicolors'))
    set termguicolors
endif

" don't show mode information (lightline handles this)
set noshowmode

" command autocompletion
set wildmenu
set wildmode=longest:full,full

" insert 4 spaces instead of tab
set tabstop=4
set shiftwidth=4
set expandtab

set smarttab
set autoindent

set ignorecase
set smartcase

set splitbelow
set splitright

set scrolloff=3
set sidescroll=5

set lazyredraw
set mouse=n
set textwidth=120
set updatetime=100
set previewheight=5

set formatoptions+=rjc formatoptions-=o
set tags^=./.git/tags

" hide buffers instead of abandoning them
set hidden


""""""""""""""
"  COMMANDS  "
""""""""""""""

command! Mkdir !mkdir -p %:p:h


"""""""""""""
"  AUTOCMD  "
"""""""""""""

if has('nvim') || has('gui_running')
    augroup FZFHideStatus
        autocmd! FileType fzf
        autocmd FileType fzf set laststatus=0
                    \ | autocmd BufLeave <buffer> set laststatus=2
    augroup End
endif

" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif


"""""""""""
"  THEME  "
"""""""""""

colorscheme atlas
let g:lightline.colorscheme = 'atlas'

augroup StatusLineUpdate
    autocmd!
    if exists('*lightline#colorscheme')
        autocmd ColorScheme * call lightline#colorscheme()
    endif
    if exists('*lightline#update')
        autocmd BufAdd,BufWritePost,VimResized * call lightline#update()
    endif
augroup END


""""""""""""
"  BUGFIX  "
""""""""""""

nohlsearch
