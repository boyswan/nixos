(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq scroll-conservatively most-positive-fixnum)      ; Always scroll by one line (setq hscroll-step 1)
(setq inhibit-startup-screen t) 
(setq font-lock-maximum-decoration t)
(setq dired-listing-switches "-l --group-directories-first")
(setq-default pgtk-wait-for-event-timeout 0)
;; (global-undo-tree-mode)
(global-display-line-numbers-mode) 
(global-set-key (kbd "C-=") 'text-scale-increase)

(global-set-key (kbd "C--") 'text-scale-decrease)
(global-hl-line-mode 1)

(setq-default truncate-lines t)
(global-visual-line-mode nil)
(setq-default tab-width 2)
(setq evil-shift-width 2)
(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
(setq delete-old-versions t)
(setq-default create-lockfiles nil)
(setq version-control t)
;; (setq auto-save-file-name-transforms `((".*" "~/.emacs-d/autosaves" t)))

(setq display-line-numbers-type 'relative) 

(setq visible-bell t)
(setq ring-bell-function 'ignore)
(set-face-attribute 'default nil :family "Iosevka" :height 120)

(package-initialize)
(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))

(use-package direnv
  :init
  (setq direnv-always-show-summary nil)
  (setq direnv-show-paths-in-summary nil)
  :config
  (direnv-mode))

;; (load "./evil")
;; (load "~/emacs/slowsplit")

(use-package better-jumper)
(better-jumper-mode +1)

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

(use-package undo-tree
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

(defun toggle-fullscreen-buffer () "Fullscreen buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(setq-default evil-escape-key-sequence "jk")
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
(define-key global-map (kbd "C-l") 'windmove-right)
(define-key global-map (kbd "C-h") 'windmove-left)
(define-key global-map (kbd "C-j") 'windmove-down)
(define-key global-map (kbd "C-k") 'windmove-up)

(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "C-o") 'better-jumper-jump-backward)
  (define-key evil-motion-state-map (kbd "C-i") 'better-jumper-jump-forward))
;; (defun dirvish-window-cond ()
;; 	(cond ((one-window-p 'dirvish)
;; 				(t (
;; 					('dirvish)
;; 					('dirvish-layout-toggle))))

(defun sized-dirvish () "Simple dirvish when multi window"
  (interactive)
  (if (= 1 (length (window-list)))
    (progn
			(setq-default dirvish-default-layout '(0.2 0.3 0.5))
      (dirvish))
    (progn
			(setq-default dirvish-default-layout '(0 1.0 0))
      (dirvish))))

(evil-set-leader 'motion (kbd "SPC"))
;; (evil-define-key 'normal 'global (kbd "<leader>e") 'sized-dirvish)
(evil-define-key 'normal 'global (kbd "<leader>e") 'dirvish)
(evil-define-key 'normal 'global (kbd "C-f") 'toggle-fullscreen-buffer)
(evil-define-key 'normal 'global (kbd "<leader>fe") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>fb") 'consult-project-buffer)
(evil-define-key 'normal 'global (kbd "<leader>w") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>q") 'kill-buffer)
(evil-define-key 'normal 'global (kbd "<leader>fl") 'consult-ripgrep)
(evil-define-key 'normal 'global (kbd "<leader>o") (lambda () (interactive)(split-window-right) (windmove-right)))
(evil-define-key 'normal 'global (kbd "<leader>i") (lambda () (interactive)(split-window-below) (windmove-down)))


;; (use-package dired
;; 	:ensure nil
;;   ;; :commands (dired dired-jump)
;;   ;; :custom ((dired-listing-switches "-agho --group-directories-first"))
;;   ;; :config
;;   ;; (kbd " ") 'nil)
;;   )

(eval-after-load 'evil-ex
  '(evil-ex-define-cmd "W" 'save-buffer))

(use-package vertico
:init
  (vertico-mode t)
  (setq vertico-cycle t))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t)
  ;; (load-theme 'doom-one t)
  (doom-themes-org-config))

(custom-set-faces
	`(default ((t (:foreground "#bbc2cf" :background "#232326")))))
(set-face-background 'hl-line "#2A2A31")
(set-face-background 'mode-line "#2A2A31")
(set-face-background 'line-number "#232326")

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
	(setq doom-modeline-buffer-file-name-style 'relative-to-project))

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
(use-package rust-ts-mode)
(use-package typescript-ts-mode
  :config
  ;; we choose this instead of tsx-mode so that eglot can automatically figure out language for server
  ;; see https://github.com/joaotavora/eglot/issues/624 and https://github.com/joaotavora/eglot#handling-quirky-servers
  (define-derived-mode typescriptreact-mode typescript-ts-mode
    "TypeScript TSX")

  ;; use our derived mode for tsx files
  (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
  ;; by default, typescript-mode is mapped to the treesitter typescript parser
  ;; use our derived mode to map both .tsx AND .ts -> typescriptreact-mode -> treesitter tsx
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx)))

(use-package go-ts-mode)
(setq go-ts-mode-indent-offset 2)

(use-package web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))


;; (add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))
(setq treesit-font-lock-level 3)

(use-package nix-mode
  :mode "\\.nix\\'")

;; (use-package gruber-darker-theme)

;; (add-hook 'after-init-hook (lambda () (load-theme 'gruber-darker-theme t)))

(use-package atom-one-dark-theme)
(use-package iedit)
(load-theme 'atom-one-dark t)

;; (evil-define-key 'normal 'global (kbd "<leader>e") 'find-file)
(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.1)
  (setq register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)
	(setq completion-styles '(orderless)
				(consult-customize
				 consult-ripgrep )))


(use-package orderless
  :init
  (setq completion-styles '(orderless flex)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
(use-package magit)


(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; (use-package corfu
;; 	:custom
;; 	(corfu-separator ?\s)
;;   :init
;;   (global-corfu-mode))

;; (setq corfu-auto t
;; 	corfu-auto-delay 0.1
;; 	;; corfu-auto-prefix 0
;; 	completion-styles '(flex))

;; (use-package eglot
;;   :hook
;; 		((rust-ts-mode) . eglot-ensure)
;; 		((eglot-managed-mode) . (evil-define-key 'normal 'global (kbd "K") 'eldoc-box-help-at-point))
;; 	:init
;; 	(evil-define-key 'normal 'global (kbd "<leader>f") 'eglot-format-buffer)
;;   :config (add-to-list 'eglot-server-programs
;;                        `(rust-ts-mode . ("rust-analyzer" :initializationOptions
;;                                      ( :procMacro (:enable t)
;;                                        :cargo ( 
;;                                                :features "all"))))))

;; (setq eldoc-echo-area-use-multiline-p nil)
;; (use-package markdown-mode)

;; (use-package eldoc-box)
;; (global-eldoc-mode -1)

;; (evil-define-key 'normal 'global (kbd "K") 'eldoc-box-help-at-point)
;; (add-hook 'eglot-managed-mode-hook (evil-define-key 'normal 'global (kbd "K") 'eldoc-box-help-at-point))


(use-package lsp-mode
	;; :commands lsp
	:custom
	(lsp-rust-analyzer-cargo-watch-command "clippy")
	(lsp-eldoc-render-all t)
	(lsp-idle-delay 0.6)
	:config
	(setq lsp-file-watch-ignored '(
		"[/\\\\]\\.direnv$"
		"[/\\\\]\\.git$"
		"[/\\\\]target$"
		))
	(setq lsp-restart 'auto-restart)
	(setq lsp-keep-workspace-alive t)
	(setq lsp-lens-enable nil)
	(setq lsp-eldoc-enable-hover nil)
	(setq lsp-headerline-breadcrumb-enable nil)
	(add-hook 'lsp-mode-hook 'lsp-ui-mode)
	:hook
	(go-ts-mode . lsp-deferred)
	(typescript-ts-mode . lsp-deferred)
	(rust-ts-mode . lsp-deferred))

(setq lsp-eldoc-enable-hover nil)

(use-package lsp-ui
  :commands lsp-ui-mode
	:init
	(setq lsp-ui-doc-enable t)
	(setq lsp-ui-sideline-mode t)
	(setq lsp-ui-sideline-diagnostics-max-lines 6)
	:config
	(setq lsp-ui-doc-position 'at-point)
	(setq lsp-ui-peek-always-show nil))

(evil-global-set-key 'normal (kbd "K") 'lsp-ui-doc-glance)


(use-package company)
(use-package flycheck)

(add-hook 'after-init-hook 'global-flycheck-mode)
;; (add-hook 'after-init-hook 'global-company-mode)
(add-hook 'lsp-mode-hook (evil-define-key 'normal 'global (kbd "<leader>ff") 'lsp-format-buffer))

;; (use-package dired
;; 	:ensure nil
;;   :commands (dired dired-jump))

;; (add-hook 'dired-mode-hook (lambda () (unless 'one-window-p 'dirvish-layout-toggle)))
;; (add-hook 'dired-mode-hook (lambda ()  (dirvish-layout-toggle)))

(evil-define-key 'normal dired-mode-map
  (kbd "f") 'dirvish-fd
  (kbd "r") 'dirvish-layout-toggle
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file
  (kbd "q") 'dirvish-quit
  (kbd "s") 'dirvish-subtree-clear
  (kbd "e") 'dirvish-layout-toggle
  (kbd "SPC") 'dirvish-subtree-toggle
  (kbd "r") 'rename-file
  (kbd "c") 'dired-do-copy
  (kbd "w") 'dired-create-empty-file
  (kbd "y") 'dirvish-yank
	)

;; (defun sized-dirvish () "Simple dirvish when multi window"
;;   (interactive)
;;   (if (< 1 (length (window-list)))
;;       (dirvish-layout-toggle)))

;; (add-hook 'dirvish-setup-hook 'sized-dirvish)

(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :commands (dirvish)
  :config
	(setq dirvish-use-header-line 'global)    ; make header line span all panes

  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-attributes
        '(file-time file-size subtree-state)))
u ;; (setq dired-listing-switches
  ;;       "-l --almost-all --human-readable --group-directories-first --no-group"))


