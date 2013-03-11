(provide 'ecb-configs)

;;;;;;;;;;;;;;;;;;;; cedet ;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/cedet-1.1/common")
(add-to-list 'load-path "~/.emacs.d/plugins/cedet-1.1/eieio")

(require 'cedet)
(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(semantic-load-enable-gaudy-code-helpers)
(setq semantic-highlight-func-mode t)
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)
(setq semanticdb-default-save-directory "~/.semantic.cache")
(setq semantic-stickyfunc-mode nil)
(setq semantic-c-takeover-hideif t)

;(require 'semantic/bovine/c)
;; configure for kernel
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat (getenv "PWD") "/include/generated/autoconf.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat (getenv "PWD") "/include/linux/kernel.h"))
(semantic-reset-system-include 'c-mode)

(semantic-add-system-include "/home/stesen/src/daily-9701/bionic/libc/include" 'c-mode)
(semantic-add-system-include (concat (getenv "PWD") "/arch/arm/include") 'c-mode)
(semantic-add-system-include (concat (getenv "PWD") "/include") 'c-mode)
(semantic-add-system-include (concat (getenv "PWD") "/arch/arm/mach-k3v2/include") 'c-mode)

(semantic-c-add-preprocessor-symbol "__KERNEL__" "")
(semantic-c-add-preprocessor-symbol "__LINUX_ARM_ARCH__" "7")
(semantic-c-add-preprocessor-symbol "KBUILD_STR(s)" "#s")
(semantic-c-add-preprocessor-symbol "KBUILD_BASENAME" "KBUILD_STR(main)")
(semantic-c-add-preprocessor-symbol "KBUILD_MODNAME" "KBUILD_STR(main)")

;; 避免semantic占用CPU过多
;(setq-default semantic-idle-scheduler-idle-time 432000)
(defvar semantic-lex-c-preprocessor-symbol-file '())
;(add-to-list 'semantic-lex-c-preprocessor-symbol-file "~/src/u9200-chn-temp/mydroid/bootable/bootloader/u-boot/include/configs/omap4430sdp.h")
(setq semantic-lex-c-preprocessor-symbol-map 
      '( 
	 ( "__cplusplus" . nil ) 
	 ( "CONFIG_FASTBOOT" . nil ) 
	 ))
(defconst cedet-user-include-dirs
	  (list ".." "../include" "../inc"
	   "../.." "../../include" "../../inc"
	   "../../.." "../../../include" "../../../inc"
	   ))

(global-ede-mode t)
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)
(require 'semantic-c nil 'noerror)
(let ((include-dirs cedet-user-include-dirs))
  (mapc (lambda (dir)
	  (semantic-add-system-include dir 'c++-mode)
	  (semantic-add-system-include dir 'c-mode))
	include-dirs))

;;;;;;;;;;;;;;;;;;;; ecb ;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/ecb-2.40")

(require 'ecb)
(require 'ecb-autoloads)
(setq ecb-tip-of-the-day nil 
      ecb-tree-indent 4 
      ecb-windows-height 0.1
      ecb-windows-width 0.2)

(custom-set-variables
 '(ecb-auto-update-methods-after-save t)
 '(ecb-force-reparse-when-semantic-idle-scheduler-off t)
 '(ecb-options-version "2.40"))

;; for ecb method-buffer display
(add-hook 'semantic-init-hooks 
	  (lambda ()
	    (senator-minor-mode t)))

(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (require 'xcscope)))

(add-hook 'c++-mode-common-hook
	  '(lambda ()
	     (require 'xcscope)))

(add-hook 'c++-mode-hook 'ecb-rebuild-methods-buffer)
(add-hook 'c-mode-hook 'ecb-rebuild-methods-buffer)

(ecb-layout-define "my-cscope-layout" left nil  
		   ;		   (ecb-split-ver 0.5 t)
		   ;		   (other-window 1)
		   (ecb-set-methods-buffer)  
		   ;-----------------------
		   ;--------------------------------------------------
		   ;    (ecb-split-ver 0.8 t)  
		   ;    (other-window 1)  
		   ;    (ecb-set-sources-buffer) 
		   ;-------------------------------------------------- 
		   ;-----------------------
		   (ecb-split-ver 0.6 t)
		   (other-window 1)
		   (ecb-set-history-buffer) 
		   ;-----------------------
		   (ecb-split-ver 0.3 t)
		   (other-window 1)
		   (ecb-set-cscope-buffer)
;		   (ecb-set-symboldef-buffer)
		   )
(defecb-window-dedicator ecb-set-cscope-buffer " *ECB cscope-buf*"
			 (switch-to-buffer "*cscope*"))
(setq ecb-history-make-buckets 'never)
(setq ecb-layout-name "my-cscope-layout")
(setq ecb-primary-secondary-mouse-buttons 'mouse-1--C-mouse-1)
(ecb-activate)
(global-set-key [f11] 'ecb-toggle-ecb-windows)
(defun delete-other-windows-except-cscope ()
  (interactive)
  (delete-other-windows))
(global-set-key (kbd "C-x 1") 'delete-other-windows-except-cscope)
;(global-set-key [f12] 'ecb-activate)

;;;;;;;;;;;;;;;;;;;; doxymacs ;;;;;;;;;;;;;;;;;;;;
(require 'doxymacs)
(defun my-doxymacs-font-lock-hook ()  
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(doxymacs-mode)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(add-hook 'c++-mode-common-hook 'doxymacs-mode)

(defconst doxymacs-C++-file-comment-template
 '("/*" > n
   " * " (doxymacs-doxygen-command-char) "file   "
   (if (buffer-file-name)
       (file-name-nondirectory (buffer-file-name))
     "") > n
   " * " (doxymacs-doxygen-command-char) "author " (user-full-name)
   (doxymacs-user-mail-address)
   > n
   " * " (doxymacs-doxygen-command-char) "date   " (current-time-string) > n
   " *" > n
   " * " (doxymacs-doxygen-command-char) "brief  " (p "Brief description of this file: ") > n
   " *" > n
   " *" p > n
   " */" > n)
 "C & CPP template for file documentation.")

(defconst doxymacs-C++-function-comment-template
 '((let ((next-func (doxymacs-find-next-func)))
     (if next-func
	 (list
	  'l
	  "/*" '> 'n
	  " *" 'p '> 'n
	  " *" '> 'n
	  (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
	  (unless (string-match
                   (regexp-quote (cdr (assoc 'return next-func)))
                   doxymacs-void-types)
	    '(l " *" > n " * " (doxymacs-doxygen-command-char)
		"return " (p "Returns: ") > n))
	  " */" '>)
       (progn
	 (error "Can't find next function declaration.")
	 nil))))
 "C & CPP template for function documentation.")

(defconst doxymacs-C++-blank-multiline-comment-template
 '("/*" > n "*" p > n "*/" > n)
 "C & CPP template for a blank multiline doxygen comment.")

(defconst doxymacs-JavaDoc-blank-singleline-comment-template
 '("/* " > p "*/")
 "C & CPP template for a blank single line doxygen comment.")

(setq doxymacs-doxygen-style "C++")
