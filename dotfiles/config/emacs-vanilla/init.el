;;; init.el --- Entry point only, loads lisp modules in order -*- lexical-binding: t; -*-

;; No package configuration lives here.  Each concern is configured in
;; its own lisp/cc-*.el module, loaded below in dependency order:
;; cc-core (defaults) -> cc-packages (package manager) ->
;; cc-keybindings (leader map + which-key) -> cc-editing (evil, etc.) ->
;; cc-completion (minibuffer stack) ->
;; cc-ui (theme, modeline, GUI tweaks) -> cc-lsp (LSP base client) ->
;; cc-org (org-mode, agenda, roam, modern styling) ->
;; cc-treemacs (side file tree) ->
;; cc-lang-python, cc-lang-rust, cc-lang-elisp (language setups).

;; Restore a sane GC threshold after startup for steady-state pauses.
;; early-init.el raises this; we lower it once loading is finished.
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1000 1000))))

;; Make our lisp/ directory importable, then load modules in order.
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'cc-core)
(require 'cc-packages)
(require 'cc-keybindings)
(require 'cc-editing)
(require 'cc-completion)
(require 'cc-ui)
(require 'cc-lsp)
(require 'cc-org)
(require 'cc-treemacs)
(require 'cc-lang-python)
(require 'cc-lang-rust)
(require 'cc-lang-elisp)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(consult dired-ranger dirvish doom-modeline doom-themes embark
	     evil-collection gnu-elpa-keyring-update lsp-mode
	     marginalia orderless org-modern org-roam treemacs-evil
	     treemacs-nerd-icons vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
