;;; cc-completion.el --- Minibuffer completion stack -*- lexical-binding: t; -*-

;;; Commentary:
;; Vertico for vertical candidates, orderless for out-of-order matching,
;; marginalia for annotations, consult for search commands, embark for
;; actions on candidates, company for in-buffer completion.  This is the
;; standard minad stack plus company and works the same in terminal and
;; GUI (plain company, not company-box, so popups render in terminals).
;; Vim keys inside these minibuffers arrive automatically from
;; evil-collection (it ships vertico, consult, embark, marginalia, and
;; company modules applied on load), so no evil setup is needed here.
;; embark-consult (richer consult previews) is a possible future
;; addition, not installed now.

;;; Code:

;; Vertical, terminal-friendly candidate list.
(use-package vertico
  :ensure t
  :demand t
  :custom
  (vertico-count 12)
  :config
  (vertico-mode 1))

;; Out-of-order matching (type fragments in any order, space-separated).
;; Follows the upstream basic profile: orderless everywhere except file
;; paths, where partial-completion keeps ~/Doc/ TAB expansion working.
(use-package orderless
  :ensure t
  :demand t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Annotations (docs, history, file info) next to candidates.
(use-package marginalia
  :ensure t
  :demand t
  :config
  (marginalia-mode 1))

;; Context actions on the thing at point or the current candidate.
;; NOTE: C-. is not reliably sendable by plain terminal emulators
;; without Kitty keyboard protocol; there M-x embark-act is the
;; fallback.  GUI and Kitty-protocol terminals are unaffected.
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)))

;; Search and navigation commands (upstream-recommended keys, all
;; terminal-safe M- combinations; goto-line and yank-pop strictly
;; upgrade their defaults with live preview).
(use-package consult
  :ensure t
  :bind
  (("M-g g" . consult-goto-line)
   ("M-g i" . consult-imenu)
   ("M-s l" . consult-line)
   ("M-y" . consult-yank-pop)))

;; In-buffer completion popup.  lsp-mode feeds it automatically via
;; company-capf in managed buffers (no company-lsp needed: deprecated
;; upstream); dabbrev and friends cover plain buffers.  Snappy prefix
;; settings follow lsp-mode's own responsiveness advice.
(use-package company
  :ensure t
  :demand t
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  :config
  (global-company-mode 1))

(provide 'cc-completion)
;;; cc-completion.el ends here
