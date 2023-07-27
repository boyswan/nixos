(column-number-mode t)
(setq scroll-conservatively most-positive-fixnum)      ; Always scroll by one line
(setq scroll-margin 5)                                ; Add a margin when scrolling vertically

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t) 
(setq font-lock-maximum-decoration t)
(setq dired-listing-switches
    "-l --group-directories-first")

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode) 
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-hl-line-mode 1)

(setq visible-bell t)
(setq ring-bell-function 'ignore)
(set-frame-font "Iosevka 12" nil t)
(set-face-attribute 'default nil :height 140)

(package-initialize)
(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))

(use-package direnv
  :custom
  (setq direnv-always-show-summary nil)
  ;; (setq direnv-show-paths-in-summary nil)
  :config
  (direnv-mode))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode t))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file)

(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-cycle t))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package magit
  :ensure)

(use-package lsp-mode
  :ensure
  ;; :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  ;; (lsp-inlay-hint-enable t)
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  ;; (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  ;; (lsp-rust-analyzer-display-chaining-hints t)
  ;; (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  ;; (lsp-rust-analyzer-display-closure-return-type-hints t)
  ;; (lsp-rust-analyzer-display-parameter-hints nil)
  ;; (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  )

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t)
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(custom-set-faces `(fringe ((t (:background nil))))) 

(use-package tree-sitter 
  :ensure t 
  :diminish 
  :config (global-tree-sitter-mode) 
  :hook (tree-sitter-mode . tree-sitter-hl-mode))

(use-package tree-sitter-langs 
  :ensure t 
  :after tree-sitter)

(global-tree-sitter-mode)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package solaire-mode
  :ensure t
  :config
  (setq solaire-mode-auto-swap-bg t)
  (solaire-global-mode +1))

(use-package git-gutter
  :ensure t 
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :ensure t 
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(use-package nerd-icons)
