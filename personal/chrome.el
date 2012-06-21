(when (and (require 'edit-server nil t) (daemonp))
  (edit-server-start))
