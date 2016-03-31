(use-package scala-mode2
  :interpreter
  ("scala" . scala-mode)
  :config
  ;; BUG https://github.com/Fuco1/smartparens/issues/468
  ;; backwards/next not working particularly well

  ;; i.e. bypass company-mode
  (bind-key "C-<tab>" 'dabbrev-expand scala-mode-map)
  (bind-key "C-c e" 'next-error scala-mode-map)
  (add-hook 'scala-mode-hook
	    (lambda ()
	      (local-set-key (kbd "RET") '(lambda ()
					    (interactive)
					    (newline-and-indent)
					    (scala-indent:insert-asterisk-on-multiline-comment)))
	      (local-set-key (kbd "<backtab>") 'scala-indent:indent-with-reluctant-strategy)
	      (setq fill-column 100)
	      (ensime-mode))))

;; ENhanced Scala Interaction Mode for text Editors
(use-package ensime
  :commands ensime ensime-mode
  :init
  (setq
   ensime-default-buffer-prefix "ENSIME-"))
