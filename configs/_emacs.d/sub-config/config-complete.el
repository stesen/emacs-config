; auto complete
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")  
(require 'auto-complete-config)  
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete")  
(ac-config-default) 

(setq skeleton-pair-alist t)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)

(setq default-abbrev-mode t)
(setq abbrev-file-name "~/.emacs.d/abbrev_defs")

(require 'icomplete+)
(icomplete-mode t)

(require 'auto-complete)
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(ac-set-trigger-key "TAB")

(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets/text-mode")
