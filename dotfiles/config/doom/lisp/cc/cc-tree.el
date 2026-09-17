(use-package treemacs
  :ensure t
  :defer t
  :config
  ;; Aesthetic & Layout Settings
  (setq treemacs-width 30                          ; Sidebar width
        treemacs-is-never-other-window t          ; Prevents C-x o / C-w from jumping into treemacs by accident
        treemacs-space-between-root-nodes t       ; Clean spacing between projects
        treemacs-show-hidden-files t              ; Show hidden files (.gitignore, etc.)
        treemacs-follow-after-init t              ; Auto-open on current file
        treemacs-silent-filewatch t               ; Quiet background file updating
        treemacs-file-event-delay 2000)           ; Throttle filewatch events

  ;; Git Integration Setup
  (treemacs-git-mode 'deferred)                   ; Show git status colors on files asynchronously

  ;; Clean UI (Hide line numbers & modeline in Treemacs window)
  (add-hook 'treemacs-mode-hook
            (lambda ()
              (display-line-numbers-mode -1)
              (setq-local mode-line-format nil))))

;; Evil Mode Integration for Treemacs
(use-package treemacs-evil
  :ensure t
  :after (treemacs evil))

;; Icons Support (Nerd-Icons for Treemacs)
(use-package treemacs-nerd-icons
  :ensure t
  :after treemacs
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package treemacs-evil :ensure t)


(provide 'cc-tree)
