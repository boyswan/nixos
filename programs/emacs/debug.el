(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :commands (dirvish)
  :config
	(setq dirvish-use-header-line 'global)    ; make header line span all panes

  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-attributes
        '(file-time file-size collapse subtree-state vc-state)))
  ;; (setq dired-listing-switches
  ;;       "-l --almost-all --human-readable --group-directories-first --no-group"))
