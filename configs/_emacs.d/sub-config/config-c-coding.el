(defconst my-c-style
          '((c-tab-always-indent        . t)
            (c-comment-only-line-offset . 4)
            (c-hanging-braces-alist     . ((substatement-open after)
                                           (brace-list-open)))
            (c-hanging-colons-alist     . ((member-init-intro before)
                                           (inher-intro)
                                           (case-label after)
                                           (label after)
                                           (access-label after)))
            (c-cleanup-list             . (scope-operator
                                            empty-defun-braces
                                            defun-close-semi))
            (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                           (substatement-open . 0)
                                           (case-label        . 4)
                                           (block-open        . 0)
                                           (knr-argdecl-intro . -)))
            (c-echo-syntactic-information-p . t)
            )
          "My C Programming Style")

(setq c-offsets-alist '((member-init-intro . ++)))
(setq c-basic-offset 8)

;;;;; c/c++ header include guard
(defun insert-include-guard ()
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

;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  (c-add-style "PERSONAL" my-c-style t)
  (c-toggle-auto-hungry-state 1)
  (define-key c-mode-base-map "/C-m" 'c-context-line-break)
  )

(c-set-offset (quote cpp-macro) 0 nil)
(add-hook 'c-mode-hook '(lambda() (c-set-style "linux")))
(add-hook 'c-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
; (add-hook 'c-mode-hook (lambda () (setq comment-column 48) ))

(require 'whitespace)
(setq whitespace-style '(face trailing space-before-tab))
(add-hook 'c-mode-hook 'whitespace-mode)

(add-hook 'c-mode-hook
          '(lambda ()
             (c-toggle-auto-state)))

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

(setq tags-file-name "TAGS")

(setq tab-width 8
       indent-tabs-mode t
       c-basic-offset 8)

(global-cwarn-mode 1)
