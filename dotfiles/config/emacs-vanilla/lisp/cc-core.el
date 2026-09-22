;;; cc-core.el --- Sane defaults, no external packages -*- lexical-binding: t; -*-

;;; Commentary:
;; Baseline Emacs behavior shared by terminal and GUI.  This file uses
;; no third-party packages on purpose, so it loads before the package
;; manager (cc-packages.el) is configured.  Anything needing use-package
;; belongs in a later module.

;;; Code:

;; Prefer short y/n answers over typing yes/no in full.
(setopt use-short-answers t)

;; Keep backup and auto-save files out of the working tree.
(setopt backup-directory-alist `(("." . ,(expand-file-name "backups" user-emacs-directory))))
(setopt auto-save-file-name-transforms `((".*" ,(expand-file-name "auto-save/" user-emacs-directory) t)))

;; UTF-8 everywhere; important for terminal emulators with mismatched locales.
(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8)

;; Show column numbers in the mode line; harmless in terminal and GUI.
(setopt column-number-mode t)

;; Delete trailing whitespace contextually is opt-in per mode, so here we
;; only make the kill ring and clipboard behave sanely in terminals.
(setopt kill-do-not-save-duplicates t)

;; Follow symlinks to version-controlled files without prompting, since
;; this config itself lives in a git repo.
(setopt vc-follow-symlinks t)

(provide 'cc-core)
;;; cc-core.el ends here
