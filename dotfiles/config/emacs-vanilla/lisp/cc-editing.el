;;; cc-editing.el --- Vim-style editing via evil and evil-collection -*- lexical-binding: t; -*-

;;; Commentary:
;; Vim emulation for an nvim convert: evil provides modal editing and
;; evil-collection applies vim bindings to built-in buffers (dired,
;; help, magit-less core modes, etc.).  Kept separate from keybindings
;; and UI so a future move away from modal editing touches one file.
;; Works identically in terminal and GUI; see comments on C-i/TAB below.

;;; Code:

;; Vim-style modal editing core.
(use-package evil
  :ensure t
  :demand t
  :init
  ;; These MUST be set before evil loads, otherwise evil-collection
  ;; cannot take over keymaps cleanly.  See evil-collection README.
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  ;; Vim-like C-u to scroll up; safe in terminals (unlike C-i, below).
  (setq evil-want-C-u-scroll t)
  ;; Use built-in undo-redo (Emacs 28+) instead of pulling in undo-tree.
  (setq evil-undo-system 'undo-redo)
  ;; Keep Y vim-consistent (yank to end of line) and use evil-search.
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-search-module 'evil-search)
  :custom
  ;; Start help and magit-adjacent buffers in emacs state where modal
  ;; editing adds little; evil-collection still binds the rest modally.
  (evil-emacs-state-modes '(help-mode))
  :config
  ;; NOTE: terminals cannot distinguish C-i from TAB without Kitty
  ;; keyboard protocol, so evil's C-i jump-forward is only reachable in
  ;; GUI or Kitty-protocol terminals.  Use C-o (jump back) which works
  ;; everywhere, plus :jumplist in Ex.
  (evil-mode 1)
  ;; Record macros with C-M-r instead of vim's q: q is freed for future
  ;; use, and C-M-r is sendable by terminals (ESC-prefixed) as well as
  ;; GUI frames.  Playing macros stays on @ (evil-execute-macro).
  (define-key evil-normal-state-map (kbd "q") nil)
  (define-key evil-normal-state-map (kbd "C-M-r") #'evil-record-macro)
  ;; SPC as vim-style leader in modal states; M-SPC remains the global
  ;; fallback defined in cc-keybindings.el for Emacs state and typing.
  (define-key evil-normal-state-map (kbd "SPC") cc-leader-map)
  (define-key evil-visual-state-map (kbd "SPC") cc-leader-map)
  (define-key evil-motion-state-map (kbd "SPC") cc-leader-map))

;; Vim bindings for built-in modes (dired, help, occur, etc.).
(use-package evil-collection
  :ensure t
  :after evil
  :demand t
  :custom
  ;; Silence the extra minibuffer hint; which-key already documents keys.
  (evil-collection-want-find-usages-bindings t)
  :config
  (evil-collection-init))

;; Briefly highlight what changed: pasted/yanked text, undone regions,
;; and other volatile operations flash so the eye sees what moved.
;; Overlay-based feedback only, works in terminal and GUI alike.
(use-package volatile-highlights
  :ensure t
  :demand t
  :config
  (volatile-highlights-mode t))

(provide 'cc-editing)
;;; cc-editing.el ends here
