;; EXPORT
(require 'org-latex)
(add-to-list 'org-export-latex-classes
             '("koma-article"
               "\\documentclass{scrartcl}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(defun my-aput (alist key value)
  (let ((al (symbol-value alist))
        cell)
    (cond ((null al) (set alist (list (cons key value))))
          ((setq cell (assoc key al)) (setcdr cell value))
          (t (set alist (cons (cons key value) al))))))

(my-aput 'org-export-latex-classes "ebook"
             '(

               "\\documentclass[12pt,oneside,openany,x11names,svgnames]{memoir}

                \\usepackage{boothead}
                [NO-PACKAGES]
                [NO-DEFAULT-PACKAGES]
                [NO-EXTRA]"

                ("\\chapter{%s}" . "\\chapter*{%s}")
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(defun org-export-latex-no-toc (depth)
  (when depth
    (format "%% Org-mode is exporting headings to %s levels.\n"
            depth)))
(setq org-export-latex-format-toc-function 'org-export-latex-no-toc)

(defun bh/count-book (&optional b e)
  "Count words in book"
  (interactive "r")
  (shell-command-on-region b e "wc -w" "*wc-book*"))

(org-add-link-type
 "latex" nil
 (lambda (path desc format)
   (cond
    ((eq format 'html)
     (format "<span class=\"%s\">%s</span>" path desc))
    ((eq format 'latex)
     (format "\\%s{%s}" path desc)))))

(fset 'count-words-book
   (lambda (&optional arg)
     "Keyboard macro."
     (interactive "p")
     (kmacro-exec-ring-item
      (quote ([tab 21 3 46 return tab 24 98 98 111 111 return 134217788 19 73 110 116 114 111 100 117 99 116 105 111 110 13 1 67108896 134217790 134217848 up up down down 98 104 47 99 111 tab return 24 98 42 119 99 45 tab 134217790 134217826 67108896 134217830 134217847 24 98 right return 25] 0 "%d")) arg)))


;; SETUP MINTED FOR EXPORT
(setq org-export-latex-listings 'minted)
(add-to-list 'org-export-latex-packages-alist '("" "minted"))
(add-to-list
 'org-export-latex-packages-alist '("" "color"))
(setq org-export-latex-listings 'minted)
(setq org-export-latex-minted-options
      '(("frame" "none")
        ("fontsize" "\\footnotesize")
        ("linenos" "")
        ;;("bgcolor" "codebg")
        ("xleftmargin" "40pt")))

(setq org-src-fontify-natively t)
(defface org-block-begin-line
  '((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
  "Face used for the line delimiting the begin of source blocks.")

(defface org-block-background
  '((t (:background "#FFFFEA")))
  "Face used for the source block background.")

(defface org-block-end-line
  '((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#EAEAFF")))
  "Face used for the line delimiting the end of source blocks.")
