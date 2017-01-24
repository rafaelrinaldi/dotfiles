;; Package manager
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

;;; Evil mode
(require 'evil)
(evil-mode t)

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

(custom-set-variables
  ;; Theme
 '(custom-enabled-themes (quote (leuven)))

  ;; Start GUI in full size
 '(initial-frame-alist (quote ((fullscreen . maximized))))
  '(package-selected-packages
     (quote
       (editorconfig nlinum-relative evil-visual-mark-mode))))

;; EditorConfig
(require 'editorconfig)
(editorconfig-mode 1)

;; Easy buffer switching
(require 'ido)
(ido-mode t)
