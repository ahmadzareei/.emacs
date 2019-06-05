(package-initialize)
(require 'cl)

  ;; Org-mode that was shipped with Emacs
  ;;(setq load-path (remove-if (lambda (x) (string-match-p "org$" x)) load-path))
  ;; ELPA 
  ;;(setq load-path (remove-if (lambda (x) (string-match-p "org-20" x)) load-path))

  ;;(setq custom-org-path "/home/mathiew/.emacs.d/.cask/24.5/elpa/org-20171225")   
  ;;(add-to-list 'load-path custom-org-path)

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
 '(org-babel-load-languages
   (quote
    ((emacs-lisp . t)
     (python . t)
     (latex . t)
     (octave . t)
     (gnuplot . t))))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   (quote
    (virtualenv virtualenvwrapper pyenv-mode conda anaconda-mode jedi elpy exec-path-from-shell px ein zenburn-theme yasnippet wordnut try tramp-term synosaurus synonymous sunshine sublime-themes ssh spotify solarized-theme smart-mode-line pallet org2jekyll org-ref org-preview-html org-edit-latex org-bullets ob-ipython multi-term mu4e-alert matlab-mode magit latex-preview-pane latex-pretty-symbols latex-extra helm-bbdb guide-key google-translate google-this google-maps google-contacts forecast flyspell-correct-ivy flycheck expand-region elfeed-org elfeed-goodies discover dired-open diff-hl dashboard csv counsel-dash color-theme-sanityinc-solarized color-theme cdlatex bbdb-vcard artbollocks-mode aggressive-indent ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
