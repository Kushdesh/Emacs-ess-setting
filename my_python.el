(use-package elpy
  :ensure t
  :defer t
  :init (with-eval-after-load 'python (elpy-enable)) ;see https://emacs.stackexchange.com/questions/10065/how-can-i-defer-loading-elpy-using-use-package
  :config
  ;; (pyvenv-activate "c:/Users/Kushdesh.Prasad/AppData/Local/Continuum/Miniconda3/envs/DS")
  ;; (pyvenv-activate "c:/Users/Kushdesh.Prasad/AppData/Local/Continuum/Miniconda3")
  (pyvenv-activate "c:/Users/Kushdesh.Prasad/AppData/Local/Continuum/Miniconda3/envs/tools2019")
  ;;(pyvenv-activate "c:/Users/Kushdesh.Prasad/AppData/Local/Continuum/Miniconda3/envs/DjangoLearn")
  ;;(pyvenv-activate "c:/Users/Kushdesh.Prasad/AppData/Local/Continuum/Miniconda3/envs/aind")

  ;; (elpy-enable) ;already called with init:
  (setq python-shell-interpreter "jupyter"
        python-shell-interpreter-args "console --simple-prompt"
        python-shell-prompt-detect-failure-warning nil)
  (add-to-list 'python-shell-completion-native-disabled-interpreters
               "jupyter")
  ;;?? above setting i.e. jupyter one is still recommended. but below i.e. ipyton without simple-promt also works.
  ;; see https://elpy.readthedocs.io/en/latest/ide.html#interpreter-setup. Also ein may work now with ipython
  ;; (setq python-shell-interpreter "python"
  ;;       python-shell-interpreter-args "-i")
  ;; (setq python-shell-interpreter "ipython")
  ;; (setq python-shell-interpreter-args "-i --simple-prompt")

  ;; ?? use-package form inside use-package form. It is working now. Check if
  ;; this work on new computer (i.e. automatically installation of flycheck happens or not)
  (use-package flycheck
    :ensure t
    :config
    (when( require 'flycheck nil t)
      (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
      (add-hook 'elpy-mode-hook 'flycheck-mode)))

  ;;To Remove some elpy keybindings so that I can use my preferred keybindings
  ;;from: https://stackoverflow.com/questions/25154809/how-can-i-stop-elpy-from-overriding-some-of-my-keybindings
  (eval-after-load "elpy"
  '(cl-dolist (key '("M-<up>" "M-<down>" "C-c C-c" "C-c C-f"))
     (define-key elpy-mode-map (kbd key) nil)))

  ;; trying to make elpy code evalutation shortcut similar to ESS
  ;; from: https://emacs.stackexchange.com/questions/37551/matching-key-bindings-between-modes
  (defun my-elpy-mode-hook-fun1 ()
    "Function to be installed in `elpy-mode-hook'."
    (local-set-key (kbd "C-<RET>") #'elpy-shell-send-statement-and-step)
    (local-set-key (kbd "C-c C-c") #'elpy-shell-send-group-and-step)
    (local-set-key (kbd "C-c C-f") #'elpy-shell-send-defun-and-step)
    (local-set-key (kbd "C-c C-l") #'elpy-shell-send-buffer))
  
  (add-hook 'elpy-mode-hook #'my-elpy-mode-hook-fun1)

  ;; (defun my-elpy-mode-hook-fun ()
  ;;   "Function to be installed in `elpy-mode-hook'."
  ;;   (local-set-key (kbd "C-x C-v") #'elpy-find-file))

  ;; (add-hook 'elpy-mode-hook #'my-elpy-mode-hook-fun)

  ;; to change auto indent
  (add-hook 'python-mode-hook
            (lambda ()
              (setq python-indent 2)))

  (add-hook 'inferior-python-mode-hook 'visual-line-mode)
  (defun mydef-RET ()
    "define RET behavior in python"
    (interactive)
    (setq current-line (what-line))
    (end-of-buffer)
    (if (string=  current-line (what-line))
        (comint-send-input)))
  (define-key inferior-python-mode-map (kbd "RET") 'mydef-RET)
  (setq python-shell-completion-native-enable nil)
  
  (add-hook 'elpy-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '((company-dabbrev-code company-yasnippet elpy-company-backend)))))
  )

;; ??something like package curl (don't know if it is emacs package or python package) and other package is missing to make ein work.
(use-package ein
  :ensure t
  :after elpy) ;see https://github.com/jwiegley/use-package/issues/453


;; ;; making DS virtual environment as default.
;; (require 'pyvenv) ;This is not required if elpy is already loaded
;; ;; (pyvenv-activate "c:/Users/Kushdesh.Prasad/AppData/Local/Continuum/Miniconda3")
;; ;; (pyvenv-activate "c:/Users/Kushdesh.Prasad/AppData/Local/Continuum/Miniconda3/envs/tools2018")
;; (pyvenv-activate "c:/Users/Kushdesh.Prasad/AppData/Local/Continuum/Miniconda3/envs/DS")
;; ;; (pyvenv-activate "c:/Users/Kushdesh.Prasad/AppData/Local/Continuum/Miniconda3/envs/DjangoLearn/")
;; ;; (pyvenv-activate "c:/Users/Kushdesh.Prasad/AppData/Local/Continuum/Miniconda3/envs/aind")


;; (elpy-enable)
;; ;; (elpy-use-ipython)  ;This is depricated
;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "jupyter")

;;?? above setting i.e. jupyter one was recommende. earier  but trying below i.e. ipyton without simple-promt. Earlier this was not wo. also ein is now added.
;; (setq python-shell-interpreter "ipython")
;; (setq python-shell-interpreter-args "-i --simple-prompt")

;; (when( require 'flycheck nil t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

;; ;;To Remove some elpy keybindings so that I can use my preferred keybindings
;; ;;from: https://stackoverflow.com/questions/25154809/how-can-i-stop-elpy-from-overriding-some-of-my-keybindings
;; (eval-after-load "elpy"
;;   '(cl-dolist (key '("M-<up>" "M-<down>" "C-c C-c" "C-c C-f"))
;;      (define-key elpy-mode-map (kbd key) nil)))


;; ;; trying to make elpy code evalutation shortcut similar to ESS
;; ;; from: https://emacs.stackexchange.com/questions/37551/matching-key-bindings-between-modes
;; (defun my-elpy-mode-hook-fun1 ()
;;  "Function to be installed in `elpy-mode-hook'."
;;  (local-set-key (kbd "C-<RET>") #'elpy-shell-send-statement-and-step)
;;  (local-set-key (kbd "C-c C-c") #'elpy-shell-send-group-and-step)
;;  (local-set-key (kbd "C-c C-f") #'elpy-shell-send-defun-and-step)
;;  (local-set-key (kbd "C-c C-l") #'elpy-shell-send-buffer))

;; (add-hook 'elpy-mode-hook #'my-elpy-mode-hook-fun1)


;; ;; (defun my-elpy-mode-hook-fun ()
;; ;;   "Function to be installed in `elpy-mode-hook'."
;; ;;   (local-set-key (kbd "C-x C-v") #'elpy-find-file))

;; ;; (add-hook 'elpy-mode-hook #'my-elpy-mode-hook-fun)

;; ;; to change auto indent
;; (add-hook 'python-mode-hook
;;       (lambda ()
;;         (setq python-indent 2)))

;; (add-hook 'inferior-python-mode-hook 'visual-line-mode)

;; (defun mydef-RET ()
;;   "define RET behavior in python"
;;   (interactive)
;;   (setq current-line (what-line))
;;   (end-of-buffer)
;;   (if (string=  current-line (what-line))
;;       (comint-send-input)))
;; (define-key inferior-python-mode-map (kbd "RET") 'mydef-RET)
;; (setq python-shell-completion-native-enable nil)

;; (add-hook 'elpy-mode-hook
;; (lambda ()
;; (set (make-local-variable 'company-backends)
;; '((company-dabbrev-code company-yasnippet elpy-company-backend)))))
