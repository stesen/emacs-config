(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(inhibit-startup-screen t)
 '(save-place t nil (saveplace))
 '(session-use-package t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans YuanTi Mono" :foundry "unknown" :slant normal :weight normal :height 81 :width normal)))))

(add-to-list 'load-path "~/.emacs.d/elisp")

(load-file "~/.emacs.d/sub-config/config-color.elc")
(load-file "~/.emacs.d/sub-config/config-misc.elc")
(load-file "~/.emacs.d/sub-config/config-c-coding.elc")
(load-file "~/.emacs.d/sub-config/config-complete.elc")
(load-file "~/.emacs.d/sub-config/config-mouse.elc")
(load-file "~/.emacs.d/sub-config/config-lisp.elc")

(load-file "~/.emacs.d/sub-config/config-ecb-cedet.elc")
