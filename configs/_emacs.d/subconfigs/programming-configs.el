(provide 'programming-configs)

(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")

(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")

(require 'highlight-symbol)
(global-set-key (kbd "M-<f8>") 'highlight-symbol-at-point)
(global-set-key (kbd "M-<f9>") 'highlight-symbol-prev)
(global-set-key (kbd "M-<f10>") 'highlight-symbol-next)
(global-set-key (kbd "M-<f11>") 'highlight-symbol-prev-in-defun)
(global-set-key (kbd "M-<f12>") 'highlight-symbol-next-in-defun)
(global-set-key (kbd "<f5> <f5>") 'revert-buffer-with-coding-system)

;; (add-to-list 'load-path "~/.emacs.d/plugins/slime")
;; (setq inferior-lisp-program "/usr/bin/sbcl")
;; (require 'slime)
;; (slime-setup '(slime-fancy))

;; (defun lisp-indent-or-complete (&optional arg)
;;   (interactive "p")
;;   (if (or (looking-back "^\\s-*") (bolp))
;;     (call-interactively 'lisp-indent-line)
;;     (call-interactively 'slime-indent-and-complete-symbol)))
;; (eval-after-load "lisp-mode"
;; 		 '(progn
;; 		    (define-key lisp-mode-map (kbd "TAB") 'lisp-indent-or-complete)))

;; (require 'which-func)
;; (add-to-list 'which-func-modes 'org-mode)
;; (which-function-mode 1)

(add-hook 'find-file-hook 'set-trailing-whitespace)
(defun set-trailing-whitespace ()
  (progn (if (stringp mode-name)
	   (if (string= mode-name "Text")
	     (progn (make-variable-buffer-local 'show-trailing-whitespace)
		    (setq show-trailing-whitespace t))))))

(require 'whitespace)
;(setq whitespace-style '(face lines-tail trailing space-before-tab))
(setq whitespace-style '(face trailing space-before-tab))
(add-hook 'c-mode-hook 'whitespace-mode)

(defun format-my-code ()
  "Formatting code in my coding style"
  (interactive)
  (goto-char 1)
  (while (re-search-forward "" nil t)
    (replace-match "" t nil))

  (set-buffer-file-coding-system 'utf-8)
  (whitespace-cleanup)
  (save-buffer)

  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max))
  (align-current)

  (save-buffer)
  (message "Code Formatting Done!"))
