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
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)
(map! :n [mouse-8] #'better-jumper-jump-backward
      :n [mouse-9] #'better-jumper-jump-forward)
(custom-set-faces! '(doom-modeline-buffer-modified :foreground "orange"))
(setq global-hl-todo-mode t)
(map! :leader
      :desc "Load new theme"
      "h t" #'counsel-load-theme)

;; MODELINE
(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)
(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))
(setq global-hl-todo-mode t)




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

(setq deft-directory "~/docs/notes"
      deft-extensions '("org" "txt")
      deft-recursive t)

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation))

(setq reftex-default-bibliography (quote ("~/texmf/bibtex/bib/refs_zot.bib")))
(use-package! org-ref
  :after org
  :config
  (setq org-ref-completion-library 'org-ref-ivy-cite))
(require 'org-ref)
(setq org-ref-default-bibliography '("~/texmf/bibtex/bib/refs_zot.bib"))
(setq bibtex-completion-bibliography "~/texmf/bibtex/bib/refs_zot.bib")
(setq bibtex-completion-pdf-field "file")
(defun my/org-ref-open-pdf-at-point ()
  "Open the pdf for bibtex key under point if it exists."
  (interactive)
  (let* ((results (org-ref-get-bibtex-key-and-file))
         (key (car results))
	 (pdf-file (car (bibtex-completion-find-pdf key))))
    (if (file-exists-p pdf-file)
	(org-open-file pdf-file)
      (message "No PDF found for %s" key))))
(setq org-ref-open-pdf-function 'my/org-ref-open-pdf-at-point)


(after! org
  (add-hook 'org-mode-hook 'org-mode-reftex-setup)
  (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
    (defadvice! org-edit-latex-emv-after-insert ()
      :after #'org-cdlatex-environment-indent
      (org-edit-latex-environment))
  (setq org-directory "~/docs/notes/"
        org-use-property-inheritance t  ; it's convenient to have properties inherited
        ;; org-export-in-background t        ; run export processes in external emacs process
        ;; org-catch-invisible-edits 'smart  ; try not to accidently do weird stuff in invisible regions
        org-agenda-files '("~/docs/notes/agenda.org" "~/docs/notes/tasks.org")
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
        org-journal-dir "~/docs/notes/journal/"
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
  ;; (setq org-link-search-must-match-exact-headline nil)
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

(setq org-super-agenda-groups '((:name "Today"
                                  :time-grid t
                                  :scheduled today)
                           (:name "Due today"
                                  :deadline today)
                           (:name "Important"
                                  :priority "A")
                           (:name "Overdue"
                                  :deadline past)
                           (:name "Due soon"
                                  :deadline future)
                           (:name "Big Outcomes"
                                  :tag "bo")))




;; ------------------------------------------------------------------------------
;; LATEX

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-view-evince-keep-focus t)
(setq TeX-file-line-error t)
;; (setq +latex-viewers '(zathura))
(after! latex
  (map! :map cdlatex-mode-map
      :i "TAB" #'cdlatex-tab)
  )

(use-package! auto-activating-snippets
  :hook (LaTeX-mode . auto-activating-snippets-mode)
  :hook (org-mode . auto-activating-snippets-mode)
  :config (require 'latex-auto-activating-snippets)
  (use-package! latex-auto-activating-snippets)
  (apply #'aas-set-snippets 'org-mode laas-basic-snippets)
  (apply #'aas-set-snippets 'org-mode laas-subscript-snippets)
  (apply #'aas-set-snippets 'org-mode laas-frac-snippet)
  (apply #'aas-set-snippets 'org-mode laas-accent-snippets)
  )

(use-package! latex-auto-activating-snippets
  :config
  (defun als-tex-fold-maybe ()
    (unless (equal "/" als-transient-snippet-key)
      (+latex-fold-last-macro-a)))
  (add-hook 'aas-post-snippet-expand-hook #'als-tex-fold-maybe))


(after! tex
  (map!
   :map LaTeX-mode-map
   :ei [C-return] #'LaTeX-insert-item)
  (setq TeX-electric-math '("\\(" . "")))

(after! latex
  (setq TeX-show-compilation t))

(defun string-offset-roman-chars (offset word)
  "Shift the codepoint of each charachter in WORD by OFFSET with an extra -6 shift if the letter is lowercase"
  (apply 'string
         (mapcar (lambda (c)
                   (string-offset-apply-roman-char-exceptions
                    (+ (if (>= c 97) (- c 6) c) offset)))
                 word)))

(defvar string-offset-roman-char-exceptions
  '(;; lowercase serif
    (119892 .  8462) ; ℎ
    ;; lowercase caligraphic
    (119994 . 8495) ; ℯ
    (119996 . 8458) ; ℊ
    (120004 . 8500) ; ℴ
    ;; caligraphic
    (119965 . 8492) ; ℬ
    (119968 . 8496) ; ℰ
    (119969 . 8497) ; ℱ
    (119971 . 8459) ; ℋ
    (119972 . 8464) ; ℐ
    (119975 . 8466) ; ℒ
    (119976 . 8499) ; ℳ
    (119981 . 8475) ; ℛ
    ;; fraktur
    (120070 . 8493) ; ℭ
    (120075 . 8460) ; ℌ
    (120076 . 8465) ; ℑ
    (120085 . 8476) ; ℜ
    (120092 . 8488) ; ℨ
    ;; blackboard
    (120122 . 8450) ; ℂ
    (120127 . 8461) ; ℍ
    (120133 . 8469) ; ℕ
    (120135 . 8473) ; ℙ
    (120136 . 8474) ; ℚ
    (120137 . 8477) ; ℝ
    (120145 . 8484) ; ℤ
    )
  "An alist of deceptive codepoints, and then where the glyph actually resides.")

(defun string-offset-apply-roman-char-exceptions (char)
  "Sometimes the codepoint doesn't contain the char you expect.
Such special cases should be remapped to another value, as given in `string-offset-roman-char-exceptions'."
  (if (assoc char string-offset-roman-char-exceptions)
      (cdr (assoc char string-offset-roman-char-exceptions))
    char))

(defun TeX-fold-parenthesize-as-neccesary (tokens &optional suppress-left suppress-right)
  "Add ❪ ❫ parenthesis as if multiple LaTeX tokens appear to be present"
  (if (TeX-string-single-token-p tokens) tokens
    (concat (if suppress-left "" "❪")
            tokens
            (if suppress-right "" "❫"))))

(defun TeX-string-single-token-p (teststring)
  "Return t if TESTSTRING appears to be a single token, nil otherwise"
  (if (string-match-p "^\\\\?\\w+$" teststring) t nil))


(setq TeX-fold-math-spec-list
  `(;; missing/better symbols
  ("≤" ("le"))
  ("≥" ("ge"))
  ("≠" ("ne"))
  ;; conviniance shorts -- these don't work nicely ATM
  ;; ("‹" ("left"))
  ;; ("›" ("right"))
  ;; private macros
  ("ℝ" ("RR"))
  ("ℕ" ("NN"))
  ("ℤ" ("ZZ"))
  ("ℚ" ("QQ"))
  ("ℂ" ("CC"))
  ("ℙ" ("PP"))
  ("ℍ" ("HH"))
  ("𝔼" ("EE"))
  ("𝑑" ("dd"))
  ;; known commands
  ("" ("phantom"))
  (,(lambda (num den) (if (and (TeX-string-single-token-p num) (TeX-string-single-token-p den))
                          (concat num "／" den)
                          (concat "❪" num "／" den "❫"))) ("frac"))
  (,(lambda (arg) (concat "√" (TeX-fold-parenthesize-as-neccesary arg))) ("sqrt"))
  (,(lambda (arg) (concat "⭡" (TeX-fold-parenthesize-as-neccesary arg))) ("vec"))
  ("‘{1}’" ("text"))
  ;; private commands
  ("|{1}|" ("abs"))
  ("‖{1}‖" ("norm"))
  ("⌊{1}⌋" ("floor"))
  ("⌈{1}⌉" ("ceil"))
  ("⌊{1}⌉" ("round"))
  ("𝑑{1}/𝑑{2}" ("dv"))
  ("∂{1}/∂{2}" ("pdv"))
  ;; fancification
  ("{1}" ("mathrm"))
  (,(lambda (word) (string-offset-roman-chars 119743 word)) ("mathbf"))
  (,(lambda (word) (string-offset-roman-chars 119951 word)) ("mathcal"))
  (,(lambda (word) (string-offset-roman-chars 120003 word)) ("mathfrak"))
  (,(lambda (word) (string-offset-roman-chars 120055 word)) ("mathbb"))
  (,(lambda (word) (string-offset-roman-chars 120159 word)) ("mathsf"))
  (,(lambda (word) (string-offset-roman-chars 120367 word)) ("mathtt"))
  )
  TeX-fold-macro-spec-list
  '(
  ;; as the defaults
  ("[f]" ("footnote" "marginpar"))
  ("[c]" ("cite"))
  ("[l]" ("label"))
  ("[r]" ("ref" "pageref" "eqref"))
  ("[i]" ("index" "glossary"))
  ("..." ("dots"))
  ("{1}" ("emph" "textit" "textsl" "textmd" "textrm" "textsf" "texttt"
          "textbf" "textsc" "textup"))
  ;; tweaked defaults
  ("©" ("copyright"))
  ("®" ("textregistered"))
  ("™"  ("texttrademark"))
  ("[1]:||►" ("item"))
  ("❡❡ {1}" ("part" "part*"))
  ("❡ {1}" ("chapter" "chapter*"))
  ("§ {1}" ("section" "section*"))
  ("§§ {1}" ("subsection" "subsection*"))
  ("§§§ {1}" ("subsubsection" "subsubsection*"))
  ("¶ {1}" ("paragraph" "paragraph*"))
  ("¶¶ {1}" ("subparagraph" "subparagraph*"))
  ))

(after! cdlatex
  (setq ;; cdlatex-math-symbol-prefix ?\; ;; doesn't work at the moment :(
   cdlatex-math-symbol-alist
   '( ;; adding missing functions to 3rd level symbols
     (?_    ("\\downarrow"  ""           "\\inf"))
     (?2    ("^2"           "\\sqrt{?}"     ""     ))
     (?3    ("^3"           "\\sqrt[3]{?}"  ""     ))
     (?^    ("\\uparrow"    ""           "\\sup"))
     (?k    ("\\kappa"      ""           "\\ker"))
     (?m    ("\\mu"         ""           "\\lim"))
     (?c    (""             "\\circ"     "\\cos"))
     (?d    ("\\delta"      "\\partial"  "\\dim"))
     (?D    ("\\Delta"      "\\nabla"    "\\deg"))
     ;; no idea why \Phi isnt on 'F' in first place, \phi is on 'f'.
     (?F    ("\\Phi"))
     ;; now just conveniance
     (?.    ("\\cdot" "\\dots"))
     (?:    ("\\vdots" "\\ddots"))
     (?*    ("\\times" "\\star" "\\ast")))
   cdlatex-math-modify-alist
   '( ;; my own stuff
     (?B    "\\mathbb"        nil          t    nil  nil)
     (?a    "\\abs"           nil          t    nil  nil))))
