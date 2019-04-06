(use-package web-mode
  :ensure t
  :mode ("\\.phtml\\'" "\\.tpl\\.php\\'" "\\.[agj]sp\\'" "\\.as[cp]x\\'" "\\.erb\\'" "\\.mustache\\'" "\\.djhtml\\'" "\\.html?\\'")
  :config
  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-enable-current-column-highlight t)
    (set-face-attribute 'web-mode-html-tag-face nil :foreground "DarkSlateGray2")
    (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "Orange")
    )
  (add-hook 'web-mode-hook  'my-web-mode-hook)

  ;; Setting background of web-mode a little darker. This let me see current column highlight (the color of highlight I am unable to change it in my_web.el. Although I can change it by modifying [[file:~/.emacs.d/elpa/web-mode-20190131.1348/web-mode.el::(defface web-mode-current-column-highlight-face][Link]])
  ;; http://ergoemacs.org/emacs/elisp_define_face.html
  (defface my-special-face
    '((t :background "#494949"
         ))
    "Face for web-mode."
    :group 'for_mode_with_current_column)
  ;; https://stackoverflow.com/questions/3094638/emacs-custom-background-color-by-mode
  (add-hook 'web-mode-hook
            (lambda ()
              (face-remap-add-relative 'default 'my-special-face)))
;; Earlier(in previous laptop) xah-syntax-color-hex worked. Now in this computer the behaviour is working in css without using this code but htis code is not working. Required to check if this is due to emacs updation or there is some file which is making this behaviour. Commenting out below
;; ;; to add color in the text of RGB color in html/css files
;; (defun xah-syntax-color-hex ()
;;   "Syntax color text of the form #ff1100 and #abc in current buffer.
;; URL 'http://ergoemacs.org/emacs/emacs_CSS_colors.html'
;; Version 2017-03-12"
;;   (interactive)
;;   (font-lock-add-keywords
;;    nil
;;    '(("#[[:xdigit:]]\\{3\\}"
;;       (0 (put-text-property
;;           (match-beginning 0)
;;           (match-end 0)
;;           'face (list :background
;;                       (let* (
;;                              (ms (match-string-no-properties 0))
;;                              (r (substring ms 1 2))
;;                              (g (substring ms 2 3))
;;                              (b (substring ms 3 4)))
;;                         (concat "#" r r g g b b))))))
;;      ("#[[:xdigit:]]\\{6\\}"
;;       (0 (put-text-property
;;           (match-beginning 0)
;;           (match-end 0)
;;           'face (list :background (match-string-no-properties 0)))))))
;;   (font-lock-flush))

;; (add-hook 'css-mode-hook 'xah-syntax-color-hex)
;; (add-hook 'html-mode-hook 'xah-syntax-color-hex)
;; (add-hook 'web-mode-hook 'xah-syntax-color-hex)
  )

;; ;; for using javascript along with html. Configuration is due
;; (require 'multi-web-mode)
;; (setq mweb-default-major-mode 'html-mode)
;; (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;                   (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;;                   (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;; (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;; (multi-web-global-mode 1)
