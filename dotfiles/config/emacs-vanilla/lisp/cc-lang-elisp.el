;;; cc-lang-elisp.el --- Emacs Lisp without LSP, by design -*- lexical-binding: t; -*-

;;; Commentary:
;; lsp-mode ships no Emacs Lisp client, and none is installed here on
;; purpose: the running Emacs itself is the introspection backend via
;; describe-symbol, eldoc, and completion-at-point, which already cover
;; hover (K, see `cc-show-doc-at-point'), signatures, and completion.
;; Starting lsp-mode in an elisp buffer would only report no client, so
;; unlike the other cc-lang-*.el modules this one sets no lsp hook.
;; What it does pin is elisp-specific linting while typing.

;;; Code:

;; On-the-fly checkdoc linting for Emacs Lisp buffers.
(use-package elisp-mode
  :ensure nil ; built-in, no ELPA install needed
  :hook (emacs-lisp-mode . checkdoc-minor-mode))

(provide 'cc-lang-elisp)
;;; cc-lang-elisp.el ends here
