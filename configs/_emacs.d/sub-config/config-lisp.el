(defun lisp-indent-or-complete (&optional arg)
 (interactive "p")
 (if (or (looking-back "^\\s-*") (bolp))
  (call-interactively 'lisp-indent-line)
  (call-interactively 'slime-indent-and-complete-symbol)))
(eval-after-load "lisp-mode"
 '(progn
	 (define-key lisp-mode-map (kbd "TAB") 'lisp-indent-or-complete)))

;; Lisp (SLIME) interaction
(setq inferior-lisp-program "clisp")
(add-to-list 'load-path "~/.emacs.d/plugins/slime")
;(require 'slime)
(require 'slime-autoloads)
(slime-setup)
