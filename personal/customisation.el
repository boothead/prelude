(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-command "coffee")
 '(custom-safe-themes (quote ("501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" default)))
 '(jira-url "http://syn/jira/rpc/xmlrpc")
 '(minimap-dedicated-window t)
 '(minimap-width-fraction 0.15)
 '(virtualenv-root "~/dev/ve"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(set-default-font "Inconsolata-12")
;;(setq initial-scratch-message "ಠ_ಠ")
(load-theme 'solarized-dark t)


(defun prelude-prog-mode-hook ()
  "Default coding hook, useful with any programming language."
  (flyspell-prog-mode)
  (linum-mode 1)
  (prelude-local-comment-auto-fill)
  (prelude-turn-off-whitespace)
  (prelude-turn-on-abbrev)
  (prelude-add-watchwords)
  ;; keep the whitespace decent all the time
  (add-hook 'before-save-hook 'whitespace-cleanup nil t)
  )
(add-hook 'prog-mode-hook 'prelude-turn-off-whitespace t)

(defun path-from-shell (sh-cmd)
  "Get the $PATH from a login shell"
  ;;(interactive)

  (split-string (replace-regexp-in-string "[ \t\n]*$" ""
                                          (shell-command-to-string
                                           (concat (executable-find sh-cmd) " --login -i -c 'echo $PATH'")))
                path-separator)
  )

(defun set-exec-path-from-shell-PATH (sh-cmd)
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path (path-from-shell sh-cmd)))
    (setenv "PATH" (mapconcat (lambda (e) e) path path-separator))
    (setq exec-path path)
    ))

(set-exec-path-from-shell-PATH "zsh")

;; (autoload 'window-number-meta-mode "window-number"
;;   "A global minor mode that enables use of the M- prefix to select
;; windows, use `window-number-mode' to display the window numbers in
;; the mode-line."
;;   t)
;; ;;(window-number-mode 1)
;; (window-number-meta-mode 1)

;; Setup simple-rtm
(add-to-list 'load-path (concat prelude-vendor-dir "/simple-rtm/lisp"))
(autoload 'simple-rtm-mode "simple-rtm" "Interactive mode for Remember The Milk" t)
(require 'rtm)
(defun rtm-get-list-names ()
  "Get all my list (project) names from RTM"
  (interactive)
  (mapcar (lambda (lst)  (cdr (assoc 'name (car (cdr lst)))))
          (rtm-lists-get-list)))
