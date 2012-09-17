(setq ropemacs-global-prefix "C-c p")
(add-to-list 'load-path (concat prelude-vendor-dir "/epy"))
;;(load "epy-init.el")
(require 'epy-setup)      ;; It will setup other loads, it is required!
(require 'epy-python)     ;; If you want the python facilities [optional]
(require 'epy-completion) ;; If you want the autocompletion settings [optional]
;;(require 'epy-editing)    ;; For configurations related to editing [optional]
(require 'epy-bindings)   ;; For gabrielelanaro's suggested keybindings [optional]
(require 'epy-nose)       ;; For nose integration
(epy-setup-ipython)
(epy-setup-checker "pyflakes %f")
(setq virtualenv-workon-home "~/dev/ve")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
