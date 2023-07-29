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


(evil-set-leader 'motion (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>e") 'dired-jump)
(evil-define-key 'normal 'global (kbd "<leader>fe") 'find-file)
;; (evil-define-key 'normal 'global 'dired-mode-map (kbd "<leader>fe") 'find-file)
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file)

(eval-after-load 'evil-ex
  '(evil-ex-define-cmd "W" 'save-buffer))

(eval-after-load 'evil-ex
  '(evil-ex-define-cmd "Q" 'kill-emacs))
