(ess-toggle-underscore nil)
(define-key ess-mode-map (kbd ";") 'ess-insert-assign)
(define-key inferior-ess-mode-map (kbd ";") 'ess-insert-assign)
;; (setq ess-insert-assign-key ";")
;; (ess-toggle-S-assign nil)
;; (ess-toggle-S-assign nil)

;; magrittr pipe
(defun then_R_operator ()
  "R - %>% operator or 'then' pipe operator"
  (interactive)
  (just-one-space 1)
  (insert "%>%")
  (just-one-space 1))
(define-key ess-mode-map (kbd "C-;") 'then_R_operator)
(define-key inferior-ess-mode-map (kbd "C-;") 'then_R_operator)

;; This should search history (Ctrl-up) with letters start with what is written on console
(add-hook 'inferior-ess-mode-hook
'(lambda nil
   (define-key inferior-ess-mode-map [\C-up] 'comint-previous-matching-input-from-input)
   (define-key inferior-ess-mode-map [\C-down] 'comint-next-matching-input-from-input)
   (define-key inferior-ess-mode-map [\C-x \t] 'comint-dynamic-complete-filename)
   )
)


;;;; uncomment to use auto-complete package for auto completion feature start;;
;; (ac-config-default)

;; (setq ess-use-auto-complete t)
;; (define-key ac-completing-map (kbd "M-h") 'ac-quick-help)
;; (setq
;;       ac-auto-show-menu 1
;;       ;; ac-candidate-limit nil
;;       ac-delay 1.1
;;       ;; ac-disable-faces (quote (font-lock-comment-face font-lock-doc-face))
;;       ;; ac-ignore-case 'smart
;;       ;; ac-menu-height 10
;;       ;; ac-quick-help-delay 1.5
;;       ;; ac-quick-help-prefer-pos-tip t
;;       ;; ac-use-quick-help nil
;; )
;;;; uncomment to use auto-complete package for auto completion feature stop;;

;; below require (add-hook 'after-init-hook 'global-company-mode) to run earlier
;; probably in another .el file
;; below bring auto complete in ess and inferior ess mode by typing C-'
(add-hook 'inferior-ess-mode-hook
'(lambda nil
   (define-key ess-mode-map (kbd "C-'") 'company-complete)
   (define-key inferior-ess-mode-map (kbd "C-'") 'company-complete)
   )
)

(add-hook 'ess-mode-hook (lambda() (ess-set-style 'RStudio)))

;; https://stackoverflow.com/questions/2770523/how-can-i-background-the-r-process-in-ess-emacs
;; (setq ess-eval-visibly 'nowait) ;to prevent emacs hang on running large code

;; This will prevent Emacs to freeze when running R code. But the code will not be visible if multiline is sent to console.
(setq ess-eval-visibly nil)
