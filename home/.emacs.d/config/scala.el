(use-package scala-mode2
  :interpreter
  ("scala" . scala-mode)
  :config
  (add-hook 'scala-mode-hook
	    (lambda ()
	      (local-set-key (kbd "RET") '(lambda ()
					    (interactive)
					    (newline-and-indent)
					    (scala-indent:insert-asterisk-on-multiline-comment)))
	      (setq fill-column 100)
	      (ensime-mode)))
  :bind (:map scala-mode-map
	      ("C-<tab>" . dabbrev-expand)
	      ("<backtab>" . scala-indent:indent-with-reluctant-strategy))

  )

;; ENhanced Scala Interaction Mode for text Editors
(use-package ensime
  :commands ensime ensime-mode
  :init
  (setq
   ensime-default-buffer-prefix "ENSIME-"))
