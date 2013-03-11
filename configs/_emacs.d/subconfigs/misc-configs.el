(provide 'misc-configs)

(require 'linum+)
(require 'ido)
(require 'redo+)
(global-set-key (kbd "C-?") 'redo)
;(setq undo-no-redo)
;; (require 'igrep)

; auto complete
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")  
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete")  
(ac-config-default) 

;(require 'tabbar)
;(tabbar-mode)

;--------------------------------------------------
; (require 'session) ;;加载session
; (add-hook 'after-init-hook 'session-initialize) ;; 启动时初始化session
;-------------------------------------------------- 

(global-set-key "\C-x\C-b" 'electric-buffer-list)
(iswitchb-mode 1)
(setq iswitchb-buffer-ignore '("^\\*"))
(defun iswitchb-local-keys ()
  (mapc (lambda (K) 
	  (let* ((key (car K)) (fun (cdr K)))
	    (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
	'(("<right>" . iswitchb-next-match)
	  ("<left>"  . iswitchb-prev-match)
	  ("<up>"    . ignore             )
	  ("<down>"  . ignore             ))))
(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-local-keys)


(setq smart-compile-alist
      '( ("\\.rb$" . "spec %f")))

;;快捷键
(global-set-key [M-/] 'hippie-expand)
;;右Ctrl+\ 自动补全menu
(global-set-key "\C-\\" 'semantic-ia-complete-symbol-menu)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(global-cwarn-mode 1)

(require 'auto-complete)
(add-to-list 'load-path "/home/stesen/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/stesen/.emacs.d/ac-dict")
(ac-config-default)
(ac-set-trigger-key "TAB")

(require 'undo-tree)
(global-undo-tree-mode)

(setq rj-ring-length 1000)
(require 'recent-jump)
(global-set-key (kbd "M-,") 'recent-jump-backward)
(global-set-key (kbd "M-.") 'recent-jump-forward)
(recent-jump-mode 1)

(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
				      highlight-parentheses-mode
				      (lambda ()
					(highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(defun increase-font-size ()
  (interactive)
  (set-face-attribute 'default
		      nil
		      :height
		      (ceiling (* 1.10
				  (face-attribute 'default :height)))))
(defun decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
		      nil
		      :height
		      (floor (* 0.9
				(face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'increase-font-size)
(global-set-key (kbd "C--") 'decrease-font-size)

;(require 'cursor-change)
;(cursor-change-mode t)
(set-cursor-color "DarkCyan")

(require 'git)
(require 'git-blame)
(setq save-place-file "~/.emacs.tmpfile/saveplace")
(require 'saveplace)
(setq-default save-place t)

(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)


(defun confirm-exit-emacs ()
  "ask for confirmation before exiting emacs"
  (interactive)
  (if (yes-or-no-p "Are you sure you want to exit? ")
    (save-buffers-kill-emacs)))

(global-unset-key "\C-x\C-c")
(global-set-key "\C-x\C-c" 'confirm-exit-emacs)

(setq buffer-display-table (make-display-table))
(aset buffer-display-table ?\^M []) 

(add-to-list 'load-path "~/.emacs.d/plugins/company")
(autoload 'company-mode "company" nil t)

(autoload 'dmesg-mode "dmesg.el" nil t)
(add-to-list 'auto-mode-alist '("\\(?:dmesg\\.\\(?:log\\|txt\\)\\|kmsg\\.\\(?:log\\|txt\\)\\)\\'" . dmesg-mode))

;(require 'unicad)
(autoload 'systemtap-mode "systemtap-mode.el" nil t)
(add-to-list 'auto-mode-alist '("\\.stp\\'" . systemtap-mode))


(setq woman-default-indent 7            ;缩进格式
      woman-fill-frame t                ;填充满屏幕
      woman-use-own-frame nil           ;同一个frame
      woman-cache-level 3)              ;缓存级别, 最快


(global-set-key (kbd "C-x r C-@") 'rm-set-mark)
(global-set-key (kbd "C-x r C-x") 'rm-exchange-point-and-mark)
(global-set-key (kbd "C-x r C-w") 'rm-kill-region)
(global-set-key (kbd "C-x r M-w") 'rm-kill-ring-save)
(autoload 'rm-set-mark "rect-mark"
	  "Set mark for rectangle." t)
(autoload 'rm-exchange-point-and-mark "rect-mark"
	  "Exchange point and mark for rectangle." t)
(autoload 'rm-kill-region "rect-mark"
	  "Kill a rectangular region and save it in the kill ring." t)
(autoload 'rm-kill-ring-save "rect-mark"
	  "Copy a rectangular region to the kill ring." t)


(require 'ibuffer)
(global-set-key (kbd "<f2> <f2>") 'ibuffer)

(global-set-key (kbd "C-c C-g") 'goto-line)

(global-set-key (kbd "<f2> a") 'windmove-left)         ; move to left windnow
(global-set-key (kbd "<f2> d") 'windmove-right)        ; move to right window
(global-set-key (kbd "<f2> w") 'windmove-up)           ; move to upper window
(global-set-key (kbd "<f2> s") 'windmove-down)         ; move to downer window

(define-key global-map "\M-[1~" 'beginning-of-line)
(define-key global-map [select] 'end-of-line)

(require 'highlight-current-line)
(set-face-background 'highlight-current-line-face "#333333")
(highlight-current-line-on nil)

;(require 'zjl-hl)
;(zjl-hl-enable-global-all-modes)

(setq org-todo-keywords
	  '((sequence "[TODO]" "[STARTED]" "[DONE]" "[CANCELLED]" "[HELP]")))
(setq org-todo-keyword-faces
      '(("[TODO]" . (:background "red" :foreground "black"))
		("[STARTED]" . (:background "yellow" :foreground "black"))
		("[DONE]" . (:background "grey" :foreground "black"))
        ("[CANCELLED]" . (:background "black" :foreground "grey"))
        ("[HELP]" . (:background "green" :foreground "black"))))

;; (require 'smex)
;; (smex-initialize)
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; ;; This is your old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'autopair)
(autopair-global-mode)

(require 'icomplete+)
(icomplete-mode t)

(require 'bm)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
;(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>")   'bm-next)
(global-set-key (kbd "<M-f2>") 'bm-previous)

(setq mouse-wheel-scroll-amount `(2))
(setq mouse-wheel-progressive-speed nil)
(mouse-wheel-mode 1)

;; Mousewheel
(defun sd-mousewheel-scroll-up (event)
  "Scroll window under mouse up by five lines."
  (interactive "e")
  (let ((current-window (selected-window)))
    (unwind-protect
      (progn 
	(select-window (posn-window (event-start event)))
	(scroll-up 2))
      (select-window current-window))))

(defun sd-mousewheel-scroll-down (event)
  "Scroll window under mouse down by five lines."
  (interactive "e")
  (let ((current-window (selected-window)))
    (unwind-protect
      (progn 
	(select-window (posn-window (event-start event)))
	(scroll-down 2))
      (select-window current-window))))

(global-set-key (kbd "<mouse-5>") 'sd-mousewheel-scroll-up)
(global-set-key (kbd "<mouse-4>") 'sd-mousewheel-scroll-down)
;(global-set-key [(shift insert)] 'clipboard-yank)

;; (autoload 'folding-mode "folding" "Minor mode that simulates a folding editor" t) 
;; (load-library "folding")
;; (defun folding-mode-find-file-hook () 
;;   "One of the hooks called whenever a `find-file' is successful." 
;;   (and (assq 'folded-file (buffer-local-variables)) 
;;        folded-file 
;;        (folding-mode 1) 
;;        (kill-local-variable 'folded-file))) 
;; (setq fold-fold-on-startup t) 
;; (folding-mode-add-find-file-hook) 

;; (setq fold-keys-already-setup nil) 
;; (add-hook 'folding-mode-hook 
;; 	  (function (lambda() 
;; 		      (unless fold-keys-already-setup 
;; 			(setq fold-keys-already-setup t) 
;; 			(define-prefix-command 'ctl-f-folding-mode-prefix) 
;; 			(define-key 'ctl-f-folding-mode-prefix "f" 'fold-fold-region) 
;; 			(define-key 'ctl-f-folding-mode-prefix "e" 'fold-enter) 
;; 			(define-key 'ctl-f-folding-mode-prefix "x" 'fold-exit) 
;; 			(define-key 'ctl-f-folding-mode-prefix "b" 'fold-whole-buffer) 
;; 			(define-key 'ctl-f-folding-mode-prefix "o" 'fold-open-buffer) 
;; 			(define-key 'ctl-f-folding-mode-prefix "h" 'fold-hide) 
;; 			(define-key 'ctl-f-folding-mode-prefix "s" 'fold-show) 
;; 			(define-key 'ctl-f-folding-mode-prefix "t" 'fold-top-level) 
;; 			(define-key 'ctl-f-folding-mode-prefix "f" 'fold-fold-region) 
;; 			) 
;; 		      (local-set-key "C-f" 'ctl-f-folding-mode-prefix)))) 

(defadvice kill-ring-save (before slickcopy activate compile)
	   "When called interactively with no active region, copy a single line instead."
	   (interactive
	     (if mark-active (list (region-beginning) (region-end))
	       (list (line-beginning-position)
		     (line-beginning-position 2)))))

(defadvice kill-region (before slickcut activate compile)
	   "When called interactively with no active region, kill a single line instead."
	   (interactive
	     (if mark-active (list (region-beginning) (region-end))
	       (list (line-beginning-position)
		     (line-beginning-position 2)))))

(defadvice kill-line (before check-position activate)
	   (if (member major-mode
		       '(emacs-lisp-mode scheme-mode lisp-mode
					 c-mode c++-mode objc-mode js-mode
					 latex-mode plain-tex-mode))
	     (if (and (eolp) (not (bolp)))
	       (progn (forward-char 1)
		      (just-one-space 0)
		      (backward-char 1)))))

;; 让 shell mode 可以正常显示颜色
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(require 'ansi-color)
;; 这样直接把颜色滤掉
(add-hook 'eshell-preoutput-filter-functions
	  'ansi-color-filter-apply)

(require 'multi-term)
(setq multi-term-program "/bin/bash")

(setq term-eol-on-send t)

(defun my-color ()
  "Formatting code in my coding style"
  (interactive)
  (require 'color-theme-stesen-light)
  (color-theme-stesen-light)
  (set-cursor-color "DarkCyan"))

;;----------------------------------------------------------------------------
;; Handier way to add modes to auto-mode-alist
;;----------------------------------------------------------------------------
(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))


;;----------------------------------------------------------------------------
;; String utilities missing from core emacs
;;----------------------------------------------------------------------------
(defun string-all-matches (regex str &optional group)
  "Find all matches for `REGEX' within `STR', returning the full match string or group `GROUP'."
  (let ((result nil)
        (pos 0)
        (group (or group 0)))
    (while (string-match regex str pos)
      (push (match-string group str) result)
      (setq pos (match-end group)))
    result))

(defun string-rtrim (str)
  "Remove trailing whitespace from `STR'."
  (replace-regexp-in-string "[ \t\n]*$" "" str))


;;----------------------------------------------------------------------------
;; Find the directory containing a given library
;;----------------------------------------------------------------------------
(autoload 'find-library-name "find-func")
(defun directory-of-library (library-name)
  "Return the directory in which the `LIBRARY-NAME' load file is found."
  (file-name-as-directory (file-name-directory (find-library-name library-name))))


;;----------------------------------------------------------------------------
;; Delete the current file
;;----------------------------------------------------------------------------
(defun delete-this-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (or (buffer-file-name) (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
                             (file-name-nondirectory buffer-file-name)))
    (delete-file (buffer-file-name))
    (kill-this-buffer)))


;;----------------------------------------------------------------------------
;; Rename the current file
;;----------------------------------------------------------------------------
(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file!" name))
    (if (get-buffer new-name)
        (message "A buffer named '%s' already exists!" new-name)
      (progn
        (rename-file filename new-name 1)
        (rename-buffer new-name)
        (set-visited-file-name new-name)
        (set-buffer-modified-p nil)))))

;;----------------------------------------------------------------------------
;; Browse current HTML file
;;----------------------------------------------------------------------------
(defun browse-current-file ()
  "Open the current file as a URL using `browse-url'."
  (interactive)
  (browse-url (concat "file://" (buffer-file-name))))


(require 'cl)

(defmacro with-selected-frame (frame &rest forms)
  (let ((prev-frame (gensym))
        (new-frame (gensym)))
    `(progn
       (let* ((,new-frame (or ,frame (selected-frame)))
              (,prev-frame (selected-frame)))
         (select-frame ,new-frame)
         (unwind-protect
             (progn ,@forms)
           (select-frame ,prev-frame))))))

;;a no-op function to bind to if you want to set a keystroke to null
(defun void () "this is a no-op" (interactive))

;convert a buffer from dos ^M end of lines to unix end of lines
(defun dos2unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;vice versa
(defun unix2dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;show ascii table
(defun ascii-table ()
  "Print the ascii table. Based on a defun by Alex Schroeder <asc@bsiag.com>"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
           (setq i (+ i 1))
           (insert (format "%4d %c\n" i i))))
  (beginning-of-buffer))

;insert date into buffer
(defun insert-date ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%a %b %e, %Y %l:%M %p")))

;;compute the length of the marked region
(defun region-length ()
  "length of a region"
  (interactive)
  (message (format "%d" (- (region-end) (region-beginning)))))

(defun zl-newline nil
  "open new line belowe current line"
  (interactive)
  (end-of-line)
  (newline))

(global-set-key [S-return] 'zl-newline)
