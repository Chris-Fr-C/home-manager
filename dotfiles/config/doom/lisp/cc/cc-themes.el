(use-package catppuccin-theme :ensure t)

;; Don't show the splash screen
(setq inhibit-startup-message t visible-bell t)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)  ; Leave this one on if you're a beginner!
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Don't pop up UI dialogs when prompting
(setq use-dialog-box nil)

;; Display line numbers in every buffer
; (global-display-line-numbers-mode 1)
;; Enable line numbers only in programming modes (Python, C, Elisp, JS, etc.)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)


;; Customizing modus
(setq modus-themes-mode-line '(accented borderless padded))

; accented: Use a richer background color for regions
; bg-only: Don’t remove foreground text highlighting inside of active region
; no-extend: Don’t extend the region color to the full width of the window
(setq modus-themes-region '(accented))

 ; The modus-themes-completions variable can be used to control how completion candidates are highlighted, especially when they match part of your search term:
 ;
 ;    nil: No customization
 ;    moderate: Slight customization that isn’t too distracting
 ;    opinionated: Much richer colors
 ;
(setq modus-themes-completions 'opinionated)

;; Load the Modus Vivendi dark theme
; (load-theme 'modus-vivendi t)
(load-theme 'catppuccin t)


;; Must be the last line in the file:
(provide 'cc-themes)
