;;;;;;;;;; cedet ;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/cedet-1.1/common")
(require 'cedet)
(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(semantic-load-enable-guady-code-helpers)
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers) 
(setq semanticdb-default-save-directory "~/.emacs.tmp/semantic.cache")
(setq semanticdb-project-roots (list (expand-file-name "/")))
(setq-default semantic-idle-scheduler-idle-time 432000)

;;;;;;;;;; ecb ;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/plugins/ecb-2.40")
(require 'ecb)
(require 'ecb-autoloads)
(setq ecb-tip-of-the-day nil 
      ecb-tree-indent 4 
      ecb-windows-height 0.1
      ecb-windows-width 0.2)

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
		   (ecb-split-ver 0.4 t)
		   (other-window 1)
		   (ecb-set-cscope-buffer)
		   )
(defecb-window-dedicator ecb-set-cscope-buffer " *ECB cscope-buf*"
			 (switch-to-buffer "*cscope*"))
(setq ecb-history-make-buckets 'never)
(setq ecb-layout-name "my-cscope-layout")  
(global-set-key [f11] 'ecb-toggle-ecb-windows)
(ecb-activate)

;;;;;;;;;; cscope ;;;;;;;;;;
(require 'xcscope) ;;加载xcscope
(defun hide-cscope-buffer ()
 (delete-windows-on *cscope*))

(global-set-key (kbd "<f1> s") 'cscope-find-this-symbol)
(global-set-key (kbd "<f1> d") 'cscope-find-global-definition)
(global-set-key (kbd "<f1> c") 'cscope-find-functions-calling-this-function)
(global-set-key (kbd "<f1> f") 'cscope-find-this-file)
(global-set-key (kbd "<f1> m") 'cscope-pop-mark)
(global-set-key (kbd "<f1> n") 'cscope-next-symbol)
(global-set-key (kbd "<f1> p") 'cscope-prev-symbol)
(global-set-key (kbd "<f1> h") 'hide-cscope-buffer)
(global-set-key (kbd "<f1> f") 'cscope-next-file)
(global-set-key (kbd "<f1> b") 'cscope-prev-file)
(global-set-key (kbd "<f1> t") 'cscope-find-this-text-string)
(global-set-key (kbd "<f1> g") 'cscope-find-global-definition-no-prompting)
(global-set-key (kbd "<f1> e") 'cscope-find-egrep-pattern)
(global-set-key (kbd "<f1> i") 'cscope-find-files-including-file)

(custom-set-variables
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1)))
