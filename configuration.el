(load-file "~/.emacs.d/sources/better-defaults.el")
(require 'better-defaults)

(setq user-full-name "Ahmad Zareei"
      user-mail-address "zareei@berkeley.edu"
      calendar-latitude 37.8716
      calendar-longitude -122.2727
      calendar-location-name "Berkeley, CA")

(add-to-list 'load-path "~/.emacs.d/sources/")

(require 'cask "~/.emacs.d/cask/cask.el")
(cask-initialize) 
(require 'pallet)
(pallet-mode t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(when window-system
  (scroll-bar-mode -1))

(load-theme 'zenburn t)
(load-theme 'tango-dark)

(when window-system
  (global-hl-line-mode)
  (set-face-background 'hl-line "#171717"))

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-_") 'text-scale-decrease)

(setq fci-rule-column 90)
(defun az/fill-or-unfill ()
  "Like `fill-paragraph', but unfill if used twice."
  (interactive)
  (let ((fill-column
         (if (eq last-command 'az/fill-or-unfill)
             (progn (setq this-command nil)
                    (point-max))
           fill-column)))
    (call-interactively #'fill-paragraph)))

(global-set-key [remap fill-paragraph]
                #'az/fill-or-unfill)

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-c" "C-x r" "C-x v" "C-x 4"))
(guide-key-mode 1) ; Enable guide-key-mode

(fset 'yes-or-no-p 'y-or-n-p)

(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-startup-banner "~/.emacs.d/sources/startup3.png")
(setq dashboard-banner-logo-title "Dream Big, Work hard!")

(setq dashboard-items '((bookmarks . 5)
                         (recents  . 5)))
;;                          (agenda . 5)))
;;;;                      (projects . 5)

(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode

(add-hook 'LaTeX-mode-hook #'latex-extra-mode)

(custom-set-variables '(latex/override-font-map nil))

(eval-after-load "tex"
  '(add-to-list
    'TeX-view-program-list
    '("preview-pane-mode"
      latex-preview-pane-mode)))
;; (add-hook 'LaTeX-mode-hook #'latex-preview-pane-mode)
(custom-set-variables
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
     (output-html "xdg-open")))))

(add-hook 'LaTeX-mode-hook
          (lambda () (local-set-key (kbd "<f6>") #'preview-buffer)))
(add-hook 'LaTeX-mode-hook
          (lambda () (local-set-key (kbd "<f5>") #'preview-environment)))

(add-hook 'LaTeX-mode-hook
          (lambda () (local-set-key (kbd "<f7>") #'latex-preview-pane-mode)))
(add-hook 'LaTeX-mode-hook
          (lambda () (local-set-key (kbd "M-p") #'ace-window)))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-default-bibliography '("~/Dropbox/Research/Bibtex/library.bib"))

(require 'diff-hl)
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

(global-set-key (kbd "C-c s") 'multi-term)

(setq dired-open-extensions
      '(("pdf" . "evince")
        ("mkv" . "vlc")
        ("mp4" . "vlc")
        ("avi" . "vlc")
        ("mp3" . "vlc")))

(setq-default dired-listing-switches "-lhA")

(setq dired-clean-up-buffers-too t)

(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'top)

(require 'tramp-term)

(autoload 'freefem++-mode "freefem++-mode"
		"Major mode for editing FreeFem++ code." t)
	(add-to-list 'auto-mode-alist '("\\.edp$" . freefem++-mode))
	(add-to-list 'auto-mode-alist '("\\.idp$" . freefem++-mode))
(setq freefempp-program "FreeFem++-nw")

(defun matlab-shell-here ()
  "opens up a new matlab shell in the directory associated with the current buffer's file."
  (interactive)
  (split-window-right)
  (other-window 1)
  (matlab-shell))

(defhydra hydra-matlab (:color blue
                               :hint nil)
  "
 _c_: cell   _r_: region    _s_: start    _m_: interrupt
 _l_: line   _C_: command   _S_: switch   _q_: quit
"
  ("c" matlab-shell-run-cell)
  ("l" matlab-shell-run-region-or-line)
  ("r" matlab-shell-run-region)
  ("C" matlab-shell-run-command)
  ("s" matlab-shell-here)
  ("S" matlab-show-matlab-shell-buffer)
  ("m" term-interrupt-subjob)
  ("q" nil :color blue))
(global-set-key (kbd "C-c m ") 'hydra-matlab/body)

(require 'ein)
(require 'ein-notebook)
(require 'ein-subpackages)

(pyenv-mode)
(elpy-enable)
(setenv "WORKON_HOME" "~/.pyenv/versions/")
(setq elpy-rpc-backend "jedi")
;; (setq python-shell-interpreter "~/.pyenv/shims/python3")
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:server-args
      '("--virtual-env" "/home/mathiew/.pyenv/versions/basic"
        "--virtual-env" "/home/mathiew/.pyenv/versions/venv"))
(setq elpy-rpc-backend "jedi")
(elpy-rpc-restart)
(setq venv-location (expand-file-name "/home/mathiew/.pyenv/versions"))   ;; Change with the path to your virtualenvs
;; Used python-environment.el and by extend jedi.el
(setq python-environment-directory venv-location)

;; save recent files
(require 'recentf)
(recentf-mode t)
(setq recentf-save-file (concat user-emacs-directory "recentf")
      recentf-max-saved-items 200
      recentf-max-menu-items 15)
(global-set-key (kbd "C-x C-g") 'recentf-open-files)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-fi1nd-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
(setq ivy-use-virtual-buffers t)

;; store all autosave files in the tmp dir
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
;; backups in backup dir
(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.emacs.d/backup"))
      delete-old-versions t
      kept-new-versions 24
      kept-old-versions 12
      version-control t)
(setq create-lockfiles nil)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(line-number-mode t)
(column-number-mode t)
(size-indication-mode nil)

(global-set-key (kbd "M-p") 'ace-window)

(global-set-key (kbd "C-V") 'scroll-other-window-down)
(global-set-key (kbd "M-V") 'scroll-other-window-up)

(global-set-key (kbd "C-<") 'shrink-window-horizontally)
(global-set-key (kbd "C->") 'enlarge-window-horizontally)
(global-set-key (kbd "C-{") 'shrink-window)
(global-set-key (kbd "C-}") 'enlarge-window)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(defun xah-open-in-desktop ()
  "Show current file in desktop (OS's file manager).
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2015-11-30"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" default-directory t t)))
   ((string-equal system-type "darwin") (shell-command "open ."))
   ((string-equal system-type "gnu/linux")
    (let (
          (process-connection-type nil)
          (openFileProgram (if (file-exists-p "/usr/bin/xdg-open")
                               "/usr/bin/gvfs-open"
                             "/usr/bin/gvfs-open")))
      (start-process "" nil openFileProgram "."))
    ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. For example: with nautilus
    )))
(global-set-key (kbd "<f4>") 'xah-open-in-desktop)

(setq global-flycheck-mode t)
(global-set-key (kbd "<f8>") 'flyspell-buffer)
;;(global-set-key (kbd "<f8>") 'hydra-flycheck/body)

(require 'artbollocks-mode)
(setq artbollocks-weasel-words-regex
          (concat "\\b" (regexp-opt
                         '("one of the"
                           "should"
                           "just"
                           "sort of"
                           "a lot"
                           "probably"
                           "maybe"
                           "perhaps"
                           "really"
                           "pretty"
                           "nice"
                           "action"
                           "utilize"
                           "leverage") t) "\\b"))
(setq artbollocks-jargon nil)

(require 'org-ref)
(require 'helm-bibtex)
(require 'org-edit-latex)
(setq org-ref-open-pdf-function 'org-ref-get-mendeley-filename)
;; (define-key helm-map (kbd "C-z") 'helm-select-action)

 (defhydra hydra-org-ref (:color blue :hint nil)
   "
   Cite^     ^Insert Bibtex^         ^view^                (?)
---------------------------------------------------------------
  _c_ite      _b_ibtex crossref     _g_oogle scholar
  _r_ef       _d_oi insert          _u_rl 
  _l_abel     _q_uit                _e_xtract
      "
   ("c" org-ref-helm-insert-cite-link)
   ("r" org-ref-helm-insert-ref-link)
   ("l" org-ref-helm-insert-label-link)
   ("b" crossref-add-bibtex-entry)
   ("d" doi-insert-bibtex)
   ("g" org-ref-google-scholar-at-point)
   ("u" org-ref-open-url-at-point)
   ("e" org-ref-extract-bibtex-entries)
   ("?" org-ref-help)
   ("q" keyboard-quit))

 (global-set-key (kbd "C-c ( ") 'hydra-org-ref/body)

(setq  org-latex-pdf-process
       '("latexmk -shell-escape -bibtex -pdf %f"))

(require 'org-habit)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(i)" "SOMEDAY(s)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("IN-PROGRESS" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("SOMEDAY" :foreground "green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

(setq org-startup-with-inline-images t)
(defun do-org-show-all-inline-images ()
  (interactive)
  (org-display-inline-images t t))
(global-set-key (kbd "C-c C-x C-v")
                'do-org-show-all-inline-images)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-src-fontify-natively t)

(setq org-agenda-files (list "~/Dropbox/org/home.org"
                             "~/Dropbox/org/scholar.org"))

(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file "~/Dropbox/org/inbox.org")

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/org/inbox.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(setq org-log-done 'time)
;; (setq org-log-done 'note)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Dropbox/org/inbox.org")
               "* TODO %?\n%U\n%a\n" )
              ("n" "note" entry (file "~/Dropbox/org/notes.org")
               "* %? :NOTE:\n%U\n%a\n")
              ("d" "Diary" entry (file+datetree "~/Dropbox/org/diary.org")
               "* %?\n%U\n" )
              ("m" "Meeting" entry (file "~/Dropbox/org/inbox.org")
               "* MEETING with %? :MEETING:\n%U")
              ("p" "Phone call" entry (file "~/Dropbox/org/inbox.org")
               "* PHONE %? :PHONE:TASK:\n%U"))))
;; I don't understand this one
;;               ("r" "respond" entry (file "~/Dropbox/org/inbox.org")
;;               "* NEXT Respond to %? subject %? \n SCHEDULED: %t\n%U\n%a\n" )

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets 
(setq org-refile-use-outline-path t)

; Targets complete directly
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))
;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun az/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'az/verify-refile-target)

(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f9> b") 'bbdb)
(global-set-key (kbd "<f9> c") 'calendar) 
(global-set-key (kbd "<f9> w") 'forecast);; weather forecast
(global-set-key (kbd "<f9> e") 'elfeed);; elfeed browser
(global-set-key (kbd "C-c c") 'org-capture)

(global-set-key (kbd "\e o i")
		(lambda () (interactive) (find-file "~/Dropbox/org/inbox.org")))
(global-set-key (kbd "\e o s")
		(lambda () (interactive) (find-file "~/Dropbox/org/scholar.org")))
(global-set-key (kbd "\e o h")
		(lambda () (interactive) (find-file "~/Dropbox/org/home.org")))
(global-set-key (kbd "\e o j")
		(lambda () (interactive) (find-file "~/Dropbox/org/journal.org")))

(setq org-use-fast-todo-selection t)

(setq org-treat-S-cursor-todo-selection-as-state-change nil)

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("IN-PROGRESS" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq org-indent-mode 1)
(setq  org-startup-indented 1)

(setq org-agenda-custom-commands
      '(("f" "Full List"
          (
             (agenda "" ((org-agenda-ndays 1))) 
             (todo "IN-PROGRESS")
             (todo "NEXT")
             (todo "TODO")
             (tags-todo "TASK")
             (tags-todo "PAPER")
             (tags-todo "SEMINAR")
             (tags-todo "HABIT")
             (tags-todo "PROJECTS")
             (tags-todo "READ")))
        ("t" "IN-PROGRESS, NEXT & TODO" ((todo "IN-PROGRESS") (todo "NEXT") (todo "TODO")))
        ("j" "JOURNAL PAPERS" tags-todo "PAPER")
        ("s" "SEMINAR" tags-todo "SEMINAR")
        ("c" "CALL" todo "PHONE")
        ("r" "READ" tags-todo "READ")
        )
 )

(setq diary-file "/Dropbox/org/diary.org")
(setq org-agenda-include-diary t)

(custom-set-variables
 '(org-babel-load-languages (quote ((emacs-lisp . t) 
                                    (python . t) 
                                    (latex . t)
                                    (octave . t)
                                    (gnuplot . t))))
 '(org-confirm-babel-evaluate nil))
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

(setq org-latex-create-formula-image-program 'imagemagick)
;; For changing the width of the image
(setq org-image-actual-width nil)





(defhydra hydra-org-clock (:color blue :hint nil)
   "
Clock   In/out^     ^Edit^   ^Summary     (_?_)
-----------------------------------------
        _i_n         _e_dit   _g_oto entry
        _c_ontinue   _q_uit   _d_isplay
        _o_ut        ^ ^      _r_eport
      "
   ("i" org-clock-in)
   ("o" org-clock-out)
   ("c" org-clock-in-last)
   ("e" org-clock-modify-effort-estimate)
   ("q" org-clock-cancel)
   ("g" org-clock-goto)
   ("d" org-clock-display)
   ("r" org-clock-report)
   ("?" (org-info "Clocking commands")))
 (global-set-key (kbd "C-c w ") 'hydra-org-clock/body)

;; specify the justification you want
(require 'ov)
(plist-put org-format-latex-options :justify 'left)

(defun org-justify-fragment-overlay (beg end image imagetype)
  "Adjust the justification of a LaTeX fragment.
The justification is set by :justify in
`org-format-latex-options'. Only equations at the beginning of a
line are justified."
  (cond
   ;; Centered justification
   ((and (eq 'center (plist-get org-format-latex-options :justify)) 
         (= beg (line-beginning-position)))
    (let* ((img (create-image image 'imagemagick t))
           (width (car (image-size img)))
           (offset (floor (- (/ (window-text-width) 2) (/ width 2)))))
      (overlay-put (ov-at) 'before-string (make-string offset ? ))))
   ;; Right justification
   ((and (eq 'right (plist-get org-format-latex-options :justify)) 
         (= beg (line-beginning-position)))
    (let* ((img (create-image image 'imagemagick t))
           (width (car (image-display-size (overlay-get (ov-at) 'display))))
           (offset (floor (- (window-text-width) width (- (line-end-position) end)))))
      (overlay-put (ov-at) 'before-string (make-string offset ? ))))))

(defun org-latex-fragment-tooltip (beg end image imagetype)
  "Add the fragment tooltip to the overlay and set click function to toggle it."
  (overlay-put (ov-at) 'help-echo
               (concat (buffer-substring beg end)
                       "mouse-1 to toggle."))
  (overlay-put (ov-at) 'local-map (let ((map (make-sparse-keymap)))
                                    (define-key map [mouse-1]
                                      `(lambda ()
                                         (interactive)
                                         (org-remove-latex-fragment-image-overlays ,beg ,end)))
                                    map)))

;; advise the function to a
(advice-add 'org--format-latex-make-overlay :after 'org-justify-fragment-overlay)
(advice-add 'org--format-latex-make-overlay :after 'org-latex-fragment-tooltip)
;; That is it. If you get tired of the advice, remove it like this:

;;(advice-remove 'org--format-latex-make-overlay 'org-justify-fragment-overlay)
;;(advice-remove 'org--format-latex-make-overlay 'org-latex-fragment-tooltip)



(defun org-renumber-environment (orig-func &rest args)
  "A function to inject numbers in LaTeX fragment previews."
  (let ((results '()) 
	(counter -1)
	(numberp))

    (setq results (loop for (begin .  env) in 
			(org-element-map (org-element-parse-buffer) 'latex-environment
			  (lambda (env)
			    (cons
			     (org-element-property :begin env)
			     (org-element-property :value env))))
			collect
			(cond
			 ((and (string-match "\\\\begin{equation}" env)
			       (not (string-match "\\\\tag{" env)))
			  (incf counter)
			  (cons begin counter))
			 ((string-match "\\\\begin{align}" env)
			  (prog2
			      (incf counter)
			      (cons begin counter)			    
			    (with-temp-buffer
			      (insert env)
			      (goto-char (point-min))
			      ;; \\ is used for a new line. Each one leads to a number
			      (incf counter (count-matches "\\\\$"))
			      ;; unless there are nonumbers.
			      (goto-char (point-min))
			      (decf counter (count-matches "\\nonumber")))))
			 (t
			  (cons begin nil)))))

    (when (setq numberp (cdr (assoc (point) results)))
      (setf (car args)
	    (concat
	     (format "\\setcounter{equation}{%s}\n" numberp)
	     (car args)))))
  
  (apply orig-func args))

(advice-add 'org-create-formula-image :around #'org-renumber-environment)

;; changing the size of the formula to 1.5
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.50))

(defvar az/org-latex-fragment-last nil
    "Holds last fragment/environment you were on.")

  (defun az/org-in-latex-fragment-p ()
    "Return the point where the latex fragment begins, if inside
  a latex fragment. Else return false"
    (let* ((el (org-element-context))
           (el-type (car el)))
      (and (or (eq 'latex-fragment el-type) (eq 'latex-environment el-type))
          (org-element-property :begin el))))

  (defun az/org-latex-fragment-toggle ()
    "Toggle a latex fragment image "
    (and (eq 'org-mode major-mode)
	 (let ((begin (az/org-in-latex-fragment-p)))
           (cond
            ;; were on a fragment and now on a new fragment
            ((and
              ;; fragment we were on
              az/org-latex-fragment-last
              ;; and are on a fragment now
              begin

              ;; but not on the last one this is a little tricky. as you edit the
              ;; fragment, it is not equal to the last one. We use the begin
              ;; property which is less likely to change for the comparison.
              (not (and az/org-latex-fragment-last
			(= begin
			   az/org-latex-fragment-last))))
             ;; go back to last one and put image back, provided there is still a fragment there
             (save-excursion
               (goto-char az/org-latex-fragment-last)
               (when (az/org-in-latex-fragment-p) (org-preview-latex-fragment))

               ;; now remove current image
               (goto-char begin)
               (let ((ov (loop for ov in (org--list-latex-overlays)
                               if
                               (and
				(<= (overlay-start ov) (point))
				(>= (overlay-end ov) (point)))
                               return ov)))
		 (when ov
                   (delete-overlay ov)))
               ;; and save new fragment
               (setq az/org-latex-fragment-last begin)))

            ;; were on a fragment and now are not on a fragment
            ((and
              ;; not on a fragment now
              (not begin)
              ;; but we were on one
              az/org-latex-fragment-last)
             ;; put image back on, provided that there is still a fragment here.
             (save-excursion
               (goto-char az/org-latex-fragment-last)
               (when (az/org-in-latex-fragment-p) (org-preview-latex-fragment)))

             ;; unset last fragment
             (setq az/org-latex-fragment-last nil))

            ;; were not on a fragment, and now are
            ((and
              ;; we were not one one
              (not az/org-latex-fragment-last)
              ;; but now we are
              begin)
             ;; remove image
             (save-excursion
               (goto-char begin)
               (let ((ov (loop for ov in (org--list-latex-overlays)
                               if
                               (and
				(<= (overlay-start ov) (point))
				(>= (overlay-end ov) (point)))
                               return ov)))
		 (when ov
                   (delete-overlay ov))))
             (setq az/org-latex-fragment-last begin))))))

(require 'ox-manuscript)

(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)

(setq yas/indent-line nil)

(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

(global-set-key (kbd "<f10>") 'mu4e)

(require 'bbdb)

(setq bbdb-file "~/Dropbox/bbdb/contacts")

(require 'mu4e)

;; default
(setq mu4e-maildir "~/Maildir")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;; show images
(setq mu4e-show-images t)

(setq
  mu4e-get-mail-command "offlineimap"   ;; or fetchmail, or ...
  mu4e-update-interval 300)             ;; update every 5 minutes

(setq
  mu4e-index-cleanup nil      ;; don't do a full cleanup check
  mu4e-index-lazy-check t)    ;; don't consider up-to-date dirs

(setq mu4e-user-mail-address-list (list "ahmad.zareei@gmail.com" "zareei@berkeley.edu" ))
(setq mu4e-drafts-folder "/gmail/[Gmail].Drafts") ;; I use my gmail to store drafts
;; Use fancy chars
(setq mu4e-use-fancy-chars t)
;; Shortcuts for my inboxes
(setq mu4e-maildir-shortcuts
      '(("/gmail/INBOX" . ?g)
        ("/bmail/INBOX" . ?b)
        ))
;; sending mail
(setq message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/bin/msmtp")
;; Choose account label to feed msmtp -a option based on From header
;; in Message buffer; This function must be added to
;; message-send-mail-hook for on-the-fly change of From address before
;; sending message since message-send-mail-hook is processed right
;; before sending message
(defun choose-msmtp-account ()
  (if (message-mail-p)
      (save-excursion
        (let*
            ((from (save-restriction
                     (message-narrow-to-headers)
                     (message-fetch-field "from")))
             (account
              (cond
               ((string-match "ahmad.zareei@gmail.com" from) "gmail")
               ((string-match "zareei@berkeley.edu" from) "bmail")
               ((string-match "ahmad@berkeley.edu" from) "bmail")
               ((string-match "azareei@berkeley.edu" from) "bmail"))))
          (setq message-sendmail-extra-arguments (list '"-a" account))))))
(setq message-sendmail-envelope-from 'header)
(add-hook 'message-send-mail-hook 'choose-msmtp-account)
;; When replying to an email I want to use the address I received this message to as the sender of the reply.
(add-hook 'mu4e-compose-pre-hook
          (defun my-set-from-address ()
            "Set the From address based on the To address of the original."
            (let ((msg mu4e-compose-parent-message)) ;; msg is shorter...
              (if msg
                  (setq user-mail-address
                        (cond
                         ((mu4e-message-contact-field-matches msg :to "ahmad.zareei@gmail.com")
                          "ahmad.zareei@gmail.com")
                         ((mu4e-message-contact-field-matches msg :to "zareei@berkeley.edu")
                          "zareei@berkeley.edu")
                         ((mu4e-message-contact-field-matches msg :to "ahmad@berkeley.edu")
                          "zareei@berkeley.edu")
                         ((mu4e-message-contact-field-matches msg :to "azareei@berkeley.edu")
                          "zareei@berkeley.edu")                  
                         (t "ahmad.zareei@gmail.com")))))))

(add-to-list 'mu4e-bookmarks
             '("maildir:/gmail/INBOX OR maildir:/bmail/INBOX flag:unread AND NOT flag:trashed" "Unread All"  ?a))
(add-to-list 'mu4e-bookmarks
             '("maildir:/gmail/INBOX flag:unread AND NOT flag:trashed" "Unread Gmail"  ?g))
(add-to-list 'mu4e-bookmarks
             '("maildir:/bmail/INBOX flag:unread AND NOT flag:trashed" "Unread Berkeley"  ?b))

;;; Save attachment (this can also be a function)
(setq mu4e-attachment-dir "~/attachments")

;; This is to use different settings for two different accounts that I have
;; Contexts
(require 'mu4e-context)
(setq mu4e-contexts
      `( ,(make-mu4e-context
           :name "Gmail - ahmad.zareei@gmail.com"
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :to "ahmad.zareei@gmail.com")))
           :vars '(

                   (mu4e-sent-messages-behavior . delete)
                   (mu4e-sent-folder . "/gmail/[Gmail].Sent Mail")
                   (mu4e-drafts-folder . "/gmail/[Gmail].Drafts")
                   (mu4e-trash-folder . "/gmail/[Gmail].Trash")
                   (mu4e-refile-folder . "/gmail/[Gmail].Archive")
                   (user-mail-address . "ahmad.zareei@gmail.com")
                   ))
         ,(make-mu4e-context
           :name "Berkeley - zareei@berkeley.edu"
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :to "zareei@berkeley.edu")))
           :vars '(
                   (mu4e-sent-folder . "/bmail/[Gmail].Sent Mail")
                   (mu4e-drafts-folder . "/bmail/[Gmail].Drafts")
                   (mu4e-trash-folder . "/bmail/[Gmail].Trash")
                   (mu4e-refile-folder . "/bmail/[Gmail].Archive")
                   (user-mail-address . "zareei@berkeley.edu")
                   ))))
(setq mu4e-context-policy 'pick-first)

(setq mu4e-compose-format-flowed t)
;; give me ISO(ish) format date-time stamps in the header list
(setq mu4e-headers-date-format "%Y-%m-%d %H:%M")
;; show full addresses in view message (instead of just names)
;; toggle per name with M-RET
(setq mu4e-view-show-addresses 't)
;; the headers to show in the headers list -- a pair of a field
;; and its width, with `nil' meaning 'unlimited'
;; (better only use that for the last field.
;; These are the defaults:
(setq mu4e-headers-fields
    '( (:date          .  25)    ;; alternatively, use :human-date
       (:flags         .   6)
       (:from          .  22)
       (:subject       .  nil))) ;; alternatively, use :thread-subject
;; Rendering org mode in mu4e
;; configure orgmode support in mu4e
(require 'org-mu4e)
;; This interesting function turns you draft into org-mode when the cursor 
;; crosses the title line; and turn the mail back to 
;; mu4e-compose-mode when cursor goes back. 
(add-hook 'mu4e-compose-mode-hook 'org~mu4e-mime-switch-headers-or-body)
;; This enables Emacs to store link to message 
;; if in header view, not to header query. 
(setq org-mu4e-link-query-in-headers-mode nil)
;;When mail is sent, org-mu4e can automatically convert org body to HTML: 
(setq org-mu4e-convert-to-html t)
;; Setting up capture for org-mode
(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/Dropbox/org/inbox.org" "Tasks")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")))

(with-eval-after-load 'mu4e-alert
  ;; Enable Desktop notifications
  (mu4e-alert-set-default-style 'notifications) 
  (mu4e-alert-set-default-style 'libnotify))  ; Alternative for linux
;; (setq mu4e-alert-interesting-mail-query
;;      (concat
;;       "maildir:/gmail/INBOX OR maildir:/bmail/INBOX" " flag:unread AND NOT flag:trashed"))

(define-key mu4e-headers-mode-map (kbd "C-c p") 'org-store-link)
(define-key mu4e-view-mode-map    (kbd "C-c p") 'org-store-link)

(require 'forecast)
 (setq forecast-api-key "f4482c0687a9ce39f7a22f34a83056f6")

(require 'google-maps)

(global-set-key (kbd "C-x g") 'google-this-mode-submap)

(progn
    (elfeed-org)
    (setq rmh-elfeed-org-files (list "~/Dropbox/org/elfeed.org")))
;;(setq rmh-elfeed-org-files (list "~/Dropbox/org/elfeed.org"))

(defhydra hydra-elfeed-filter (:color blue :hint nil)
   "
Filter   Category^     ^ ^      ^Summary     (_q_uit)
-----------------------------------------
        _f_luids      _n_ews    _a_ll
        _p_hysics     _*_star   _t_oday
        _e_con blogs  _m_ark    _r_efresh
      "
   ("f" (elfeed-search-set-filter "@2-months-ago +fluids"))
   ("p" (elfeed-search-set-filter "@2-months-ago +physics"))
   ("e" (elfeed-search-set-filter "@2-months-ago +econs"))
   ("n" (elfeed-search-set-filter "@2-months-ago +news"))
   ("*" (elfeed-search-set-filter "@2-months-ago +star"))
   ("m" elfeed-toggle-star )
   ("a" (elfeed-search-set-filter "@2-months-ago"))
   ("t" (elfeed-search-set-filter "@1-day-ago"))
   ("r" elfeed-show-refresh)
   ("q" elfeed-kill-buffer)
)

 (global-set-key (kbd "C-[ C-[") 'hydra-org-clock/body)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")
