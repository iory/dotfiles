;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     auto-completion
     csv
     bibtex
     rust
     html
     octave
     vimscript
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; auto-insert
     better-defaults
     (c-c++ :variables c-c++-enable-clang-support t)
     clojure
     go
     python
     php
     emacs-lisp
     git
     github
     markdown
     yaml
     org
     dash
     latex
     haskell
     gtags
     javascript
     spell-checking
     shell-scripts
     syntax-checking
     version-control
     (spell-checking :variables spell-checking-enable-by-default nil)
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     replace-from-region
     bind-key
     demo-it
     easy-kill
     google-this
     fcitx
     quickrun
     smartrep
     trr
     web-beautify
     highlight-symbol
     milkode
     keydef
     company-dict
     py-autopep8
     ;; mode
     launch-mode
     ssh-config-mode
     dockerfile-mode
     toml-mode
     euslisp-mode
     cuda-mode
     region-bindings-mode
     ;; emacs-lisp
     lispxmp
     package-lint
     ;; c++
     cmake-ide
     rtags
     company-rtags
     ;; helm
     helm-ghq
     helm-ghs
     helm-flycheck)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'hybrid
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'emacs-lisp-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         alect-black
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("DejaVu Sans Mono"
                               :size 15
                               :weight normal
                               :width normal
                               :powerline-scale 1.0)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido 'helm
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'all
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (setq custom-file "~/.emacs.d/.cache"))

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place you code here."

  ;; load local settings
  ;; -------------------------------------------------------------------------------------------
  (when (file-exists-p "~/.spacemacs.local.el")
    (load "~/.spacemacs.local.el"))
  (evil-leader/set-key
    "fes" '(lambda () (interactive) (find-file "~/.spacemacs.local.el")))

  ;; settings
  ;; -------------------------------------------------------------------------------------------

  ;; disable highlight current line
  (global-hl-line-mode -1)

  (defun kill-region-or-backward-kill-word ()
    (interactive)
    (if (region-active-p)
        (kill-region (point) (mark))
      (backward-kill-word 1)))

  (global-set-key "\C-w" 'kill-region-or-backward-kill-word)

  (defun other-window-or-split ()
    (interactive)
    (when (one-window-p)
      (split-window-horizontally))
    (other-window 1))

  (global-set-key (kbd "C-t") 'other-window-or-split)

  (global-set-key "\C-h" 'delete-backward-char)

  (setq whitespace-space-regexp "\\(\u3000+\\)")

  (global-set-key (kbd "C-c ]") #'helm-ghq)
  (global-set-key (kbd "C-c C-]") #'helm-ghq)

  ;; Enable C-h on minibuffer
  (define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

  ;; auto chmod +x
  (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

  ;; avoid "Symbolic link to SVN-controlled source file; follow link? (yes or no)"
  (setq vc-follow-symlinks t)

  (setq set-mark-command-repeat-pop t)

  ;; open junk file
  (global-set-key (kbd "C-x C-z") 'spacemacs/open-junk-file)

  (global-set-key (kbd "C-l") 'er/expand-region)
  (global-set-key (kbd "C-M-l") 'er/contract-region)

  (defun region-to-single-quote ()
    (interactive)
    (quote-formater "'%s'" "^\\(\"\\).*" ".*\\(\"\\)$"))
  (defun region-to-double-quote ()
    (interactive)
    (quote-formater "\"%s\"" "^\\('\\).*" ".*\\('\\)$"))
  (defun region-to-bracket ()
    (interactive)
    (quote-formater "\(%s\)" "^\\(\\[\\).*" ".*\\(\\]\\)$"))
  (defun region-to-square-bracket ()
    (interactive)
    (quote-formater "\[%s\]" "^\\(\(\\).*" ".*\\(\)\\)$"))
  (defun quote-formater (quote-format re-prefix re-suffix)
    (if mark-active
        (let* ((region-text (buffer-substring-no-properties (region-beginning) (region-end)))
               (replace-func (lambda (re target-text)(replace-regexp-in-string re "" target-text nil nil 1)))
               (text (funcall replace-func re-suffix (funcall replace-func re-prefix region-text))))
          (delete-region (region-beginning) (region-end))
          (insert (format quote-format text)))
      (error "Not Region selection")))

  (require 'region-bindings-mode)
  (region-bindings-mode-enable)
  (define-key region-bindings-mode-map (kbd "M-'") 'region-to-single-quote)
  (define-key region-bindings-mode-map (kbd "M-\"") 'region-to-double-quote)
  (define-key region-bindings-mode-map (kbd "M-9") 'region-to-bracket)
  (define-key region-bindings-mode-map (kbd "M-[") 'region-to-square-bracket)
  (define-key region-bindings-mode-map (kbd "C-s") 'search-selection)
  (define-key region-bindings-mode-map (kbd "C-r") 'search-selection)
  (define-key region-bindings-mode-map (kbd "q") 'query-replace-from-region)
  (define-key region-bindings-mode-map (kbd "C-q") 'query-replace-regexp-from-region)
  (define-key region-bindings-mode-map (kbd ".") 'highlight-symbol-at-point)

  ;; for region-bindings-mode-map
  (defun search-selection (from to)
    "search for selected text"
    (interactive "r") ;; select region
    (let ((selection (buffer-substring-no-properties from to)))
      (deactivate-mark)
      (region-bindings-mode-off)
      (isearch-mode t nil nil nil)
      (isearch-yank-string selection)))

  ;; anzu
  (global-set-key [remap query-replace] 'anzu-query-replace)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)

  ;; easy-kill
  (global-set-key (kbd "M-w") 'easy-kill)
  ;; (push '(?a buffer) easy-kill-alist)

  ;; highlight-symbol
  (add-hook 'prog-mode-hook 'highlight-symbol-mode)
  (add-hook 'prog-mode-hook 'highlight-symbol-nav-mode)
  (global-set-key (kbd "M-s M-r") 'highlight-symbol-query-replace)
  (global-set-key (kbd "M-l") 'highlight-symbol-at-point)
  (global-set-key (kbd "M-[") 'highlight-symbol-remove-all)
  (add-hook 'highlight-symbol-hook
            'evil-normal-state)
  (add-hook 'highlight-symbol-jump-hook
            'evil-normal-state)
  (setq highlight-symbol-idle-delay 0.7)
  (setq highlight-symbol-colors
        '("GreenYellow" "chartreuse4" "gold1" "red1" "cyan" "RoyalBlue" "PaleGreen"))
  (setq highlight-symbol-foreground-color "black")

  ;; eww
  (setq eww-search-prefix "http://www.google.co.jp/search?q=")
  (defvar eww-disable-colorize t)

  ;; when into normal mode, turn input source into english
  (cond ((eq system-type 'gnu/linux)
         (add-hook 'evil-normal-state-entry-hook
                   '(lambda ()
                      (if (string= "2\n" (shell-command-to-string "fcitx-remote"))
                          (shell-command "fcitx-remote -c"))))
         (add-hook 'focus-in-hook
                   '(lambda () (shell-command "fcitx-remote -c"))))
        ((eq system-type 'darwin)
         (setq browse-url-browser-function 'browse-url-default-macosx-browser)
         (when (fboundp 'mac-auto-ascii-mode)
           (mac-auto-ascii-mode 1))
         (add-hook 'evil-normal-state-entry-hook
                   '(lambda () (mac-select-input-source "com.google.inputmethod.Japanese.Roman")))
         (add-hook 'focus-in-hook
                   '(lambda () (mac-select-input-source "com.google.inputmethod.Japanese.Roman")))

         ;; change command to alt key
         (setq ns-command-modifier (quote meta))))

  ;; evil extend
  ;; -------------------------------------------------------------------------------------------
  (define-key evil-normal-state-map (kbd "H") #'mwim-beginning-of-code-or-line)
  (define-key evil-normal-state-map (kbd "L") #'mwim-end-of-line-or-code)

  (global-set-key (kbd "M-g M-g") #'evil-avy-goto-line)
  (global-set-key (kbd "C-;") 'evil-avy-goto-char)

  (global-set-key (kbd "C-o") 'evil-open-below)

  ;; mark settings
  (define-key evil-motion-state-map (kbd "C-u") 'universal-argument)

  (require 'smartrep)

  ;; helm settings
  ;; -------------------------------------------------------------------------------------------
  (define-key global-map (kbd "C-x b") 'helm-for-files)

  ;; helm ag
  (setq helm-ag-base-command "rg --vimgrep --no-heading -uu") ; use ripgrep
  (setq helm-ag-insert-at-point 'symbol)
  (global-set-key (kbd "C-M-g") 'helm-ag)

  (defun helm-ag-dotfiles ()
    "search .dotfiles"
    (interactive)
    (helm-ag "~/.dotfiles/"))
  (defun helm-projectile-ag ()
    "Projectile"
    (interactive)
    (helm-ag (projectile-project-root)))

  ;; company settings
  ;; -------------------------------------------------------------------------------------------
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)

  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-d") 'company-show-doc-buffer)
  (define-key company-active-map (kbd "C-i") 'company-complete-selection)
  (define-key company-active-map (kbd "C-s") 'company-filter-candidates)
  (define-key company-active-map (kbd "<tab>") 'company-complete)

  ;; company dict
  (add-to-list 'company-backends 'company-dict)
  (setq company-dict-dir (concat user-emacs-directory "private/dict/"))

  ;; emacs lisp settings
  ;; -------------------------------------------------------------------------------------------
  (add-hook 'emacs-lisp-mode-hook
            '(lambda ()
               (define-key emacs-lisp-mode-map (kbd "C-c .") 'describe-function)))

  ;; python settings
  ;; -------------------------------------------------------------------------------------------
  (add-hook 'anaconda-mode-hook 'flycheck-mode)
  (add-hook 'anaconda-mode-hook
            '(lambda ()
               (define-key anaconda-mode-map (kbd "C-c .") 'anaconda-mode-find-assignments)
               (define-key anaconda-mode-map (kbd "C-c z") 'python-shell-send-buffer-switch)
               (define-key anaconda-mode-map (kbd "C-c s") 'python-shell-send-region)
               (define-key anaconda-mode-map (kbd "C-c C-s") 'python-shell-send-region)
               (define-key anaconda-mode-map (kbd "C-c ,") 'anaconda-mode-go-back)

               (define-key anaconda-mode-map (kbd "C-c C-v") 'helm-flycheck)
               (define-key anaconda-mode-map (kbd "C-M-i") 'anaconda-mode-complete)
               (smartrep-define-key anaconda-mode-map "C-c"
                 '(("C-n" . flycheck-next-error)
                   ("C-p" . flycheck-previous-error)))))

  ;; c++ settings
  ;; -------------------------------------------------------------------------------------------
  ;; style
  (c-set-offset 'innamespace 0)
  (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode nil)

  (defun flycheck-rtags-setup ()
    (flycheck-select-checker 'rtags)
    (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
    (setq-local flycheck-check-syntax-automatically nil))
  (add-hook 'c-mode-hook #'flycheck-rtags-setup)
  (add-hook 'c++-mode-hook #'flycheck-rtags-setup)

  (add-hook 'c++-mode-hook
            '(lambda ()
               ;; rtags
               (setq rtags-autostart-diagnostics t)
               (rtags-diagnostics)
               (setq rtags-completions-enabled t)
               (push 'company-rtags company-backends)
               (setq rtags-display-result-backend 'helm)
               (rtags-enable-standard-keybindings c-mode-base-map)

               ;;  clang-format binding
               ;; (define-key c++-mode-map [tab] 'clang-format-buffer)

               (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))

               (define-key c++-mode-map (kbd "C-c .") 'rtags-find-symbol-at-point)
               (define-key c++-mode-map (kbd "C-c ,") 'rtags-location-stack-back)

               (define-key c++-mode-map (kbd "C-c C-v") 'helm-flycheck)
               (define-key c++-mode-map (kbd "C-M-i") 'company-clang)
               (smartrep-define-key c++-mode-map "C-c"
                                    '(("C-n" . flycheck-next-error)
                                      ("C-p" . flycheck-previous-error)))))
  (spacemacs/add-to-hooks '(lambda () (add-hook 'before-save-hook 'clang-format-buffer nil t))
                          '(c-mode-hook c++-mode-hook))

  ;; euslisp settings
  ;; -------------------------------------------------------------------------------------------
  (add-hook 'euslisp-mode-hook
            '(lambda ()
               (define-key euslisp-mode-map (kbd "C-c .") 'euslisp-find-definition-function)
               (define-key euslisp-mode-map (kbd "C-c z") 'euslisp-switch-to-shell)
               (define-key euslisp-mode-map (kbd "C-c s") 'euslisp-shell-send-region)
               (define-key euslisp-mode-map (kbd "C-c C-s") 'euslisp-shell-send-region)
               (define-key euslisp-mode-map (kbd "C-c ,") 'helm-ag-pop-stack)))

  ;; ROS
  ;; -------------------------------------------------------------------------------------------
  (setq auto-mode-alist
        (cons (cons "\\.cfg" 'python-mode) auto-mode-alist))

  ;; Makefile
  ;; -------------------------------------------------------------------------------------------
  (setq auto-mode-alist
        (append '(("Makefile\\..*$" . makefile-gmake-mode)
                  ("Makefile_.*$" . makefile-gmake-mode)
                  ) auto-mode-alist))

  ;; quickrun
  ;; -------------------------------------------------------------------------------------------
  (defun quickrun-maybe-region ()
    "Run region or buffer, depending on current evil state."
    (interactive)
    (cond
     ((eq evil-state 'visual)
      (quickrun-region (region-beginning) (region-end)))
     (t
      (quickrun))))

  (push '("*quickrun*") popwin:special-display-config)
  (evil-define-key 'normal quickrun/mode-map
    "q" 'delete-window)
  (evil-leader/set-key
    "cqq" 'quickrun-maybe-region
    "cqr" 'quickrun-replace-region
    "cqa" 'quickrun-with-arg
    "cqs" 'quickrun-shell)
  (global-set-key (kbd "<f5>") 'quickrun-maybe-region)

  )
