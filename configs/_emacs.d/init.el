;;; init.el --- emacs init file

(setq load-path (cons "~/.emacs.d/elisp" load-path)) 
;(add-to-list 'load-path "~/tools/share/emacs/24.1/lisp")
(add-to-list 'load-path "~/.emacs.d/subconfigs")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(ido-enable-dot-prefix nil)
 '(ido-enable-flex-matching t)
 '(ido-enable-prefix t)
 '(ido-enable-regexp t)
 '(session-use-package t nil (session))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil background "#141414" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant italic :weight normal :height 81 :width normal :foundry "microsoft" :family "Consolas"))))
 '(diff-removed ((t (:foreground "Red")))))

(require 'color-theme)
(color-theme-initialize)
(add-to-list 'load-path "~/.emacs.d/elisp/theme")

;(require 'color-theme-xoria256)
;(color-theme-xoria256)

(load-file "~/.emacs.d/elisp/theme/color-theme-tangotango.elc")
(color-theme-tangotango)

;(require 'color-theme-stesen-light)
;(color-theme-stesen-light)

;(load-file "~/.emacs.d/elisp/theme/solarized-light-theme.elc")

(require 'setq-configs)
(require 'misc-configs)
(require 'programming-configs)
(require 'c-programming-configs)

(global-set-key [f12] 'load-clang-configs)
(defun load-clang-configs ()
  (interactive)
  (require 'ecb-configs))
