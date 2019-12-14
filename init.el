;;; Hayden's Emacs Config

;; something about myself
(setq
 user-mail-address "hhgarland@protonmail.com"
 user-full-name "Hayden G.")

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")
			 ("elpy"  . "https://jorgenschaefer.github.io/packages/")
			 ("org"   . "http://orgmode.org/elpa/")))
(package-initialize)

;; Use-package setup
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-verbose t)
(setq use-package-always-ensure t)

(require 'use-package)

(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

;; Display options
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(display-time-mode 1)
(setq inhibit-startup-message t)

;; General editing
(show-paren-mode)

;; Font settings
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

;; Set the default font
(set-frame-font "Inconsolata-16" nil t)

;; Gruvbox theme
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-dark-medium t))

;; Solarized theme
(use-package solarized-theme
  :disabled
  :ensure t
  :config
  (setq solarized-distinct-fringe-background nil)
  (setq solarized-use-variable-pitch nil)
  (setq solarized-high-contrast-mode-line t)
  (setq solarized-use-less-bold t)
  (setq solarized-use-more-italic t)
  (setq solarized-emphasize-indicators nil)
  (setq solarized-scale-org-headlines nil)
  (setq solarized-height-minus-1 1.0)
  (setq solarized-height-plus-1 1.0)
  (setq solarized-height-plus-2 1.0)
  (setq solarized-height-plus-3 1.0)
  (setq solarized-height-plus-4 1.0)
  (setq x-underline-at-descent-line t)
  (load-theme 'solarized-dark 'no-confirm)
  )

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; tramp settings
(setq tramp-default-method "ssh")

;; Packages
;; Ace-jump-mode
(use-package ace-jump-mode
  :ensure t
  :bind ("C-." . ace-jump-mode))

;; Auto-complete
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t))
  :diminish auto-complete-mode)

;; Avy
(use-package avy
  :ensure t)

;; Company
(use-package company
  :ensure t
  :config
  (global-company-mode))

;; diminish
(use-package diminish
  :ensure t)

;; Elpy
(use-package elpy
  :ensure t
  :config
  (setq elpy-modules '(elpy-module-sane-defaults
		       elpy-module-company
		       elpy-module-eldoc
		       elpy-module-highlight-indentation
		       elpy-module-pyvenv))
  (elpy-enable)
  (setq python-shell-interpreter "python"
	python-shell-interpreter-args "-i")
  )

;; expand-region
(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; Git-Gutter+
(use-package git-gutter+
  :ensure t
  :init (global-git-gutter+-mode)
  :config
  (setq git-gutter+-modified-sign " ")
  (setq git-gutter+-added-sign " ")
  (setq git-gutter+-deleted-sign " ")
  (set-face-background 'git-gutter+-modified "yellow")
  (set-face-background 'git-gutter+-added "green")
  (set-face-foreground 'git-gutter+-deleted "red"))

;; Ivy & Counsel
(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t))
  (setq ivy-re-builders-alist
      '((t . ivy--regex-ignore-order)))

;; Counsel config
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)))

;; Magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Multiple-Cursors
(use-package multiple-cursors
  :ensure t
  :init
  (progn
    (global-set-key (kbd "C-c .") 'mc/mark-next-like-this)
    (global-set-key (kbd "C->") 'mc/mark-next-like-this)
    (global-set-key (kbd "C-c ,") 'mc/mark-previous-like-this)
    (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
    (global-set-key (kbd "C-c C-l") 'c/mark-all-like-this)))
(provide 'init-multiple-cursors)

;; org-plus-contrib
(use-package org
  :ensure org-plus-contrib)

;; Powerline
(use-package powerline
  :disabled
  :ensure t
  :init (powerline-default-theme))

;; py-autopep8
(use-package py-autopep8
  :ensure t)

;; Rainbow Delimiters
(use-package rainbow-delimiters
  :ensure t
  :init
  (progn
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)))

;; Smartparens
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)))

;; Swiper
(use-package swiper
  :ensure t
  :bind (("\C-s" . swiper)))

;; tiny
(use-package tiny
  :ensure t
  :config
  (tiny-setup-default))

;; Undo-tree
(use-package undo-tree
  :disabled
  :init
  (global-undo-tree-mode)
  :diminish undo-tree-mode)

;; which key
(use-package which-key
  :ensure t
  :config
  (progn
    (require 'which-key)
    (which-key-mode)))
