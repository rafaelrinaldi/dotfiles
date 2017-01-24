;; Package manager
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;; Evil mode
(require 'evil)
(evil-mode t)

;; Evil mode surround
(require 'evil-surround)
(global-evil-surround-mode 1)

;; Font
(set-default-font "SF Mono 14")

;; Remove toolbar
(tool-bar-mode -1)

;; No welcome messages
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Line numbers
(require 'nlinum-relative)
(nlinum-relative-setup-evil)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)
(setq nlinum-relative-current-symbol "")
(setq nlinum-relative-offset 0)

(require 'rainbow-mode)
(rainbow-mode +1)

(custom-set-variables
 '(custom-enabled-themes (quote (leuven)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
  '(package-selected-packages
     (quote
       (evil-surround rainbow-mode editorconfig nlinum-relative evil-visual-mark-mode))))

;; EditorConfig
(require 'editorconfig)
(editorconfig-mode 1)

;; Easy buffer switching
(require 'ido)
(ido-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
