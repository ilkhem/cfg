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
(add-hook 'after-init-hook 'global-company-mode)



;;;;;;;;;; LANGUAGES ;;;;;;;;;;;

;; ------------------------------------------------------------------------------
;; PYTHON

; Nothing to configure for python, everything works out-of-the box after installing the lsp server.



;; ------------------------------------------------------------------------------
;; ORG

(setq deft-directory "~/notes"
      deft-extensions '("org" "txt")
      deft-recursive t)

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation))

(setq reftex-default-bibliography (quote ("~/texmf/bibtex/bib/refs_zot.bib")))

(after! org
  (add-hook 'org-mode-hook 'org-mode-reftex-setup)
  ;; (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
  ;;   (defadvice! org-edit-latex-emv-after-insert ()
  ;;     :after #'org-cdlatex-environment-indent
  ;;     (org-edit-latex-environment))
  (setq org-directory "~/notes/"
        org-use-property-inheritance t  ; it's convenient to have properties inherited
        ;; org-export-in-background t        ; run export processes in external emacs process
        ;; org-catch-invisible-edits 'smart  ; try not to accidently do weird stuff in invisible regions
        org-agenda-files '("~/notes/agenda.org" "~/notes/tasks.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▾ "
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)" ))
        org-todo-keyword-faces
          '(("TODO" :foreground "#7c7c75" :weight normal :underline t)
            ("WAITING" :foreground "#9f7efe" :weight normal :underline t)
            ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
            ("DONE" :foreground "#50a14f" :weight normal :underline t)
            ("CANCELLED" :foreground "#ff6480" :weight normal :underline t))
        org-log-done 'time
        org-journal-dir "~/notes/journal/"
        org-journal-date-prefix "#+TITLE: "
        org-journal-time-prefix "* "
        org-journal-date-format "%A, %d %b %Y"
        org-journal-file-format "%Y-%m-%d.org"
        org-hide-emphasis-markers t
        )
  (custom-set-faces!
    '(outline-1 :weight extra-bold :height 1.2)
    '(outline-2 :weight bold :height 1.15)
    '(outline-3 :weight bold :height 1.12)
    '(outline-4 :weight semi-bold :height 1.09)
    '(outline-5 :weight semi-bold :height 1.06)
    '(outline-6 :weight semi-bold :height 1.03)
    '(outline-8 :weight semi-bold)
    '(outline-9 :weight semi-bold)
    '(org-document-title :height 1.2))
  ;; (setq org-latex-pdf-process '("latexmk -f -pdf %f"))
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))
  ;; (setq org-latex-pdf-process '("latexmk -%latex -shell-escape -interaction=nonstopmode -f -pdf -output-directory=%o %f"))
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines))
  (require 'ox-latex)
  (unless (boundp 'org-latex-classes)
    (setq org-latex-classes nil))
  (add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (setq org-export-latex-hyperref-format "\\ref{%s}")
  )


;; ------------------------------------------------------------------------------
;; LATEX
