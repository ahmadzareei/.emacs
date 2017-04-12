(org-babel-load-file "~/.emacs.d/configuration.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-list
   (quote
    (("preview-pane-mode"
      (latex-preview-pane-mode)
      nil))))
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (engine-omega "Atril")
     (output-pdf "preview-pane-mode")
     (output-html "xdg-open"))))
 '(latex/override-font-map nil)
 '(org-agenda-files
   (quote
    ("~/Dropbox/Ahmad_Reza/6_quantum_droplet/scratch/review.org" "~/Dropbox/org/home.org" "~/Dropbox/org/scholar.org")))
 '(org-babel-load-languages
   (quote
    ((emacs-lisp . t)
     (python . t)
     (octave . t)
     (gnuplot . t))))
 '(org-confirm-babel-evaluate nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
