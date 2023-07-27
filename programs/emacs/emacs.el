
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t) 

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(set-face-attribute 'default nil :height 140)

(package-initialize)
(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))


;;; Vim Bindings
(use-package evil
  ;; :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  ;; (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  ;; (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode t))

(use-package direnv
 :config
 (direnv-mode))

(use-package lsp-mode
  :ensure
  ;; :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-inlay-hint-enable t)
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  :config
  )
;; (use-package evil
;;   :chords (("jk" . evil-normal-state)
;;            ))
;;; Vim Bindings Everywhere else
;; (use-package evil-collection
;;   :after evil
;;   :config
;;   (setq evil-want-integration t)
;;   (evil-collection-init))
