(defun ac-php-add-use ()
  "Show classes popup."
  (interactive)
  (save-excursion
    (ac-php-goto-use)
    (end-of-line)
    (newline)
    ;; get rid of leading slash and insert use statement
    (insert (format "use %s;" (subseq (ac-php-classes-popup) 1)))))

(defun ac-php-goto-use ()
  "Move cursor to use statements."
  (interactive)
  (xref-push-marker-stack)
  (goto-char (point-min))
  ;; try to find first "namespace" keyword to add new "use"s after it.
  (re-search-forward "^namespace [a-zA-Z0-9\].*;$" nil t)
  ;; find last "use" keyword.
  (while (re-search-forward "^use [a-zA-Z0-9\].*;$" nil t)))

(defun ac-php-classes-popup ()
  (ivy-completing-read "Enter class name: " (ac-php-g--class-map (ac-php-get-tags-data)) nil nil ""))
