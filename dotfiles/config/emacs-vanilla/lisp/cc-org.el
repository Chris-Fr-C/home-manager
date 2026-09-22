;;; cc-org.el --- Org-mode, agenda, roam notes, modern styling -*- lexical-binding: t; -*-

;;; Commentary:
;; Personal organization hub: built-in org-mode plus agenda, org-modern
;; for prettier stars/checkboxes, and org-roam v2 for Zettelkasten notes.
;; org-agenda ships inside org itself, so there is no separate package to
;; install for it.  MELPA always serves the latest org-roam v2 release.
;; Prerequisites: none for org/agenda/modern; org-roam needs a SQLite
;; provider, which its emacsql-sqlite dependency fetches automatically on
;; first use (network required once), falling back to a local C compiler.
;; Modal org bindings (dired-style navigation, etc.) come free from the
;; evil-collection setup in cc-editing.el.  Identical in terminal and GUI.

;;; Code:

;; Org-mode core plus agenda (built-in since Emacs 30, no ELPA install).
(use-package org
  :ensure nil
  :custom
  ;; Single notes root; change this one path and agenda/roam follow it.
  (org-directory "~/org")
  ;; Agenda scans the whole notes root recursively.
  (org-agenda-files '("~/org"))
  (org-todo-keywords '((sequence "TODO" "NEXT" "WAIT" "|" "DONE" "DROP")))
  ;; Timestamp finished items; cheap provenance for reviews.
  (org-log-done 'time)
  :bind (:map cc-org-map
              ("a" . org-agenda)
              ("c" . org-capture))
  :config
  ;; The agenda errors on a missing directory, so create the notes root
  ;; (and only that) on first load rather than failing at first SPC o a.
  (unless (file-directory-p org-directory)
    (make-directory org-directory t))
  ;; C-j/C-k switch windows here too: outline (which org derives from)
  ;; binds them to heading motion, and org itself binds C-j to
  ;; org-return-and-maybe-indent.  This overrides both in every evil
  ;; state; RET still newlines as usual.
  (evil-define-key '(normal visual motion insert emacs) org-mode-map
    (kbd "C-j") #'evil-window-down
    (kbd "C-k") #'evil-window-up)
  ;; , J / , K walk visible headings (comma is the local leader in
  ;; modal states, see cc-keybindings.el).
  (evil-define-key '(normal visual) org-mode-map
    (kbd ", J") #'org-next-visible-heading
    (kbd ", K") #'org-previous-visible-heading))

;; Prettier org buffers: modern stars, checkboxes, and agenda faces.
;; Terminal-safe by default: org-modern falls back to plain glyphs where
;; the terminal font lacks symbols, so no GUI guard is needed.
(use-package org-modern
  :ensure t
  :after org
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda))

;; Zettelkasten notes graph, latest v2 from MELPA (no version pin).
(use-package org-roam
  :ensure t
  :after org
  :custom
  (org-roam-directory (file-truename "~/org/roam"))
  ;; Show backlinks/unlinked references on toggle, the default graph UI.
  (org-roam-mode-sections '((org-roam-backlinks-section :unique t)
                            org-roam-reflinks-section
                            org-roam-unlinked-references-section))
  :bind (:map cc-org-map
              ("f" . org-roam-node-find)
              ("i" . org-roam-node-insert)
              ("l" . org-roam-buffer-toggle))
  :config
  ;; Keep the notes directory present so the first node command never
  ;; fails; the SQLite database itself is created on demand.
  (unless (file-directory-p org-roam-directory)
    (make-directory org-roam-directory t))
  ;; Deferred like the rest of this file: autosync starts with the first
  ;; org-roam command instead of slowing down every Emacs startup.
  (org-roam-db-autosync-mode 1))

(provide 'cc-org)
;;; cc-org.el ends here
