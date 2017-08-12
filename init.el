(package-initialize)
(require 'cl)

  ;; Org-mode that was shipped with Emacs
  (setq load-path (remove-if (lambda (x) (string-match-p "org$" x)) load-path))
  ;; ELPA 
  (setq load-path (remove-if (lambda (x) (string-match-p "org-20" x)) load-path))

  (setq custom-org-path "/home/mathiew/.emacs.d/.cask/26.0/elpa/org-20170807")   
  (add-to-list 'load-path custom-org-path)

(org-babel-load-file "~/.emacs.d/configuration.org")
