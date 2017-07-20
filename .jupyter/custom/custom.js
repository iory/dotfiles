// Configure CodeMirror
require([
  'nbextensions/vim_binding/vim_binding',   // depends your installation
], function() {
  // Map fd to <Esc>
  CodeMirror.Vim.map("fd", "<Esc>", "insert");
  // Swap j/k and gj/gk (Note that <Plug> mappings)
  CodeMirror.Vim.map("j", "<Plug>(vim-binding-gj)", "normal");
  CodeMirror.Vim.map("k", "<Plug>(vim-binding-gk)", "normal");
  CodeMirror.Vim.map("gj", "<Plug>(vim-binding-j)", "normal");
  CodeMirror.Vim.map("gk", "<Plug>(vim-binding-k)", "normal");
  CodeMirror.Vim.map("<C-h>", "<Delete>", "normal");

  // Emacs like binding
  CodeMirror.Vim.map("<C-a>", "<Esc>^i", "insert");
  CodeMirror.Vim.map("<C-e>", "<Esc>$a", "insert");
  CodeMirror.Vim.map("<C-f>", "<Esc>2li", "insert");
  CodeMirror.Vim.map("<C-b>", "<Esc>i", "insert");
  CodeMirror.Vim.map("<C-d>", "<Esc>lxi", "insert");
  CodeMirror.Vim.map("<C-h>", "<Esc>xi", "insert");
});
