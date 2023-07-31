(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

(setq scroll-conservatively most-positive-fixnum)      ; Always scroll by one line
(setq hscroll-step 1)
(setq inhibit-startup-screen t) 
(setq font-lock-maximum-decoration t)
(setq dired-listing-switches
      "-l --group-directories-first")

;; (global-undo-tree-mode)
(global-display-line-numbers-mode) 
(global-set-key (kbd "C-=") 'text-scale-increase)

(global-set-key (kbd "C--") 'text-scale-decrease)
(global-hl-line-mode 1)

(setq-default tab-width 2)
;; (setq-default line-spacing 0.2)
;; (setq-default 'truncate-lines nil)
;; (setq undo-tree-auto-save-history t)
;; (setq undo-tree-history-directory-alist '(("." . ,temporary-file-directory)))
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(setq display-line-numbers-type 'relative) 

(setq visible-bell t)
(setq ring-bell-function 'ignore)
;; (set-frame-font "Iosevka" nil t)
(set-face-attribute 'default nil :family "Iosevka" :height 125)
;; (set-face-attribute 'default nil :family "PragmataPro Mono" :height 130)
;; (set-face-attribute 'default nil :family "PragmataPro Mono" :height 140)
;; (set-frame-font "Iosevka 14" nil t)
                    
;; (set-face-attribute 'default nil :height 120)
;; (set-face-attribute 'tree-sitter-hl-face nil
;;   :slant nil)

(package-initialize)
(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))

(use-package direnv
  :custom
  (setq direnv-always-show-summary nil)
  (setq direnv-show-paths-in-summary nil)
  :config
  (direnv-mode))

;; (load "./evil")
;; (load "~/emacs/slowsplit")

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode t))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

(use-package evil-escape
  :after evil
  :config
  (evil-escape-mode))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(setq-default evil-escape-key-sequence "jk")
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
(define-key global-map (kbd "C-l") 'windmove-right)
(define-key global-map (kbd "C-h") 'windmove-left)
(define-key global-map (kbd "C-j") 'windmove-down)
(define-key global-map (kbd "C-k") 'windmove-up)

;; (global-set-key (kbd "S-K") 'find-file)
;; (global-set-key (kbd "S-F") 'find-file)

(evil-set-leader 'motion (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>e") 'dired-jump)
(evil-define-key 'normal 'global (kbd "<leader>fe") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>fb") 'consult-project-buffer)
(evil-define-key 'normal 'global (kbd "<leader>w") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>q") 'kill-buffer)
(evil-define-key 'normal 'global (kbd "<leader>fl") 'consult-ripgrep)
(evil-global-set-key 'normal (kbd "K") 'lsp-ui-doc-glance)

(evil-define-key 'normal 'global (kbd "<leader>o") (lambda () (interactive)(split-window-right) (windmove-right)))
(evil-define-key 'normal 'global (kbd "<leader>i") (lambda () (interactive)(split-window-below) (windmove-down)))

(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file)

(use-package dired
	:ensure nil
  :commands (dired dired-jump)
  ;; :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map " " 'nil))

(eval-after-load 'evil-ex
  '(evil-ex-define-cmd "W" 'save-buffer))


(use-package vertico
  :init
  (vertico-mode t)
  (setq vertico-cycle t))

(use-package orderless
  :init
  (setq completion-styles '(orderless flex)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
(use-package magit)

(use-package lsp-mode
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
  (setq lsp-file-watch-ignored '(
    "[/\\\\]\\.direnv$"
    "[/\\\\]\\.git$"
		"[/\\\\]target$"
		"[/\\\\]node_modules$"
   ))
  (setq lsp-restart 'auto-restart)
  (setq lsp-keep-workspace-alive nil)
	(add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :hook
	(rust-ts-mode . lsp-deferred)
  )

(setq lsp-eldoc-enable-hover nil)

(use-package lsp-ui
  :commands lsp-ui-mode
	:init
	(setq lsp-ui-doc-enable t)
	:config
	(setq lsp-ui-doc-position 'at-point)
	(setq lsp-ui-peek-always-show nil))

;; (use-package lsp-ui
;;   :ensure t
;;   :after lsp-mode
;;   :init
;;   (setq lsp-ui-doc-enable nil)
;; 	:config
;; 	(setq lsp-ui-doc-position 'at-point)
;;   :bind
;;   (("s-p" . 'lsp-ui-doc-show)))	

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(use-package company
  :ensure
  :custom
  (company-idle-delay 0.1) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last)))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t)
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(custom-set-faces
	`(default ((t (:foreground "#bbc2cf" :background "#232326")))))
(set-face-background 'hl-line "#2A2A31")
(set-face-background 'mode-line "#2A2A31")

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package solaire-mode
  :config
  (setq solaire-mode-auto-swap-bg t)
  (solaire-global-mode +1))

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :config
    (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
    (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
    (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

(use-package nerd-icons)
(use-package 
  :ensure nil 
  :config
  (rust-ts-mode t))

(setq treesit-font-lock-level 4)

(use-package nix-mode
  :mode "\\.nix\\'")
(use-package gruber-darker-theme)
(use-package atom-one-dark-theme)

;; (evil-define-key 'normal 'global (kbd "<leader>e") 'find-file)
(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)
	(setq completion-styles '(orderless)

(consult-customize
	 consult-ripgrep )))
