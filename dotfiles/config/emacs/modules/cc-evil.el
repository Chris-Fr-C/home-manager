;; ~/.emacs.d/lisp/my-evil.el

;; Set Evil variables BEFORE loading evil (crucial for integration)
(setq evil-want-integration t)
(setq evil-want-keybinding nil) ;; Recommended if using evil-collection later
(setq evil-want-C-u-scroll t)   ;; Enable C-u for page scrolling (optional)

(use-package evil
  :ensure t
  :init
  ;; Turn on Evil Mode globally
  :config
  (evil-mode 1))

(provide 'cc-evil)
