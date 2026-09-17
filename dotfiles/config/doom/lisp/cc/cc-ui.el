;; -- Make ace-window overlay letters bigger and high-contrast -----------
(after! ace-window
  (custom-set-faces!
    '(aw-leading-char-face
      :height 2.5            ; Make text 2.5x larger than standard font
      :weight bold           ; Extra bold text
      :foreground "red"      ; High-contrast text color
      :background "yellow"))) ; High-contrast background highlight



(provide 'cc-ui)
