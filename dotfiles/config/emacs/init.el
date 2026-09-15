;; https://systemcrafters.net/emacs-from-scratch/basics-of-emacs-configuration/

;; Initialize Package Manager & Repositories. Gotta be done first.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Resolves 'modules/' relative to wherever this init.el file actually lives.
(add-to-list 'load-path (expand-file-name "modules" (file-name-directory user-init-file)))
;; Load Custom Modules at the end.
(require 'cc-themes)
(require 'cc-evil)
(require 'cc-globals)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
