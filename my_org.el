(use-package org
  :ensure t
  :mode (("\\.org$" . org-mode))
  :config
  ;; The following lines are always needed.  Choose your own keys.
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)
  ;; (global-set-key "\C-cc" 'org-capture)
  ;; (global-set-key "\C-cb" 'org-switchb)
  
  (setq org-support-shift-select t)

  (setq org-todo-keyword-faces
        '(("CANCELLED" . (:foreground "yellow" :weight bold))))

  ;; In org mode C-up and C-down (instead of M-up and M-down) to move task up or down  
  (add-hook 'org-mode-hook
            '(lambda ()
               (define-key org-mode-map (quote [M-up]) nil) ;remove old binding
	       (define-key org-mode-map (quote [C-up]) 'org-metaup) ;add new binding
	       (define-key org-mode-map (quote [M-down]) nil)
	       (define-key org-mode-map (quote [C-down]) 'org-metadown)))
  )
