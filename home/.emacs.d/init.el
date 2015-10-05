;;; General configuration

;; clean up interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode t)
(setq column-number-mode t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message "")
(setq ring-bell-function 'ignore)

;; disable backups, autosave and lockfiles (use scm instead)
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(global-auto-revert-mode t)

;; font
(set-face-attribute 'default nil :height 110); value is in 1/10pt, so 100 will give you 10pt, etc.

;; uniform questions
(defalias 'yes-or-no-p 'y-or-n-p)

;; default window size
(when window-system (set-frame-size (selected-frame) 160 60))

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

;; Highlight tabulations
(setq-default highlight-tabs t)

;; Show trailing white spaces
(setq-default show-trailing-whitespace t)

;;; Other configuration
(mapc 'load (file-expand-wildcards "~/.emacs.d/config/*.el"))
