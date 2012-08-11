(add-to-list 'load-path "~/tools/share/emacs/24.1/lisp")

(setq user-full-name "MaYaohui")
(setq user-mail-address "stesenchina@gamil.com")
(setq bookmark-default-file "~/.emacs.d/.emacs.bmk")
(setq abbrev-file-name "~/.emacs.d/.abbrev_defs")
(setq version-control t)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.emacs.tmp")))
(setq backup-by-copying t)
(setq initial-scratch-message nil)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(setq stack-trace-on-error nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq Man-notify-method 'pushy)
(setq default-fill-column 120)
(setq scroll-step 1
      scroll-margin 5
      scroll-conservatively 10000)
(setq default-line-spacing 0)
(setq default-major-mode 'text-mode)
(transient-mark-mode t)
(setq show-paren-style 'parentheses)
(setq enable-recursive-minibuffers t)
(setq suggest-key-bindings 1)
(setq tab-always-indent nil)
(global-set-key [M-/] 'hippie-expand)
(setq track-eol t)
(setq-default kill-whole-line t)
(setq kill-ring-max 200)
(setq apropos-do-all t)
(setq-default ispell-program-name "aspell")
(put 'narrow-to-region 'disabled nil)
(setq x-select-enable-clipboard t)
(setq frame-title-format '("%f"))
(setq line-number-mode t)
(setq lazy-lock-defer-on-scrolling t)
(setq font-lock-maximum-decoration t)
(set-clipboard-coding-system 'ctext)
(setq resize-mini-windows nil)

(global-linum-mode t)
(auto-image-file-mode)
(auto-compression-mode 1)
(column-number-mode t)

(require 'linum+)

(require 'redo+)

(setq default-tab-width 8)
(setq tab-stop-list ())
(setq standard-indent 8)

(defadvice kill-region (before slickcut activate compile)
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

(defadvice kill-ring-save (before slick-copy activate compile)
	   (interactive (if mark-active (list (region-beginning) (region-end))
			  (message "Copied line")
			  (list (line-beginning-position)
				(line-beginning-position 2)))))

(require 'tabbar)
(tabbar-mode)

(require 'session) ;;加载session
(add-hook 'after-init-hook 'session-initialize) ;; 启动时初始化session
(add-hook 'find-file-hooks 'auto-insert)
(customize-set-variable 'scroll-bar-mode' right)
(setq make-backup-files nil)
(setq auto-save-mode nil)
(setq make-backup-files nil)

'(auto-fill-mode t)

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
(put 'scroll-left 'disabled nil)

(setq smart-compile-alist
      '( ("\\.rb$" . "spec %f")))

(setq woman-default-indent 7            ;缩进格式
      woman-fill-frame t                ;填充满屏幕
      woman-use-own-frame nil           ;同一个frame
      woman-cache-level 3)              ;缓存级别, 最快

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'session)
(add-hook 'after-init-hook 'session-initialize)

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

(setq bookmark-save-flag 1)

;;ibuffer
(require 'ibuffer)
(global-set-key (kbd "<f2> <f2>") 'ibuffer)

(require 'multi-term)
(setq multi-term-program "/bin/bash")
(setq term-eol-on-send t)

(require 'git)
(require 'git-blame)
(setq save-place-file "~/.emacs.d/saveplace")
(require 'saveplace)
(setq-default save-place t)

(add-hook 'perl-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
; (add-hook 'perl-mode-hook (lambda () (setq comment-column 48) ))

(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)

(global-set-key (kbd "<f2> a") 'windmove-left)         ; move to left windnow
(global-set-key (kbd "<f2> d") 'windmove-right)        ; move to right window
(global-set-key (kbd "<f2> w") 'windmove-up)           ; move to upper window
(global-set-key (kbd "<f2> s") 'windmove-down)         ; move to downer window

(define-key global-map "\M-[1~" 'beginning-of-line)
(define-key global-map [select] 'end-of-line)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'cursor-change)
(cursor-change-mode t)

;; set recent-jump
(setq rj-ring-length 10000)
(require 'recent-jump)
(global-set-key (kbd "M-,") 'recent-jump-backward)
(global-set-key (kbd "M-.") 'recent-jump-forward)
(recent-jump-mode t)

(defun confirm-exit-emacs ()
  "ask for confirmation before exiting emacs"
  (interactive)
  (if (yes-or-no-p "Are you sure you want to exit? ")
    (save-buffers-kill-emacs)))

(global-unset-key "\C-x\C-c")
(global-set-key "\C-x\C-c" 'confirm-exit-emacs)
