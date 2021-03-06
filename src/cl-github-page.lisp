(in-package :cl-github-page)

(defun main (&optional (forced-p nil))
  (clrhash *categories*)
  (let ((srcs (get-all-sources)))
    (update-all-posts srcs forced-p)
    (write-rss srcs)
    (write-about-me)
    (write-index srcs)))

(defblog-file *debug-source-dir* "debug/src/")
(defblog-file *debug-post-dir* "debug/posts/")
(defblog-file *debug-index* "debug/index.html")

(defun test-main ()
  (let ((*sources-dir* *debug-source-dir*)
        (*posts-dir* *debug-post-dir*)
        (*index* *debug-index*))
    (main t)))

(defun string-concat (s1 s2)
  (concatenate 'string s1 s2))

(defun create (&optional (blog-dir *blog-dir*))
  "Creates a directory to be used as the local blog."
  (ensure-directories-exist blog-dir)
  (let ((src (string-concat blog-dir "src/"))
	(posts (string-concat blog-dir "posts/"))
	(tags (string-concat blog-dir "tags.lisp"))
	(friends (string-concat blog-dir "friends.lisp")))
    (ensure-directories-exist src)
    (ensure-directories-exist posts)
    (unless (probe-file tags)
      (with-open-file (s tags :direction :output)
	(print '() s)
	(format t "Creates the tags.lisp~%")))
    (unless (probe-file friends)
      (with-open-file (s friends :direction :output)
	(print '() s)
	(format t "Creates the friends.lisp~%")))))
