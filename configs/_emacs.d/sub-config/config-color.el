(require 'color-theme)
(color-theme-initialize)
(color-theme-tangotango)

(require 'highlight-symbol)
(global-set-key (kbd "<f1> <f1>") 'highlight-symbol-at-point)
(global-set-key (kbd "<f1> <f2>") 'highlight-symbol-prev)
(global-set-key (kbd "<f1> <f3>") 'highlight-symbol-next)
(global-set-key (kbd "<f1> <f4>") 'highlight-symbol-prev-in-defun)
(global-set-key (kbd "<f1> <f5>") 'highlight-symbol-next-in-defun)
(global-set-key (kbd "<f5> <f5>") 'revert-buffer-with-coding-system)

(require 'highlight-tail)
(setq highlight-tail-colors
      '(("black" . 0)
	("#bc2525" . 25)
	("black" . 66)))

(require 'highlight-current-line)
(highlight-current-line-on t)  
(set-face-background 'highlight-current-line-face "#333333")

(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(require 'zjl-hl)
;(zjl-hl-enable-global-all-modes)
