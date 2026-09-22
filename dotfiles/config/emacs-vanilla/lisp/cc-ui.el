;;; cc-ui.el --- Theme, modeline, fonts, GUI-only tweaks -*- lexical-binding: t; -*-

;;; Commentary:
;; Visual layer for terminal-first use: theme, mode line, and any future
;; font setup live here, separate from editing and keybindings.
;; doom-one is the flagship doom-themes variant and reads well on both
;; dark terminals (256-color approximation) and GUI frames (true color).
;; doom-modeline is chosen because it stays readable in 256-color
;; terminals without icons, and upgrades to icons in GUI frames that
;; have Nerd Fonts installed.  Prerequisite for GUI icons: run
;; M-x nerd-icons-install-fonts once (nerd-icons arrives automatically
;; as a doom-modeline dependency).

;;; Code:

;; Doom visual theme, doom-one variant (works in 256-color terminals
;; and true-color GUI frames alike, so no display guard is needed).
(use-package doom-themes
  :ensure t
  :demand t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-one t)
  ;; Nicer org headings and blocks matching the theme; only touches
  ;; org faces, which cc-org.el configures.
  (doom-themes-org-config))

;; Sleek mode line that stays readable in 256-color terminals.
(use-package doom-modeline
  :ensure t
  :demand t
  :custom
  (doom-modeline-height 15)
  (doom-modeline-minor-modes nil)
  (doom-modeline-buffer-file-name-style 'truncate-upto-project)
  ;; Start icon-free so terminals without Nerd Fonts never show tofu
  ;; boxes; GUI frames opt back into icons in :config below.
  (doom-modeline-icon nil)
  :config
  (doom-modeline-mode 1)
  ;; GUI-only: icon glyphs need a graphical toolkit plus Nerd Fonts.
  ;; Terminal frames keep the text fallback set above, because most
  ;; terminal emulators cannot render these glyphs reliably.
  (when (display-graphic-p)
    (setq doom-modeline-icon t)))

;; Briefly spotlight the cursor after jumps and scrolls, so the eye
;; finds it in crowded windows.  Overlay-based, works in terminal and
;; GUI alike with no extra setup.
(use-package beacon
  :ensure t
  :demand t
  :config
  (beacon-mode 1))

;; Tab bar for open buffers, complementing the Buffer leader keys.
;; Text tabs render in terminal and GUI alike with no icon setup.
(use-package centaur-tabs
  :ensure t
  :demand t
  :config
  (centaur-tabs-mode t))

(provide 'cc-ui)
;;; cc-ui.el ends here
