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

               "\\documentclass[11pt,twoside,openany,x11names,svgnames]{memoir}
                [NO-DEFAULT-PACKAGES]
                [PACKAGES]
                [EXTRA]"

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

(fset 'count-words-book
   (lambda (&optional arg)
     "Keyboard macro."
     (interactive "p")
     (kmacro-exec-ring-item
      (quote ([tab 21 3 46 return tab 24 98 98 111 111 return 134217788 19 73 110 116 114 111 100 117 99 116 105 111 110 13 1 67108896 134217790 134217848 up up down down 98 104 47 99 111 tab return 24 98 42 119 99 45 tab 134217790 134217826 67108896 134217830 134217847 24 98 right return 25] 0 "%d")) arg)))
