;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ilyes Khemakhem"
      user-mail-address "ilyes.khemakhem@gmail.com"
      doom-theme 'doom-vibrant
      display-line-numbers-type 'relative
      evil-ex-substitute-global t  ; substitute patters are global
      projectile-project-search-path '("~/phd/projects/" "~/phd/text/"))
;;
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

(setq-default
 ;; delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 ;; x-stretch-cursor t                              ; Stretch cursor to the glyph width
 )

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      ;; auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(display-time-mode 1)                             ; Enable time in the mode-line


;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "InconsolataGo Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 16))



;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
  ;; (add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)
  (add-hook! 'org-mode-hook (company-mode -1))
  (add-hook! 'org-capture-mode-hook (company-mode -1))
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-directory "~/notes/"
        org-agenda-files '("~/notes/agenda.org" "~/notes/tasks.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▾ "
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"
             "INPROGRESS(i)"     ; task in progress
             "WAITING(w)"        ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" )) ; Task has been cancelled
        org-todo-keyword-faces
          '(("TODO" :foreground "#7c7c75" :weight normal :underline t)
            ("WAITING" :foreground "#9f7efe" :weight normal :underline t)
            ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
            ("DONE" :foreground "#50a14f" :weight normal :underline t)
            ("CANCELLED" :foreground "#ff6480" :weight normal :underline t))
        org-priority-highest ?A
        org-priority-lowest ?E
        ;; org-priority-faces
        ;; '((?A . 'all-the-icons-red)
        ;;   (?B . 'all-the-icons-orange)
        ;;   (?C . 'all-the-icons-yellow)
        ;;   (?D . 'all-the-icons-green)
        ;;   (?E . 'all-the-icons-blue))
        org-log-done 'time
        org-journal-dir "~/notes/journal/"
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org"
        org-hide-emphasis-markers t)
  ;; (custom-set-faces!
  ;;   '(outline-1 :weight extra-bold :height 1.25)
  ;;   '(outline-2 :weight bold :height 1.15)
  ;;   '(outline-3 :weight bold :height 1.12)
  ;;   '(outline-4 :weight semi-bold :height 1.09)
  ;;   '(outline-5 :weight semi-bold :height 1.06)
  ;;   '(outline-6 :weight semi-bold :height 1.03)
  ;;   '(outline-8 :weight semi-bold)
  ;;   '(outline-9 :weight semi-bold))
  ;; (custom-set-faces!
  ;;   '(org-document-title :height 1.2))
  ;; (setq org-agenda-deadline-faces
  ;;   '((1.001 . error)
  ;;     (1.0 . org-warning)
  ;;     (0.5 . org-upcoming-deadline)
  ;;     (0.0 . org-upcoming-distant-deadline)))
  (setq org-fontify-quote-and-verse-blocks t)
  (setq org-highlight-latex-and-related '(native script entities)))

(setq-default major-mode 'org-mode)

(setq evil-vsplit-window-right t
      evil-split-window-below t)


(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)


(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)


(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))

(map! :n [mouse-8] #'better-jumper-jump-backward
      :n [mouse-9] #'better-jumper-jump-forward)


(map! :map evil-window-map
      "SPC" #'rotate-layout)


(after! company
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.


;; PYTHON
(after! python
  ;; (add-hook 'python-mode-hook 'jedi:setup)
  ;; (defun my/python-mode-hook ()
  ;;   (add-to-list 'company-backends 'company-jedi))
  ;; (add-hook 'python-mode-hook 'my/python-mode-hook)
  ;; (setq python-shell-interpreter "~/.pyenv/versions/neovim3/bin/python")
  (add-hook 'python-mode-hook 'anaconda-mode)
  )

;; (add-hook 'python-mode-hook 'anaconda-mode)

;; Latex
(after! tex
  (setq +latex-viewers '(zathura))
  ;; (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
  (add-hook 'latex-mode-hook 'turn-on-cdlatex)
  )

(after! latex
  (setq +latex-viewers '(zathura))
  ;; (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
  (add-hook 'latex-mode-hook 'turn-on-cdlatex)
  )

;; (use-package! auto-activating-snippets
;;   :hook (LaTeX-mode . auto-activating-snippets-mode)
;;   :config (require 'latex-auto-activating-snippets))

;; (use-package! latex-auto-activating-snippets
;;   :config
;;   (defun als-tex-fold-maybe ()
;;     (unless (equal "/" als-transient-snippet-key)
;;       (+latex-fold-last-macro-a)))
;;   (add-hook 'aas-post-snippet-expand-hook #'als-tex-fold-maybe))



;; Bookmarks
(map! :leader
      :desc "List bookmarks"
      "b L" #'list-bookmarks
      :leader
      :desc "Save current bookmarks to bookmark file"
      "b w" #'bookmark-save)

;; Try new themes
(map! :leader
      :desc "Load new theme"
      "h t" #'counsel-load-theme)


;; DIRED
(map! :leader
      :desc "Dired"
      "d d" #'dired
      :leader
      :desc "Dired jump to current"
      "d j" #'dired-jump
      (:after dired
        (:map dired-mode-map
         :leader
         :desc "Peep-dired image previews"
         "d p" #'peep-dired
         :leader
         :desc "Dired view file"
         "d v" #'dired-view-file)))
;; Make 'h' and 'l' go back and forward in dired. Much faster to navigate the directory structure!
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
;; If peep-dired is enabled, you will get image previews as you go up/down with 'j' and 'k'
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "vlc")
                              ("mp4" . "vlc")))
