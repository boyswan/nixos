(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

(setq scroll-conservatively most-positive-fixnum)      ; Always scroll by one line
(setq hscroll-step 1)
(setq inhibit-startup-screen t) 
(setq font-lock-maximum-decoration t)
(setq dired-listing-switches "-l --group-directories-first")

;; (global-undo-tree-mode)
(global-display-line-numbers-mode) 
(global-set-key (kbd "C-=") 'text-scale-increase)

(global-set-key (kbd "C--") 'text-scale-decrease)
(global-hl-line-mode 1)

(setq-default tab-width 2)
(setq evil-shift-width 2)
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(setq display-line-numbers-type 'relative) 

(setq visible-bell t)
(setq ring-bell-function 'ignore)
(set-face-attribute 'default nil :family "Iosevka" :height 120)

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

(use-package undo-tree
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

(setq-default evil-escape-key-sequence "jk")
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
(define-key global-map (kbd "C-l") 'windmove-right)
(define-key global-map (kbd "C-h") 'windmove-left)
(define-key global-map (kbd "C-j") 'windmove-down)
(define-key global-map (kbd "C-k") 'windmove-up)

(evil-set-leader 'motion (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>e") 'dired-jump)
(evil-define-key 'normal 'global (kbd "<leader>fe") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>fb") 'consult-project-buffer)
(evil-define-key 'normal 'global (kbd "<leader>w") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>q") 'kill-buffer)
(evil-define-key 'normal 'global (kbd "<leader>fl") 'consult-ripgrep)
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
(use-package rust-ts-mode)
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
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
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



(use-package eglot
  :hook ((rust-ts-mode) . eglot-ensure)
	:init
	(evil-define-key 'normal 'global (kbd "<leader>f") 'eglot-format-buffer)
  :config (add-to-list 'eglot-server-programs
                       `(rust-ts-mode . ("rust-analyzer" :initializationOptions
                                     ( :procMacro (:enable t)
                                       :cargo ( 
                                               :features "all"))))))

(setq eldoc-echo-area-use-multiline-p nil)
(use-package markdown-mode)
(use-package eldoc-box)

(eval-after-load "eldoc"
	'(evil-define-key 'normal 'global (kbd "K") 'eldoc-box-help-at-point))

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(use-package corfu
  :init
  (global-corfu-mode))

(setq corfu-auto t
            corfu-auto-delay 0
            corfu-auto-prefix 0
            completion-styles '(basic))
