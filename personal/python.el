(setq ropemacs-global-prefix "C-c p")
(load-file "~/dev/emacs/python/epy-init.el")
(epy-setup-ipython)
(epy-setup-checker "pyflakes %f")
(setq virtualenv-workon-home "~/dev/ve")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
