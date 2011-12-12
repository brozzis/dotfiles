;; (pushnew "~/.emacs.d/" load-path)



 ;; Optional
 ;;  ;; (require 'tinypath)

(defadvice cperl-indent-command
  (around cperl-indent-or-complete)
  "Changes \\\\[cperl-indent-command] so it autocompletes when at the end of a word."
  (if (looking-at "\\>")
      (dabbrev-expand nil)
    ad-do-it))
(eval-after-load "cperl-mode"
  '(progn (require 'dabbrev) (ad-activate 'cperl-indent-command)))

(load-library "cperl-mode")
(add-to-list 'auto-mode-alist '("\\\\.[Pp][LlMm][Cc]?$" . cperl-mode))
(while (let ((orig (rassoc 'perl-mode auto-mode-alist)))
	 (if orig (setcdr orig 'cperl-mode))))
(while (let ((orig (rassoc 'perl-mode interpreter-mode-alist)))
	 (if orig (setcdr orig 'cperl-mode))))
(dolist (interpreter '("perl" "perl5" "miniperl" "pugs"))
  (unless (assoc interpreter interpreter-mode-alist)
    (add-to-list 'interpreter-mode-alist (cons interpreter 'cperl-mode))))

(defvar perltidy-mode nil
  "Automatically 'perltidy' when saving.")
(make-variable-buffer-local 'perltidy-mode)
(defun perltidy-write-hook ()
  "Perltidys a buffer during 'write-file-hooks' for 'perltidy-mode'"
  (if perltidy-mode
      (save-excursion
	(widen)
	(mark-whole-buffer)
	(not (perltidy)))
    nil))

(defun perltidy-mode (&optional arg)
  "Perltidy minor mode."
  (interactive "P")
  (setq perltidy-mode
	(if (null arg)
	    (not perltidy-mode)
	  (> (prefix-numeric-value arg) 0)))
  (make-local-hook 'write-file-hooks)
  (if perltidy-mode
      (add-hook 'write-file-hooks 'perltidy-write-hook)
    (remove-hook 'write-file-hooks 'perltidy-write-hook)))
(if (not (assq 'perltidy-mode minor-mode-alist))
    (setq minor-mode-alist
	  (cons '(perltidy-mode " Perltidy")
		minor-mode-alist)))

					
;  (eval-after-load "cperl-mode"
;                       '(add-hook 'cperl-mode-hook 'perltidy-mode))



(defun indent-or-expand (arg)
  "Either indent according to mode, or expand the word preceding
point."
  (interactive "*P")
  (if (and
       (or (bobp) (= ?w (char-syntax (char-before))))
       (or (eobp) (not (= ?w (char-syntax (char-after))))))
      (dabbrev-expand arg)
    (indent-according-to-mode)))

(defun my-tab-fix ()
  (local-set-key [tab] 'indent-or-expand))
 
(add-hook 'c-mode-hook          'my-tab-fix)
(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'perl-mode-hook      'my-tab-fix)
(add-hook 'php-mode-hook      'my-tab-fix)
(add-hook 'cperl-mode-hook      'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)


(defun jao-toggle-selective-display ()
  (interactive)
  (set-selective-display (if selective-display nil 1)))

(global-set-key [f1] 'jao-toggle-selective-display)

; (set-default-font "-adobe-courier-medium-r-normal--18-180-75-75-m-110-iso8859-1")

(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))

(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                  (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'sacha/increase-font-size)
(global-set-key (kbd "C--") 'sacha/decrease-font-size)

(defun annotate-todo ()
   "put fringe marker on TODO: lines in the curent buffer"
  (interactive)
  (let (lit)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "TODO:" nil t)
      (progn
        (setq lit (c-in-literal)) ;; or csharp-in-literal
        (if (or (eq lit 'c) (eq lit 'c++))
            (let ((overlay (make-overlay (- (point) 5) (point))))
              (overlay-put overlay 'before-string
                           (propertize "A"
                                       'display
                                       '(left-fringe   ;; right
                                         horizontal-bar
                                         better-fringes-important-bitmap))))))))))


(add-to-list 'load-path "~/emacs.d/packages/emacs-tiny-tools/lisp/tiny")
(add-to-list 'load-path "~/emacs.d/packages/emacs-tiny-tools/lisp/other")

(load "folding" 'nomessage 'noerror)
(folding-mode-add-find-file-hook)

(folding-add-to-marks-list 'php-mode                "//{"  "//}"  nil t)
(folding-add-to-marks-list 'prolog-mode             "%{{{" "%}}}" nil t)
(folding-add-to-marks-list 'html-mode               "<!-- {{{ " "<!-- }}} -->" " -->" nil t)

(folding-add-to-marks-list 'cperl-mode                "# {{"  "# }}"  nil t)

