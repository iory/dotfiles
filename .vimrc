set number
inoremap <special> fd <ESC>

set tabstop=4
set shiftwidth=4
set expandtab

nnoremap Y y$

if (has("termguicolors"))
  set termguicolors
endif
set background=dark
colorscheme spacemacs-theme
