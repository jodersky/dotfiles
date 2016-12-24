;;; General configuration

;; clean up interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode t)
(setq column-number-mode t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(setq ring-bell-function 'ignore)

;; disable backups, autosave and lockfiles
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(global-auto-revert-mode t)

;; save customizations to separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; font
(set-face-attribute 'default nil :height 120); value is in 1/10pt, so 100 will give you 10pt, etc.

;; uniform questions
(defalias 'yes-or-no-p 'y-or-n-p)

;; kill the current buffer immediately (only ask if buffer modified)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; default window size
(when window-system (set-frame-size (selected-frame) 160 60))

;; set title of frame to current buffer
(setq frame-title-format '(buffer-file-name "%f" "%b"))

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

;; Highlight tabulations
;(setq-default highlight-tabs t)

;; Show trailing white spaces
;(setq-default show-trailing-whitespace t)

;;; Other configuration
(mapc 'load (file-expand-wildcards "~/.emacs.d/config/*.el"))
