(use-package minimap
  :config (progn
	    (setq minimap-width-fraction 0.1
		  minimap-window-location (quote right))
	    (set-face-attribute 'minimap-active-region-background nil :background "dim gray")))
