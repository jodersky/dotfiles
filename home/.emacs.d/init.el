;;; General configuration

;; clean up interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode t)
(setq column-number-mode t)
(setq inhibit-splash-screen t)
(setq ring-bell-function 'ignore)

;; disable backups, autosave and lockfiles (use scm instead)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(global-auto-revert-mode t)

;; font
(set-face-attribute 'default nil :height 110); value is in 1/10pt, so 100 will give you 10pt, etc.

;;; Other configuration
(mapc 'load (file-expand-wildcards "~/.emacs.d/config/*.el"))
