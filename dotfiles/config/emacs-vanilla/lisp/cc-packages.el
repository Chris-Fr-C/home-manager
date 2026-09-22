;;; cc-packages.el --- package.el bootstrap and archive setup -*- lexical-binding: t; -*-

;;; Commentary:
;; This config uses the built-in package.el manager (not straight.el or
;; elpaca).  Rationale: zero external bootstrap dependency, works the
;; same in terminal and GUI, and ships with every Emacs including this
;; machine's Emacs 30.2.  This file configures archives and use-package;
;; every other module assumes it has already run (see init.el order).

;;; Code:

(require 'package)

;; Keep ELPA installs inside this config directory so the setup is
;; portable (e.g. ~/.config/emacs/elpa instead of ~/.emacs.d/elpa).
;; Must be set before package-initialize runs.
(setopt package-user-dir (expand-file-name "elpa" user-emacs-directory))

;; GNU ELPA and NonGNU ELPA are maintained by upstream; MELPA carries
;; evil and evil-collection releases.  HTTPS is required by default.
(setopt package-archives
        '(("gnu" . "https://elpa.gnu.org/packages/")
          ("nongnu" . "https://elpa.nongnu.org/nongnu/")
          ("melpa" . "https://melpa.org/packages/")))
(setopt package-archive-priority
        '(("gnu" . 10)
          ("nongnu" . 5)
          ("melpa" . 0)))

;; Initialize on demand; Emacs 30+ already calls this after early-init,
;; so guard against double initialization for older versions.
(unless package--initialized
  (package-initialize))

;; Refresh archive contents only when missing, to keep startup fast and
;; offline-friendly.
(unless package-archive-contents
  (package-refresh-contents))

;; use-package ships built-in since Emacs 29, so no bootstrap install is
;; needed.  Requiring it here makes the macro available to later modules.
(require 'use-package)

;; Always ensure packages are installed when a :ensure t keyword is used,
;; and compute statistics to keep startup problems visible.
(setopt use-package-always-ensure nil
        use-package-verbose t
        use-package-compute-statistics t)

(provide 'cc-packages)
;;; cc-packages.el ends here
