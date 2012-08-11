(setq mouse-yank-at-point t);支持中键粘贴
(setq mouse-sel-mode t)

(xterm-mouse-mode t)
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
