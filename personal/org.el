(require 'org-remember)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(custom-set-variables
 '(org-directory "~/Dropbox/org")
)
(setq org-default-notes-file (concat org-directory "/inbox.org"))
(define-key global-map "\C-cc" 'org-capture)


(setq org-capture-templates
      '(("t" "todo" entry (file "~/Dropbox/org/inbox.org")
         "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
        ("r" "respond" entry (file+headline "~/Dropbox/org/inbox.org" "Response")
         "* TODO Respond to %:from on %:subject\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
        ("n" "note" entry (file "~/Dropbox/org/notes.org")
         "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
        ("c" "capture" entry (file+headline "~/Dropbox/org/inbox.org" "Capture")
         "* %^{Title}  :capture:\n\n  Source: %u, %c\n\n  %i"
         :empty-lines 1 )))

(setq org-capture-default-template "c")
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
