(package-initialize)

(require 'package)
(setq package-enable-at-startup nil)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(defun emacs-home ()
  "Return the full path to ~/.emacs.d, resolving it if it's a symlink."
  (or (file-symlink-p (expand-file-name "." user-emacs-directory))
      user-emacs-directory))

(defun init-file ()
  "Return the full path to init.el."
  (expand-file-name "init.el" (emacs-home)))

(defun find-init-file ()
  "Open init.el."
  (interactive)
  (find-file (init-file)))

(add-to-list 'load-path user-emacs-directory)

;;; --------------------------------------------------------------------------------
;;; General settings

(set-frame-font "SF Mono 13" nil t)

(setq create-lockfiles nil)
(setq electric-indent-inhibit t)
(setq-default indent-tabs-mode nil)
(setq inhibit-splash-screen t)
(setq lexical-binding t)
(setq make-backup-files nil)

(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'org-mode-hook 'linum-mode)

;;; --------------------------------------------------------------------------------
;;; Life improvement

;; libraries

(use-package dash)
(use-package f)

;; all-the-icons

(use-package all-the-icons)

;; anzu

(use-package anzu
  :config
  (global-anzu-mode +1))

;; atom-one-dark-theme

(use-package atom-one-dark-theme)

;; company

(use-package company
  :config (add-hook 'prog-mode-hook #'(lambda () (company-mode))))

;; dashboard

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo
        dashboard-items '((recents . 8)
                          (bookmarks . 5))))

;; defaults

(use-package better-defaults)

;; diff-hl

(use-package diff-hl)

;; diminish

(use-package diminish)

;; flycheck

(use-package flycheck
  :init (global-flycheck-mode))

;; editorconfig

(use-package editorconfig
  :diminish editor-config
  :config
  (editorconfig-mode 1))

;; ensime

(use-package ensime
  :pin melpa-stable)

;; eshell

(defun eshell/emacs (file)
  (find-file-other-window file))

;; evil

(defun lyra-config-evil ()
  "Give this great operating system a decent text editor."

  ;; learn to let go
  (add-to-list 'evil-emacs-state-modes 'dired-mode)
  (add-to-list 'evil-emacs-state-modes 'proced-mode)
  (add-to-list 'evil-emacs-state-modes 'eshell-mode)
  (add-to-list 'evil-emacs-state-modes 'term-mode)
  (add-to-list 'evil-emacs-state-modes 'diff-mode)
  (add-to-list 'evil-emacs-state-modes 'vc-mode)

  (evil-define-key 'normal global-map (kbd "<down>") 'evil-next-visual-line)
  (evil-define-key 'normal global-map (kbd "<up>") 'evil-previous-visual-line))

(use-package evil
  :diminish undo-tree
  :commands (evil-mode evil-define-key)
  :init (evil-mode 1) ;; pump, pump, pump, pump it up
  :config
  (add-hook 'evil-mode-hook 'lyra-config-evil)
  (evil-mode 1))

(use-package evil-leader
  :config
  (setq evil-leader/in-all-states t)
  (global-evil-leader-mode)
  (evil-leader/set-leader "SPC")
  (evil-leader/set-key
    "/" 'comment-region
    "\\\\" 'uncomment-region
    "." 'find-init-file
    "W" 'toggle-truncate-lines
    "X" 'delete-trailing-whitespace))

(use-package evil-matchit
  :config
  (global-evil-matchit-mode 1))

(require 'evil-unimpaired)

(use-package evil-surround
  :config
  (global-evil-surround-mode))

(use-package evil-indent-plus
  :config
  (evil-indent-plus-default-bindings))

;; god-mode

(use-package god-mode
  :config

  (use-package evil-god-state
    :diminish god-local-mode)

  (define-key evil-normal-state-map (kbd ";") 'evil-ex)
  (define-key evil-visual-state-map (kbd ";") 'evil-ex)
  (define-key global-map (kbd "C-<escape>") 'evil-normal-state)
  (define-key global-map (kbd "C-~") 'evil-normal-state)
  (define-key global-map (kbd "M-<escape>") 'god-mode)
  (define-key global-map (kbd "C-M-<escape>") 'god-local-mode)
  (evil-leader/set-key "SPC" 'evil-execute-in-god-state))

;; gruvbox

(use-package gruvbox
  :config
  (load-theme 'gruvbox-dark-medium 'no-confirm))

;; helm

(use-package helm
  :bind (("M-x" . helm-M-x)))

;; json

(use-package json-mode
  :mode "\\.json$")
(use-package json-navigator
  :config
  (evil-leader/set-key-for-mode 'json-mode
    "jnp" 'json-navigator-navigate-after-point
    "jnr" 'json-navigator-navigate-region))
(use-package json-reformat
  :config
  (evil-leader/set-key-for-mode 'json-mode
    "jr" 'json-reformat-region
    "jpr" 'json-pretty-print
    "jpb" 'json-pretty-print-buffer))

;; linum-relative

(use-package linum-relative
  :config
  (setq linum-relative-current-symbol "")
  (linum-relative-toggle))

;; magit

(use-package magit
  :config
  (evil-leader/set-key
    "gb" 'magit-blame
    "gB" 'magit-blame-quit
    "gdu" 'magit-diff-unstaged
    "gds" 'magit-diff-staged
    "gl" 'magit-log-buffer-file
    "gL" 'magit-log-current
    "gs" 'magit-status))

;; powerline

(use-package powerline)

;; request

(use-package request
  :commands (request))

;; solarized

;; (use-package solarized-theme
;;   :init
;;   (setq solarized-high-contrast-mode-line t
;;         solarized-use-less-bold t
;;         solarized-emphasize-indicators nil
;;         solarized-scale-org-headlines nil
;;         x-underline-at-descent-line t)
  
;;   (add-hook 'after-make-frame-functions
;;             (lambda (frame)
;;               (set-frame-parameter frame 'background-mode mode)))
;;   :config (setq color-theme-is-global t))

;; spaceline

(use-package spaceline-config
  :ensure spaceline
  :config
  (spaceline-spacemacs-theme)
  (setq powerline-default-separator 'wave)

  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (set-face-attribute 'spaceline-evil-emacs nil :background "#2aa198")
  (set-face-attribute 'spaceline-evil-insert nil :background "#b58900")
  (set-face-attribute 'spaceline-evil-motion nil :background "#ae81ff")
  (set-face-attribute 'spaceline-evil-normal nil :background "#859900")
  (set-face-attribute 'spaceline-evil-replace nil :background "#dc322f")
  (set-face-attribute 'spaceline-evil-visual nil :background "#d33682")

  (dolist (face '(spaceline-evil-emacs
                  spaceline-evil-insert
                  spaceline-evil-motion
                  spaceline-evil-normal
                  spaceline-evil-replace
                  spaceline-evil-visual))
    (set-face-inverse-video face nil))

  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-buffer-encoding-abbrev-off)

  (spaceline-compile))

;; which-key

(use-package which-key
  :config
  (which-key-mode))

;;; --------------------------------------------------------------------------------
;;; Language support

;; ansible

(use-package ansible)
(use-package ansible-doc)
(use-package company-ansible)

;; configs

(use-package apache-mode)
(use-package nginx-mode)

(evil-leader/set-key
  "mca" 'apache-mode
  "mcs" 'syslog-mode)

;; markdown

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; logs

(use-package syslog-mode
  :mode "\\.log$")
(evil-leader/set-key
  "ml" 'syslog-mode)

;; yaml

(use-package yaml-mode
  :mode "\\.ya?ml$")

;;; --------------------------------------------------------------------------------
;;; Bindings

(evil-leader/set-key
  "md" 'markdown-mode
  "mj" 'javascript-mode
  "mo" 'org-mode
  "ms" 'shell-script-mode
  "mw" 'web-mode)

(evil-leader/set-key-for-mode 'org-mode
  "oi" 'org-clock-in
  "oo" 'org-clock-out
  "or" 'org-clock-report
  "ou" 'org-update-all-dblocks
  "oa" 'org-agenda
  "ot" 'org-todo
  "oT" 'org-set-tags
  "oe" 'org-set-effort
  "oc" 'org-edit-special)

(evil-leader/set-key
  "se" 'eshell
  "sc" 'shell-command
  "sr" 'shell-command-on-region)

(evil-leader/set-key
  "rd" 'run-dig
  "rp" 'run-python)
