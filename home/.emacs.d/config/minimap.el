(require 'minimap)

(customize-set-variable 'minimap-width-fraction 0.1)
(customize-set-variable 'minimap-window-location (quote right))
(set-face-attribute 'minimap-active-region-background nil :background "dim gray")

(minimap-mode 1)

