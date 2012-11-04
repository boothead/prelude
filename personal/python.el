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

;; (require 'ein)
;; (defadvice ein:url-no-cache
;;   (around ein:url-no-cache-no (url) activate)
;;   "Do not use jQuery-like caching workaround."
;;   (setq ad-return-value url))
