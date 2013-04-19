(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-command "coffee")
 '(custom-safe-themes (quote ("501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" default)))
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

(global-auto-revert-mode 1)
(global-linum-mode 1)

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(defun prelude-prog-mode-hook ()
  "Default coding hook, useful with any programming language."
  (flyspell-prog-mode)
  (linum-mode 1)
  (prelude-local-comment-auto-fill)
  (prelude-turn-on-abbrev)
  (prelude-add-watchwords)
  ;; keep the whitespace decent all the time
  (add-hook 'before-save-hook 'whitespace-cleanup nil t)
  )

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

;; Setup org-jira
(setq jiralib-url "https://solaise.atlassian.net")
;; (add-to-list 'load-path (concat prelude-vendor-dir "/org-jira"))
;; (require 'org-jira)

(defun insert-pound ()
  "Inserts a pound into the buffer"
   (insert "#"))
(global-set-key (kbd "M-3") '(lambda()(interactive)(insert-pound)))

;; Set up web-mode
(add-to-list 'load-path (concat prelude-vendor-dir "/web-mode"))
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jinja2\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'web-mode-hook)


;; Dired/ibuffer setup

(setq ibuffer-saved-filter-groups
    '(("home"
       ("emacs-config" (or (filename . ".emacs.d")
                           (filename . "emacs-config")))
       ("ticketmanager" (filename . "ticket-manager"))
       ("Org" (or (mode . org-mode)
                  (filename . "OrgMode")))
       ("dev" (filename . "dev"))
       ("Magit" (name . "\*magit"))
       ("Dired" (mode . dired-mode))
       ("Help" (or (name . "\*Help\*")
                   (name . "\*Apropos\*")
                   (name . "\*info\*"))))))

(setq ibuffer-show-empty-filter-groups nil)

(defun ibuffer-set-up-preferred-filters ()
  (ibuffer-vc-set-filter-groups-by-vc-root)
  (unless (eq ibuffer-sorting-mode 'filename/process)
    (ibuffer-do-sort-by-filename/process)))

(add-hook 'ibuffer-hook 'ibuffer-set-up-preferred-filters)
(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode 1)
             (ibuffer-switch-to-saved-filter-groups "home")))


(eval-after-load 'ibuffer
  '(progn
     ;; Use human readable Size column instead of original one
     (define-ibuffer-column size-h
       (:name "Size" :inline t)
       (cond
        ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
        ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
        (t (format "%8d" (buffer-size)))))))


;; Explicitly require ibuffer-vc to get its column definitions, which
;; can't be autoloaded
(eval-after-load 'ibuffer
  '(require 'ibuffer-vc))

;; Modify the default ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 18 18 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              (vc-status 16 16 :left)
              " "
              filename-and-process)))

(setq ibuffer-filter-group-name-face 'font-lock-doc-face)
