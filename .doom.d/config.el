;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; ------------------------------------------------------------------------------
;;;;;;;;;; GLOBALS AND DEFAULTS ;;;;;;;;;

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ilyes Khemakhem"
      user-mail-address "ilyes.khemakhem@gmail.com")

(setq doom-font (font-spec :family "InconsolataGo Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 16))

(setq doom-theme 'doom-one)
(setq display-line-numbers-type 'relative)
(display-time-mode 1)
(setq-default window-combination-resize t)
(setq which-key-idle-delay 0.5)
(setq evil-vsplit-window-right t
      evil-split-window-below t)
(map! :n [mouse-8] #'better-jumper-jump-backward
      :n [mouse-9] #'better-jumper-jump-forward)
(custom-set-faces! '(doom-modeline-buffer-modified :foreground "orange"))
(setq global-hl-todo-mode t)
(map! :leader
      :desc "Load new theme"
      "h t" #'counsel-load-theme)






;; ------------------------------------------------------------------------------
;;;;;;;;;;;;; GENERAL PACKAGE CONFIG ;;;;;;

;;
;; DIRED

(map! :leader
      :desc "Dired"
      "d d" #'dired
      :leader
      :desc "Dired jump to current"
      "d j" #'dired-jump
      )
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package


;; ------------------------------------------------------------------------------
;; COMPANY
(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2))



;;;;;;;;;; LANGUAGES ;;;;;;;;;;;

;; ------------------------------------------------------------------------------
;; PYTHON

; Nothing to configure for python, everything works out-of-the box after installing the lsp server.



;; ------------------------------------------------------------------------------
;; ORG

(setq deft-directory "~/notes"
      deft-extensions '("org" "txt")
      deft-recursive t)

(setq org-directory "~/org/")



;; ------------------------------------------------------------------------------
;; LATEX
