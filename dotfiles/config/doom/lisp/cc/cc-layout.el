(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  :config
  ;; Evil-specific settings
  (setq doom-modeline-modal-icon t)          ; Show modal state icon (Normal, Insert, Visual)
  (setq doom-modeline-modal-state-icon-location 'left) ; Display state icon on the left

  ;; Visual tweaks
  (setq doom-modeline-height 25)             ; Set modeline height (in pixels)
  (setq doom-modeline-bar-width 4)           ; Set left border bar width
  (setq doom-modeline-hud nil)               ; Disable HUD scrollbar
  (setq doom-modeline-icon t)                ; Enable all icons (requires `all-the-icons`)
  (setq doom-modeline-major-mode-icon t)     ; Show major mode icon
  (setq doom-modeline-major-mode-color-icon t) ; Colorize major mode icon

  ;; Information display
  (setq doom-modeline-buffer-file-name-style 'auto) ; Truncate file paths intelligently
  (setq doom-modeline-buffer-state-icon t)   ; Show read-only/modified icons
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-minor-modes nil)       ; Hide minor modes to keep it clean
  (setq doom-modeline-enable-word-count nil) ; Set to t for org/markdown modes if needed
  (setq doom-modeline-vcs-max-length 12)     ; Truncate long git branch names
  (setq doom-modeline-checker-simple-format t)) ; Clean layout for Flycheck/Flymake

(provide 'cc-layout)
