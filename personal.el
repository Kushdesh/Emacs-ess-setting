;;;;;;;;;; These are used as per recomendation in "https://realpython.com/blog/python/emacs-the-best-python-editor/" ;;;;;;;;;;;start

;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------


;; Below gave error. Also taken from https://anhqle.github.io/emacs-there-and-back-again/
;; ; Make OS shell path available in emacs exec path
;; (use-package exec-path-from-shell
;;   :ensure t
;;   :config (exec-path-from-shell-copy-env "PATH"))


;; BASIC CUSTOMIZATION
;; --------------------------------------
(setq inhibit-startup-message t) ;; hide the startup message
(use-package better-defaults
  :ensure t)
;; (ido-mode 1)	     ;already default of better default package
;; (global-linum-mode t) ;; enable line numbers globally


;; see https://github.com/cpaulik/emacs-material-theme
(use-package material-theme
  :ensure t
  :config
  (load-theme 'material t) ;somehow adding this line speed up emacs startup.
  ;; (fringe-mode 7)				;size of fringe
  (set-face-attribute 'fringe nil :background "#AFAFAF" :foreground "#000000")
  ;; (set-background-color "#35353F")  ;This changes only initial color.
  (add-to-list 'default-frame-alist '(background-color . "#3F3F3F")) ;this changes new frame using C-x 5 2
  (add-to-list 'initial-frame-alist '(background-color . "#3F3F3F")) ;this changes initial (startup) frame using C-x 5 2
  (add-to-list 'default-frame-alist '(foreground-color . "#E5E5E5"))
  (add-to-list 'initial-frame-alist '(foreground-color . "#E5E5E5"))
  ;; (set-frame-font "Consolas 10" nil t)
  ;; (set-frame-font "-outline-Consolas-normal-normal-normal-mono-21-*-*-*-c-*-iso8859-1")
  ;; (set-frame-font "DejaVu Sans Mono 9" nil t)
  (set-frame-font "Inconsolata-12" nil t)
  ;; (set-face-attribute 'default nil :height 110) ; to change font size
)
;; (load-theme 'sanityinc-solarized-dark t) ;; another useful dark theme

(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(left + -10))
(add-to-list 'default-frame-alist '(width . 159))

(add-to-list 'default-frame-alist '(top + -11))
(add-to-list 'default-frame-alist '(height . 32))

;; save/restore opened files and windows config
;; see http://ergoemacs.org/emacs/emacs_save_restore_opened_files.html
;; (desktop-save-mode 1) ; 0 for of

(use-package smex                       ;smex is smart M-x
  :ensure t
  :bind (("M-x" . smex))
  :config
  (smex-initialize)
  ;; space is converted to - in smex.
  (defadvice smex (around space-inserts-hyphen activate compile)
    (let ((ido-cannot-complete-command 
           `(lambda ()
              (interactive)
              (if (string= " " (this-command-keys))
                  (insert ?-)
                (funcall ,ido-cannot-complete-command)))))
      ad-do-it))
  )

;; (use-package undo-tree
;;   :ensure t
;;   :defer 2
;;   :config
;;   (global-undo-tree-mode 1)
;;   (global-set-key (kbd "C-z") 'undo)
;;   (defalias 'redo 'undo-tree-redo)
;;   (global-set-key (kbd "C-S-z") 'redo)
;;   )

;; (defvar myPackages
;;   '(ein  ;;ein is commented as ipyton 6 is as of now is not compatible with emacs
;;     flycheck))


;; (mapc #'(lambda (package)
;;     (unless (package-installed-p package)
;;       (package-install package)))
;;       myPackages)




;; keep backup files neatly out of the way in .~/
(setq backup-directory-alist '(("." . ".~")))

;; ;; start emacs with two windows side by side
;; (split-window-right)

;; if emacs makes new window  then it is on right side(e.g. when sending R code before starting R process)
(setq split-height-threshold nil)
(setq split-width-threshold 85)

;; set buffer width to 80 using "C-x w"
;; see https://nullprogram.com/blog/2010/10/06/
(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t))

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 80))

(global-set-key (kbd "C-x w") 'set-80-columns)

;; Use C-c Arrow to undo redo window configuration 
(use-package winner
  :ensure t
  :defer 2
  :init (winner-mode 1))

;; (use-package smart-comment
;;  :bind ("M-;" . smart-comment))

;; column no of cursor alongwith line no become visible
(setq column-number-mode t)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; ?? I guess i have to use something else instead of word return to disable enter key in first line. commenting for now.
;; (eval-after-load 'company
;; '(progn
;;    (define-key company-active-map [return] nil) 
;;    (define-key company-active-map [tab] 'company-complete-common) ;look like this line is not needed but I am not sure
;;    (define-key company-active-map (kbd "TAB") 'company-complete-common) ; by default tab work for this so commented the line
;;    (define-key company-active-map (kbd "'") 'company-complete-selection)
;;    )
;; )

;; scrolling one line at time
;; (global-set-key (quote [M-down]) (quote scroll-up-line))
(global-set-key (quote [M-down]) (kbd "C-u 1 C-v"))
(global-set-key (quote [M-up]) (quote scroll-down-line))


;; replace buffer list to ibuffer on "C-x C-b"
;; Note C-x b runs the command ido-switch-buffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; e.g. can use C-x r j e to jump to init file
(set-register ?e (cons 'file "~/.emacs.d/personal.el"))
(set-register ?o (cons 'file "C:/Users/Kushdesh.Prasad/Documents/Org Files/"))
(set-register ?t (cons 'file "c:/Users/Kushdesh.Prasad/Documents/Org Files/todo.org"))
(set-register ?w (cons 'file "C:/Users/Kushdesh.Prasad/Documents/Work/2019"))
