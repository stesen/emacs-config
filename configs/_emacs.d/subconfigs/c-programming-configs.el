(provide 'c-programming-configs)

;;;;;;;;;;;;;;;;;;;; cflow ;;;;;;;;;;;;;;;;;;;;
(require 'cflow-mode)
(defvar cmd nil nil)
(defvar cflow-buf nil nil)
(defvar cflow-buf-name nil nil)
 
(defun cflow-function (function-name)
  "Get call graph of inputed function. "
  ;(interactive "sFunction name:\n")
  (interactive (list (car (senator-jump-interactive "Function name: "
                                                    nil nil nil))))
  (setq cmd (format "cflow  -b --main=%s %s" function-name buffer-file-name))
  (setq cflow-buf-name (format "**cflow-%s:%s**"
                               (file-name-nondirectory buffer-file-name)
                               function-name))
  (setq cflow-buf (get-buffer-create cflow-buf-name))
  (set-buffer cflow-buf)
  (setq buffer-read-only nil)
  (erase-buffer)
  (insert (shell-command-to-string cmd))
  (pop-to-buffer cflow-buf)
  (goto-char (point-min))
  (cflow-mode))

(setq ecb-show-tags
 (quote (
	 (default
	  (include expanded nil)
	  (parent expanded nil)
	  (type expanded nil)
	  (variable expanded nil)
	  (function expanded nil)
	  (label expanded nil)
	  (t expanded nil))
	 (c++-mode
	  (include collapsed nil)
	  (parent collapsed nil)
	  (type flattened nil)
	  (variable collapsed nil)
	  (function flattened nil)
	  (function collapsed nil)
	  (label hidden nil)
	  (t collapsed nil))
	 (c-mode
	  (include collapsed nil)
	  (parent collapsed nil)
	  (type flattened nil)
	  (variable collapsed nil)
	  (function flattened nil)
	  (function collapsed nil)
	  (label hidden nil)
	  (t collapsed nil))
	)))

;;;;;;;;;;;;;;;;;;;; gatgs ;;;;;;;;;;;;;;;;;;;;
(require 'gtags)
(gtags-mode)
(require 'xgtags)
(xgtags-mode 1)

;;;;;;;;;;;;;;;;;;;; xcscope ;;;;;;;;;;;;;;;;;;;;
(require 'xcscope) ;;加载xcscope
(global-set-key (kbd "<f1> s") 'cscope-find-this-symbol)
(global-set-key (kbd "<f1> d") 'cscope-find-global-definition)
(global-set-key (kbd "<f1> c") 'cscope-find-functions-calling-this-function)
(global-set-key (kbd "<f1> f") 'cscope-find-this-file)
(global-set-key (kbd "<f1> u") 'cscope-pop-mark)
(global-set-key (kbd "<f1> n") 'cscope-next-symbol)
(global-set-key (kbd "<f1> p") 'cscope-prev-symbol)
(global-set-key (kbd "<f1> a") 'cscope-next-file)
(global-set-key (kbd "<f1> b") 'cscope-prev-file)
(global-set-key (kbd "<f1> t") 'cscope-find-this-text-string)
(global-set-key (kbd "<f1> g") 'cscope-find-global-definition-no-prompting)
(global-set-key (kbd "<f1> e") 'cscope-find-egrep-pattern)
(global-set-key (kbd "<f1> i") 'cscope-find-files-including-file)

;;;;;;;;;;;;;;;;;;;; coding style ;;;;;;;;;;;;;;;;;;;;
(c-add-style "kernel-coding"
	     '( "linux"
		(c-basic-offset . 8)
		(c-comment-only-line-offset . 0)
		(indent-tabs-mode . nil)
		;;(tab-stop-list ())
		(tab-width . 8)
		(standard-indent 8)
		(c-hanging-braces-alist
		  (brace-list-open)
		  (brace-entry-open)
		  (substatement-open after)
		  (block-close . c-snug-do-while)
		  (arglist-cont-nonempty))
		(c-cleanup-list brace-else-brace)
		(c-set-offset 'case-label ++)
		(statement-case-intro . ++)
		(c-offsets-alist
		  (statement-block-intro . +)
		  (knr-argdecl-intro . 0)
		  (substatement-open . 0)
		  (substatement-label . 0)
		  (label . 0)
		  (case-label . +8)
		  (statement-cont . +))
		))
(add-hook 'c-mode-hook '(lambda() (c-set-style "kernel-coding")))


(defun my-cpp-highlight ()
  (setq cpp-known-face '(background-color . "dim gray"))
  (setq cpp-unknown-face 'default)
  (setq cpp-face-type 'dark)
  (setq cpp-known-writable 't)
  (setq cpp-unknown-writable 't)
  (setq cpp-edit-list
	'((#("0" 0 1
	     (c-in-sws t fontified t))
	   (background-color . "dim gray")
	   nil both nil)
	  (#("1" 0 1
	     (c-in-sws t fontified t))
	   nil
	   (background-color . "dim gray")
	   both nil)))
  (cpp-highlight-buffer t))

;; Add hook
(defun my-c-mode-common-hook ()
  (my-cpp-highlight)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; C-l 手动刷新
(defun my-c-mode-recenter ()
  "Recenter buffer and refresh highlighting."
  (interactive)
  (recenter)
  (cpp-highlight-buffer t))

(defun my-c-initialization-hook ()
  (define-key c-mode-base-map "\C-l" 'my-c-mode-recenter))

(add-hook 'c-initialization-hook 'my-c-initialization-hook)

(add-hook 'c-mode-common-hook '(lambda () 
	(progn 
		(setq-default hide-ifdef-mode t))))

(add-hook 'c-mode-hook 'my-c-mode-hook)
(defun my-c-mode-hook ()
   (interactive)
     (make-local-variable 'pre-command-hook)
       (add-hook 'pre-command-hook 'wcy-cancel-auto-new-line))

(defvar wcy-cancel-auto-new-line-command-list
   '(next-line previous-line)
     "a list of command which will trigger the cancel.")

(defun wcy-cancel-auto-new-line ()
  (interactive)
  (save-excursion
    (if (and (eq last-command 'c-electric-semi&comma)
	     (memq this-command wcy-cancel-auto-new-line-command-list))
      (progn
	(if (and (boundp c-auto-newline) c-auto-newline)
	  (progn
	    (delete-blank-lines)
	    (delete-blank-lines)))))))

     (defun my-c-mode-font-lock-if0 (limit)  
       (save-restriction  
         (widen)  
         (save-excursion  
           (goto-char (point-min))  
           (let ((depth 0) str start start-depth)  
             (while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)  
               (setq str (match-string 1))  
               (if (string= str "if")  
                   (progn  
                     (setq depth (1+ depth))  
                     (when (and (null start) (looking-at "\\s-+0"))  
                       (setq start (match-end 0)  
                             start-depth depth)))  
                 (when (and start (= depth start-depth))  
                   (c-put-font-lock-face start (match-beginning 0) 'font-lock-comment-face)  
                   (setq start nil))  
                 (when (string= str "endif")  
                   (setq depth (1- depth)))))  
             (when (and start (> depth 0))  
               (c-put-font-lock-face start (point) 'font-lock-comment-face)))))  
       nil)  
  
     (defun my-c-mode-common-hook ()  
       (font-lock-add-keywords  
        nil  
        '((my-c-mode-font-lock-if0 (0 font-lock-comment-face prepend))) 'add-to-end))  
  
     (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(add-hook 'c-mode-common-hook
           (lambda ()
	                (define-key c-mode-base-map (kbd "M-.") 'my-hif-toggle-block)))

;;; for hideif
(defun my-hif-toggle-block ()
  "toggle hide/show-ifdef-block --lgfang"
  (interactive)
  (require 'hideif)
  (let* ((top-bottom (hif-find-ifdef-block))
	 (top (car top-bottom)))
    (goto-char top)
    (hif-end-of-line)
    (setq top (point))
    (if (hif-overlay-at top)
      (show-ifdef-block)
      (hide-ifdef-block))))

(defun hif-overlay-at (position)
  "An imitation of the one in hide-show --lgfang"
  (let ((overlays (overlays-at position))
	ov found)
    (while (and (not found) (setq ov (car overlays)))
	   (setq found (eq (overlay-get ov 'invisible) 'hide-ifdef)
		 overlays (cdr overlays)))
    found))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(add-hook 'c-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'perl-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))

(font-lock-add-keywords 'c-mode
			'(("\\<\\(FIXME\\):" 1 font-lock-warning-face prepend)
			  ("\\<\\(and\\|or\\|not\\)\\>" . font-lock-keyword-face)))

;;;;; c/c++ header include guard
(defun c-head-file-insert-ifndef ()
  "insert include guard for c and c++ header file."
  (interactive)
  (setq file-macro
	(concat (replace-regexp-in-string "\\." "_" (upcase (file-name-nondirectory buffer-file-name))) "_"))
  (setq guard-begin (concat "#ifndef " file-macro "\n"
			    "#define " file-macro "\n\n"))
  (setq guard-end
	(concat "\n\n#endif \/\/ " file-macro "\n"))
  (setq position (point))
  (goto-char (point-min))
  (insert guard-begin)
  (goto-char (point-max))
  (insert guard-end)
  (goto-char (+ position (length guard-begin))))

(defun ct (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command "tag_cscope.sh"))
