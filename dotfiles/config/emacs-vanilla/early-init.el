;;; early-init.el --- Pre-init performance and UI suppression -*- lexical-binding: t; -*-

;; This file runs before package and UI initialization.  It sets a high
;; GC threshold to speed up startup (restored later in init) and disables
;; UI chrome early so no flash of menu/tool/scroll bars occurs.  Keep it
;; free of package configuration: that belongs in lisp/cc-*.el.

;; Speed up startup by deferring garbage collection.
(setq gc-cons-threshold (* 50 1000 1000))

;; Suppress UI chrome before the first frame is drawn.
(setq inhibit-startup-message t)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;;; early-init.el ends here
