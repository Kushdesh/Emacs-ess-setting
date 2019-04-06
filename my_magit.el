;; (global-set-key (kbd "C-x g") 'magit-status)

;; (add-hook 'git-commit-setup-hook 'turn-off-auto-fill
;;           ;; append to end of git-commit-setup-hook to ensure our hook trumps others.
;;           t)


(use-package magit
  :ensure t
  ;; :commands magit-status magit-blame
  ;; :init
  ;; (defadvice magit-status (around magit-fullscreen activate)
  ;;   (window-configuration-to-register :magit-fullscreen)
  ;;   ad-do-it
  ;;   (delete-other-windows))
  ;; :config
  ;; (setq magit-branch-arguments nil
  ;;       ;; use ido to look for branches
  ;;       magit-completing-read-function 'magit-ido-completing-read
  ;;       ;; don't put "origin-" in front of new branch names by default
  ;;       magit-default-tracking-name-function 'magit-default-tracking-name-branch-only
  ;;       magit-push-always-verify nil
  ;;       ;; Get rid of the previous advice to go into fullscreen
  ;;       magit-restore-window-configuration t)

  :bind ("C-x g" . magit-status)
  :config
  (add-hook 'git-commit-setup-hook 'turn-off-auto-fill
          ;; append to end of git-commit-setup-hook to ensure our hook trumps others.
          t)
  )
