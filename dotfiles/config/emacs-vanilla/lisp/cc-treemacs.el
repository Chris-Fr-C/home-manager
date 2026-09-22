;;; cc-treemacs.el --- Side file tree with icons -*- lexical-binding: t; -*-

;;; Commentary:
;; Plain treemacs side window: SPC e opens it, icons come from
;; treemacs-nerd-icons, vim keys from treemacs-evil.  (Verified against
;; the installed evil-collection: it ships no treemacs module, so there
;; is nothing to exclude and no keymap conflict.)  File operations use
;; treemacs built-ins (cf/cd create, d delete, c copy, m move, R
;; rename), discoverable with which-key.  Icons need a Nerd Font in the
;; terminal emulator, or M-x nerd-icons-install-fonts for GUI frames,
;; otherwise glyphs render as boxes.

;;; Code:

;; Project side tree, opened with SPC e.
(use-package treemacs
  :ensure t
  :defer t
  :bind (:map cc-leader-map
              ("e" . treemacs)))

;; Nerd-icons theme for the tree.
(use-package treemacs-nerd-icons
  :ensure t
  :after treemacs
  :config
  (treemacs-load-theme "nerd-icons"))

;; Vim keybindings for the tree (treemacs-evil has no autoloads, so
;; :demand loads it as soon as treemacs itself is up; the tree stays
;; fully deferred until the first SPC e).
(use-package treemacs-evil
  :ensure t
  :after (treemacs evil)
  :demand t)

(provide 'cc-treemacs)
;;; cc-treemacs.el ends here
