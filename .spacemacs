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
     auto-insert
     better-defaults
     c-c++
     clojure
     elpy
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
     cuda-mode
     demo-it
     dockerfile-mode
     easy-kill
     euslisp-mode
     google-this
     lispxmp
     fcitx
     irony ;; c++
     irony-eldoc ;; c++
     company-irony ;; c++
     cmake-ide ;; c++
     flycheck-irony ;; c+
     jedi
     jedi-core
     launch-mode
     openwith
     package-lint
     quickrun
     rtags ;; c++
     region-bindings-mode
     ssh-config-mode
     trr
     web-beautify
     highlight-symbol
     milkode
     smartrep
     keydef
     toml-mode
     helm-ghq
     helm-ghs
     auto-save-buffers-enhanced)
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
   dotspacemacs-whitespace-cleanup t
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

  (when (file-exists-p "~/.spacemacs.local.el")
    (load "~/.spacemacs.local.el"))
  ;; eww
  (setq eww-search-prefix "http://www.google.co.jp/search?q=")
  (defvar eww-disable-colorize t)

  ;; settings
  ;; -------------------------------------------------------------------------------------------

  (global-set-key (kbd "C-c ]") #'helm-ghq)
  (global-set-key (kbd "C-c C-]") #'helm-ghq)

  (defun server-restart ()
    (interactive)
    (server-force-delete)
    (server-start)
    )

  ;; auto-save-buffers-enhanced
  (setq auto-save-buffers-enhanced-save-scratch-buffer-to-file-p t)
  (setq auto-save-buffers-enhanced-file-related-with-scratch-buffer
        (locate-user-emacs-file "scratch"))
  (setq auto-save-buffers-enhanced-quiet-save-p t)
  (setq auto-save-buffers-enhanced-interval 1)
  (setq auto-save-buffers-enhanced-exclude-regexps '("^/ssh:" "/sudo:" "/multi:"))
  (auto-save-buffers-enhanced-include-only-checkout-path t)
  (auto-save-buffers-enhanced t)

  ;; dired
  (setq dired-dwim-target t)
  (setq dired-recursive-copies 'always)
  (setq dired-isearch-filenames t)
  (setq dired-listing-switches (purecopy "-Ahl"))
  (add-hook 'dired-load-hook (lambda ()
                               (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)))

  ;; mark settings
  (eval-after-load 'evil-maps
    '(progn
       (define-key evil-motion-state-map (kbd "C-u") 'universal-argument)))
  (setq set-mark-command-repeat-pop t)

  (require 'easy-kill)
  (global-set-key (kbd "M-w") 'easy-kill)
  (push '(?a buffer) easy-kill-alist)

  ;; add google-this
  (google-this-mode 1)

  (global-set-key (kbd "M-g M-g") #'evil-avy-goto-line)
  (global-set-key (kbd "C-;") 'evil-avy-goto-char)

  ;; Enable C-h on minibuffer
  (define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

  ;; auto chmod +x
  (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

  (cond ((eq system-type 'gnu/linux)
         (add-hook 'evil-normal-state-entry-hook
                   '(lambda ()
                      (if (string= "2\n" (shell-command-to-string "fcitx-remote"))
                          (shell-command "fcitx-remote -c"))))
         (add-hook 'focus-in-hook
                   '(lambda () (shell-command "fcitx-remote -c")))
         )
        ((eq system-type 'darwin)
         (setq browse-url-browser-function 'browse-url-default-macosx-browser)
         (when (fboundp 'mac-auto-ascii-mode)
           (mac-auto-ascii-mode 1))
         (add-hook 'evil-normal-state-entry-hook
                   '(lambda () (mac-select-input-source "com.google.inputmethod.Japanese.Roman")))
         (add-hook 'focus-in-hook
                   '(lambda () (mac-select-input-source "com.google.inputmethod.Japanese.Roman")))

         ;; change command to alt key
         (when (eq system-type 'darwin)
           (setq ns-command-modifier (quote meta)))

         )
        )

  (defun c++-print-debug (beginning end)
    (interactive "r")
    (let ((cnt 0)
          (string-length (length " std::cout << %d << std::endl;")))
      (save-excursion
        (goto-char beginning)
        (while (and (search-forward ";" nil t) (< (point) (+ (- end 1) (* cnt string-length))))
          (message "%d %d" (point) (+ end (* cnt string-length)))
          (replace-match (format "; std::cout << %d << std::endl;" cnt))
          (incf cnt)))))

  ;; parens for evil-mode
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

  ;; whitespace
  (setq whitespace-style '(face           ; faceで可視化
                           trailing       ; 行末
                           tabs           ; タブ
                           spaces         ; スペース
                           empty          ; 先頭/末尾の空行
                           space-mark     ; 表示のマッピング
                           tab-mark
                           ))


  (setq whitespace-display-mappings
        '((space-mark ?\u3000 [?\u25a1])
          ;; WARNING: the mapping below has a problem.
          ;; When a TAB occupies exactly one column, it will display the
          ;; character ?\xBB at that column followed by a TAB which goes to
          ;; the next TAB column.
          ;; If this is a problem for you, please, comment the line below.
          (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

  ;; スペースは全角のみを可視化
  (setq whitespace-space-regexp "\\(\u3000+\\)")

  ;; 保存前に自動でクリーンアップ
  (setq whitespace-action '(auto-cleanup))

  (global-whitespace-mode 1)

  (global-set-key "\C-w" 'kill-region-or-backward-kill-word)
  (global-set-key "\C-h" 'delete-backward-char)

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
  (global-set-key (kbd "C-x C-z") 'spacemacs/open-junk-file)

  (require 'smartrep)
  (smartrep-define-key global-map "C-x"
    '(("{" . shrink-window-horizontally)
      ("}" . enlarge-window-horizontally)))

  ;; avoid "Symbolic link to SVN-controlled source file; follow link? (yes or no)"
  (setq vc-follow-symlinks t)

  ;; milkode
  (global-set-key (kbd "M-g s") 'milkode:search)

  (global-set-key (kbd "C-o") 'evil-open-below)

  ;; org-mode
  ;; -------------------------------------------------------------------------------------------
  (require 'org)
  (setq org-directory "~/org")
  (setq org-capture-templates
        '(("m" "Memo" entry (file+headline "memo.org" "Memo")
           "** %U%?\n%i\n")))
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key
   (kbd "<f6>")
   (lambda () (interactive) (find-file "~/org/daily-projects.org")))

  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-span 30)
  (setq org-agenda-files '("~/org/inbox.org" "~/org/daily-projects.org"))
  (global-set-key (kbd "C-c a") 'org-agenda)
  (setq org-agenda-custom-commands
        '(("a" "Agenda and all TODO's"
           ((tags "project-CLOCK=>\"<today>\"|repeatable") (agenda "") (alltodo)))))
  (defun org-agenda-default ()
    (interactive)
    (org-agenda nil "a"))
  (global-set-key (kbd "<f6>") 'org-agenda-default)

  (defun launch-enable-keymap (&optional prefix)
    "Setup standard keybindings for the ros-launch file"
    (interactive)
    (if prefix
        (unless (string-match " $" prefix)
          (setq prefix (concat prefix " ")))
      (setq prefix "C-c r")
      )
    (define-key launch-mode-map (kbd (concat prefix ",")) 'launch-insert-node-name)
    (define-key launch-mode-map (kbd (concat prefix ".")) 'launch-goto-include-launch)
    (define-key launch-mode-map (kbd (concat prefix "[")) 'launch-location-stack-forward)
    (define-key launch-mode-map (kbd (concat prefix "]")) 'launch-location-stack-back)
    (define-key launch-mode-map (kbd "C-.") 'launch-goto-include-launch)
    )
  (add-hook 'launch-mode-hook 'launch-enable-keymap)

  (when (locate-library "company")
    (global-company-mode 1)
    (global-set-key (kbd "C-M-i") 'company-complete)
    ;; (setq company-idle-delay nil) ;; disable auto completion
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (define-key company-search-map (kbd "C-n") 'company-select-next)
    (define-key company-search-map (kbd "C-p") 'company-select-previous)
    (define-key company-active-map (kbd "<tab>") 'company-complete-selection)
    (define-key company-active-map (kbd "C-i") 'company-complete-selection)
    (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete))

  ;; anzu
  (global-set-key [remap query-replace] 'anzu-query-replace)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)

  ;; helm settings
  ;; -------------------------------------------------------------------------------------------
  (define-key global-map (kbd "C-x b") 'helm-for-files)

  ;; helm ag
  (setq helm-ag-base-command "rg --vimgrep --no-heading") ; use ripgrep
  (setq helm-ag-insert-at-point 'symbol)
  (global-set-key (kbd "C-M-g") 'helm-ag)
  (global-set-key (kbd "C-M-k") 'backward-kill-sexp)

  (defun helm-ag-dotfiles ()
    "search .dotfiles"
    (interactive)
    (helm-ag "~/.dotfiles/"))
  (defun helm-projectile-ag ()
    "Projectile"
    (interactive)
    (helm-ag (projectile-project-root)))

  ;; C/C++
  ;; -------------------------------------------------------------------------------------------
  ;; c-mode
  (setq-default c-basic-offset 4
                tab-width 4
                indent-tabs-mode nil)
  ;; C++ style
  (add-hook 'c++-mode-hook
            '(lambda()
               (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
               ))

  (eval-after-load "flycheck"
    '(progn
       (when (locate-library "flycheck-irony")
         (flycheck-irony-setup))))
  (rtags-enable-standard-keybindings c-mode-base-map)

  ;; python
  ;; -------------------------------------------------------------------------------------------
  ;; jedi
  (add-hook 'python-mode-hook 'jedi:setup)
  (pyvenv-activate venv-default)
  (elpy-use-ipython)
  (setq elpy-rpc-backend "jedi")
  (define-key elpy-mode-map (kbd "C-c C-v") 'helm-flycheck)
  (require 'smartrep)
  (smartrep-define-key elpy-mode-map "C-c"
                       '(("C-n" . flycheck-next-error)
                         ("C-p" . flycheck-previous-error)))

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

  (define-key evil-normal-state-map (kbd "v") #'er/expand-region)

  (define-key evil-normal-state-map (kbd "H") #'mwim-beginning-of-code-or-line)
  (define-key evil-normal-state-map (kbd "L") #'mwim-end-of-line-or-code)

  ;; quickrun
  ;; -------------------------------------------------------------------------------------------
  (push '("*quickrun*") popwin:special-display-config)
  (global-set-key (kbd "<f5>") 'quickrun)
  (global-set-key (kbd "C-'") 'quickrun)

  ;; Add C++ command for C11 and set it default in C++ file.
  (quickrun-add-command "c++/clang++"
                        '((:command . "g++")
                          (:exec . ("%c -std=c++11 -lstdc++ %o -o %e %s"
                                    "%e %a"))
                          (:remove . ("%e")))
                        :default "c++")
  (quickrun-set-default "c++" "c++/clang++")

  (quickrun-add-command "roseus"
                        '((:command . "roseus")
                          (:exec . ("%c %s")))
                        :mode 'Euslisp-mode
                        :default "Euslisp")
  (quickrun-set-default "Euslisp" "roseus")

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

  ;; disable highlight current line
  (global-hl-line-mode -1)

  ;; load shellenv
  ;; -------------------------------------------------------------------------------------------
  (when (file-exists-p "~/.emacs.d/shellenv.el")
    (load "~/.emacs.d/shellenv.el"))
  )
