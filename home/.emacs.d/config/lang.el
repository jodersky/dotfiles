;;;; Settings for editing various text files and programing languages

;;; General text-editing

;; Markdown
(use-package markdown-mode
  :mode
  ("\\.markdown\\'" "\\.md\\'")
  :config
  (setq markdown-command "/usr/bin/pandoc"))

;; YML
(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'"))

;; Completion
(use-package company
  :diminish company-mode)

;; Snippets
(use-package yasnippet
  :diminish yas-minor-mode)

;;; C
(setq c-default-style "linux")

;;; Scala
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
	      ("<backtab>" . scala-indent:indent-with-reluctant-strategy)))

;; ENhanced Scala Interaction Mode for text Editors
(use-package ensime
  :commands ensime ensime-mode
  :init
  (setq ensime-default-buffer-prefix "ENSIME-")
  :config
  (set-face-attribute 'ensime-implicit-highlight nil
		      :underline nil))

;;; Java
(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 4)))

;;; Web development
;; Different modes in html files
(use-package web-mode
  :mode "\\.html?\\'")

;; Javascript
(use-package js3-mode
  :mode "\\.js\\'")

