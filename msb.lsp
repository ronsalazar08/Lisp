
(defun c:cot (/ *error* pt1 pt2)
	(defun *error*  (x)
		(if os
		 (setvar 'osmode os))
		(if (eq (strcase x) "*CANCEL*")
		 (princ "\n cancelled ...."))
		(princ)
	)
	;====(code)

	(setq pt1 (getpoint "\nPoint1:"))
	(setq pt2 (getpoint pt1 "\nPoint2:"))

	(setq os (getvar 'osmode))
	(setvar 'osmode 0)

	(setq l (distance pt1 pt2))
	(setq len (polar pt1 0 l))
	(setq mlen (polar pt1 0 (/ l 2)))
	(setq holder (fix (/ l 16.0)))
	(setq count 0)
	(setq putal (- l (* holder 16)))
	(setq mputal (/ putal 2))

	(setq x1 0.0)(setq y1 6.0)
	(setq x2 4.0)
	(setq x3 4.0)(setq y2 9.0)
	(setq x4 12.0)
	(setq x5 12.0)
	(setq x6 16.0)
	(setq tube  (List
					(List x1 y1)
					(List x2 y1)
					(List x3 y2)
					(List x4 y2)
					(List x5 y1)
					(List x6 y1)
				)
	)

	(while (< count (- holder 1))
		(setq x2 (+ x2 16))
		(setq x3 (+ x3 16))
		(setq x4 (+ x4 16))
		(setq x5 (+ x5 16))
		(setq x6 (+ x6 16))
		(setq tube (append tube (List 
									(List x2 y1)
									(List x3 y2)
									(List x4 y2)
									(List x5 y1)
									(List x6 y1)
								)
					)
		)
		(setq count (1+ count))
	)
	
	(setq a  '((15 10)(0 10)(0 -10)(15 -10)))
	(command "_.pline" (foreach pt a (command pt)) "")
	(setq fin1 (entlast))
	(command "_.rectangle" '(0 12) "_d" 10 24 '(10 0))
	(setq rec1 (entlast))

	
	(command "_.pline" (foreach pt tube (command pt)) "")
	(command "_.chprop" "_last" "" "_LWeight" ".75" "")
	(setq tube1 (entlast))
	(command "_.mirror" "_last" "" '(0 0) '(10 0) "")
	(setq tube2 (entlast))


	;|(cond
		( (and (>= putal 8) (<= putal 16))
			(command "_.pline" (List x1 y1) (List (- x1 mputal) y1) (List (- x1 mputal) -6)  (List x1 -6) "")
			(setq fline (entlast))
			(command "_.pline" (List x6 y1) (List (+ x6 mputal) y1) (List (+ x6 mputal) y1) (List (+ x6 mputal) -6)  (List x6 -6) "")
			(setq lline (entlast))
			(command "_.join" tube1 tube2 fline lline "")
			(setq finaltube (entlast))
			;(command "_.move" fin1 rec1 fin2 rec2 "" (List 0 0) (List (- mputal 4) 0) )
		);greaterthan equal 8
		
		( (and (>= putal 0) (< putal 8))
			(command "_.pline" (List x1 y1) (List x1 -6) "")
			(setq fline (entlast))
			(command "_.pline" (List x6 y1) (List x6 -6) "")
			(setq lline (entlast))
			(command "_.join" tube1 tube2 fline lline "")
			(setq finaltube (entlast))
			(command "_.move" fin1 rec1  fin2 rec2 "" (List 0 0) (List mputal 0) )
			;(command "_.mirror" fin1 rec1 "" mla mlap "" )
		);lessthan equal 8
		
	)|;
	(command "_.pline" (List x1 y1) (List (- x1 mputal) y1) (List (- x1 mputal) -6)  (List x1 -6) "")
	(setq fline (entlast))
	(command "_.pline" (List x6 y1) (List (+ x6 mputal) y1) (List (+ x6 mputal) y1) (List (+ x6 mputal) -6)  (List x6 -6) "")
	(setq lline (entlast))
	(command "_.join" tube1 tube2 fline lline "")
	(setq finaltube (entlast))
	
	
	(command "_.move" finaltube "" (List 0 0) (List mputal 0) )
	(command "_.move" finalTube rec1 fin1 "" '(0 0) pt1)
	(command "_.rotate" finalTube rec1 fin1 "" pt1 pt2)
	(command "_.copy" rec1 "" pt1 pt2 "")
	(setq rec2 (entlast))
	(command "_.copy" fin1 "" pt1 pt2 "")
	(setq fin2 (entlast))
	(command "_.rotate" rec2 fin2 "" pt2 180 )
	;====(endcode)
	(setvar 'osmode os)
)


(defun c:sttape (/ *error* pt1 pt2)
	(defun *error*  (x)
		(if os
		 (setvar 'osmode os))
		(if (eq (strcase x) "*CANCEL*")
		 (princ "\n cancelled ...."))
		(princ)
	)
	;====(code)

	(setq pt1 (getpoint "\nPoint1:"))
	(setq pt2 (getpoint pt1 "\nPoint2:"))

	(setq os (getvar 'osmode))
	(setvar 'osmode 0)

	(setq l (distance pt1 pt2))
	(setq len (polar pt1 0 l))
	(setq mlen (polar pt1 0 (/ l 2)))
	(setq holder (fix (/ l 12.0)))
	(setq count 0)
	(setq putal (- l (* holder 12)))
	(setq mputal (/ putal 2))
	
	(setq x 0.0)(setq y 0.0)
	(setq x1 0.0)(setq y1 12.0)
	(setq x2 12.0)(setq y2 0.0)
	(setq tube  (List
					(List x y)
					(List x1 y1)
					(List x2 y2)
				)
	)

	(while (< count (- holder 1))
		(setq x1 (+ x1 12))
		(setq x2 (+ x2 12))
		(setq tube (append tube (List 
									(List x1 y1)
									(List x2 y2)
								)
					)
		)
		(setq count (1+ count))
	)
	(setq x1 (+ x1 12))
	(setq tube (append tube (List 
								(List x1 y1)
							)
				)
	)
	
	(setq a  '((15 10)(0 10)(0 -10)(15 -10)))
	(command "_.pline" (foreach pt a (command pt)) "")
	(setq fin1 (entlast))

	(command "_.pline" (foreach pt tube (command pt)) "")
	(setq stape (entlast))
	
	(command "_.move" stape "" (List 0 0) (List mputal 0) )
	(command "_.move" stape "" (List 0 6) (List 0 0) )
	(command "_.move" stape fin1 "" '(0 0) pt1)
	(command "_.rotate" stape fin1 "" pt1 pt2)
	(command "_.copy" fin1 "" pt1 pt2 "")
	(setq fin2 (entlast))
	(command "_.rotate" fin2 "" pt2 180 )
	
	;====(endcode)
	(setvar 'osmode os)
)


(defun C:vo (/ *error* pt1 pt2)
	(defun *error*  (x)
		(if os
		 (setvar 'osmode os))
		(if (eq (strcase x) "*CANCEL*")
		 (princ "\n cancelled ...."))
		(princ)
	)
	
	(setq pt1 (getpoint "\nPoint1:"))
	(setq pt2 (getpoint pt1 "\nPoint2:"))
	(setq pt3 (angle pt1 pt2))
	(setq len (distance pt1 pt2))
	(setq w 12)

	(setq os (getvar 'osmode))
	(setvar 'osmode 0)

	(command "_.rectangle" '(0 6) "_d" len w '(10 0))
	(command "_.chprop" "_last" "" "_LWeight" ".75" "")
	(command "_.move" "_last" "" '(0 0) pt1)
	(command "_.rotate" "_last" "" pt1 pt2)
	
	(command "_.rectangle" '(0 12) "_d" 10 24 '(10 0))
	(command "_.move" "_last" "" '(0 0) pt1)
	(command "_.rotate" "_last" "" pt1 pt2)
	(command "_.copy" "_last" "" pt1 pt2 "")
	(command "_.rotate" "_last" "" pt2 180 )

	(setvar 'osmode os)
)


(defun C:cvo (/ *error* pt1 pt2)
	(defun *error*  (x)
		(if os
		 (setvar 'osmode os))
		(if (eq (strcase x) "*CANCEL*")
		 (princ "\n cancelled ...."))
		(princ)
	)
	
	(setq pt1 (getpoint "\nPoint1:"))
	(setq pt2 (getpoint pt1 "\nPoint2:"))
	(setq pt3 (angle pt1 pt2))
	(setq len (distance pt1 pt2))
	(setq w 12)

	(setq os (getvar 'osmode))
	(setvar 'osmode 0)

	(command "_.rectangle" '(0 6) "_d" len w '(10 0))
	(command "_.chprop" "_last" "" "_LType" "dashed" "_ltScale" "7" "_LWeight" ".75" "")
	(command "_.move" "_last" "" '(0 0) pt1)
	(command "_.rotate" "_last" "" pt1 pt2)
	
	(command "_.rectangle" '(0 12) "_d" 10 24 '(10 0))
	(command "_.move" "_last" "" '(0 0) pt1)
	(command "_.rotate" "_last" "" pt1 pt2)
	(command "_.copy" "_last" "" pt1 pt2 "")
	(command "_.rotate" "_last" "" pt2 180 )

	(setvar 'osmode os)
)


(defun C:ttrunk (/ *error* pt1 pt2)
	(defun *error*  (x)
		(if os
		 (setvar 'osmode os))
		(if (eq (strcase x) "*CANCEL*")
		 (princ "\n cancelled ...."))
		(princ)
	)
	(setq pt1 (getpoint "\nPoint1:"))
	(setq pt2 (getpoint pt1 "\nPoint2:"))
	
	(setq os (getvar 'osmode))
	(setvar 'osmode 0)
	
	(setq l (polar pt1 0 (distance pt1 pt2)))
	(setq ml (polar pt1 0 (/(distance pt1 pt2) 2)))
	(setq mla (list (car ml) (cadr ml)0))
	(setq mlap (list (car ml) (+ (cadr ml) 6)0))
	(setq a  '((6 0)(0 0)(0 10)(6 10)))

	(command "_.line" pt1 l "")
	(command "_.chprop" "_last" "" "_LWeight" "1" "")
	(setq line (entlast))
	(command "_.dimaligned" "" mla mlap)
	(command "_.rotate" line "" pt1 pt2)

	(endpoint pt2)
	(tolmsb pt2)
	(clipmsb pt2)

	(command "_.pline" (foreach pt a (command pt)) "")
	(command "_.chprop" "_last" "" "_LWeight" "Default" "")
	(command "_.move" "_last" "" '(0 5) pt1)
	(command "_.rotate" "_last" "" pt1 pt2)
	(command "_.copy" "_last" "" pt1 pt2)
	(command "_.rotate" "_last" "" pt2 180)

	(setvar 'osmode os)
)


(defun C:utrunk (/ *error* pt1 pt2)
	(defun *error*  (x)
		(if os
		 (setvar 'osmode os))
		(if (eq (strcase x) "*CANCEL*")
		 (princ "\n cancelled ...."))
		(princ)
	)
	(setq pt1 (getpoint "\nPoint1:"))
	(setq pt2 (getpoint pt1 "\nPoint2:"))
	
	(setq os (getvar 'osmode))
	(setvar 'osmode 0)
	
	(setq l (polar pt1 0 (distance pt1 pt2)))
	(setq ml (polar pt1 0 (/(distance pt1 pt2) 2)))
	(setq mla (list (car ml) (cadr ml)0))
	(setq mlap (list (car ml) (+ (cadr ml) 14)0))
	(setq a  '((6 0)(0 0)(0 10)(6 10)))

	(command "_.line" pt1 l "")
	(setq line (entlast))
	(command "_.dimaligned" "" mla mlap)
	(command "_.rotate" line "" pt1 pt2)

	(endpoint pt2)
	(tolmsb pt2)
	(clipmsb pt2)

	(setvar 'osmode os)
)


(defun C:mlocation (/ *error* cpt)
	(defun *error*  (x)
		(if os
		 (setvar 'osmode os))
		(if (eq (strcase x) "*CANCEL*")
		 (princ "\n cancelled ...."))
		(princ)
	)
	
	(setq cpt (getpoint "\nLocation Point:"))
	(setq diam 14)
	(setq num (getString "\nLocation Number:"))

	(setq os (getvar 'osmode))
	(setvar 'osmode 0)

	(command "_.circle" cpt "_d" diam "")
	(vl-cmdf "_.text" "_j" "_MC" cpt 0 num)

	(setvar 'osmode os)
)

(defun tolmsb (pt2)
	(setq tol1 (getint "\nMax Tolerance:"))
	(setq tol2 (getint "\nMin Tolerance:"))
	(if (and (= tol1 0) (= tol2 0))
	  (progn
		(princ)
	  )
	  (progn
		(command "_.line" '(0 15) '(0 -15) "")
		(command "_.chprop" "_last" "" "_LWeight" "1.2" "")
		(command "_.move" "_last" "" '(0 0)  (list tol1 0))
		(setq l1 (entlast))

		(command "_.line" '(0 15) '(0 -15) "")
		(command "_.chprop" "_last" "" "_LType" "dashed" "_ltScale" "7" "_LWeight" ".9" "")
		(command "_.move" "_last" "" '(0 0)  (list (- 0 tol2) 0))
		(setq l2 (entlast))

		(command "_.copybase" '(0 0) l1 l2 "")
		(command "_.erase" "_prev" "")
		(command "_.pasteblock" pt2)
		(command "_.rotate" "_last" "" pt2 "")
	  )
	)
)

(defun clipmsb (pt2)
	(setq clip (getstring "\nClip? : y/n"))
	(if (= clip "y")
	  (progn
		(setq wclip (getstring "\nWide Clip? : y/n"))
		(if (= wclip "y")
		  (progn
			(command "_.circle" '(0 0) 5 "")
			(command "_.chprop" "_last" "" "_LWeight" ".5" "")
			(setq c1 (entlast))

			(command "_.rectangle" '(-30 5) '(30 -5))
			(command "_.chprop" "_last" "" "_LWeight" ".5" "")
			(setq rec (entlast))
			
			(command "_.rectangle" '(-30 10) '(-10 -10))
			(command "_.chprop" "_last" "" "_LWeight" "Default" "")
			(setq rec1 (entlast))

			(command "-hatch" "Properties" "NET" ".25" "45" "Advanced" "Island" "Yes" "Style" "Normal" "" "Select" "_last" "" "")
			(command "_.chprop" "_last" "" "_color" "red" "")
			(setq h1 (entlast))
						
			(command "_.rectangle" '(30 10) '(10 -10))
			(command "_.chprop" "_last" "" "_LWeight" "Default" "")
			(setq rec2 (entlast))

			(command "-hatch" "Properties" "NET" ".25" "45" "Advanced" "Island" "Yes" "Style" "Normal" "" "Select" "_last" "" "")
			(command "_.chprop" "_last" "" "_color" "red" "")
			(setq h2 (entlast))
			
			(command "_.copybase" '(0 0) c1 rec rec1 h1 rec2 h2 "")
			(command "_.erase" "_prev" "")
			(command "_.pasteblock" pt2)
			(command "_.rotate" "_last" "" pt2 "")
		  )
		  (progn
			(setq fl  '((5 5)(-5 -5)))
			(setq bl  '((-5 5)(5 -5)))
			(command "_.circle" '(0 0) 5 "")
			(command "_.chprop" "_last" "" "_LWeight" ".5" "")
			(setq c1 (entlast))

			(command "_.rectangle" '(-5 5) '(5 -5))
			(command "_.chprop" "_last" "" "_LWeight" ".5" "")
			(setq r1 (entlast))

			(command "_.line" (foreach p fl (command p)) "")
			(command "_.chprop" "_last" "" "_LWeight" ".5" "")
			(setq l1 (entlast))
			
			(command "_.line" (foreach p bl (command p)) "")
			(command "_.chprop" "_last" "" "_LWeight" ".5" "")
			(setq l2 (entlast))
			
			(command "_.copybase" '(0 0) c1 r1 l1 l2 "")
			(command "_.erase" "_prev" "")
			(command "_.pasteblock" pt2)
			(command "_.rotate" "_last" "" pt2 "")
		  )
		)
	  )
	  (princ)
	)
)

(defun endpoint (pt2)
	(command "_.circle" '(0 0) "_d" 4 "")
	(setq olo (entlast))
	(command "-hatch" "Properties" "SOLID" "Advanced" "Island" "Yes" "Style" "Normal" "" "Select" "_last" "" "")
	(command "_.copybase" '(0 0) "_last" olo "")
	(command "_.erase" "_prev" "")
	(command "_.pasteblock" pt2)
	
)




;==================================================================================================




;|
(defun c:cot (/ *error* pt1 pt2)
	(defun *error*  (x)
		(if os
		 (setvar 'osmode os))
		(if (eq (strcase x) "*CANCEL*")
		 (princ "\n cancelled ...."))
		(princ)
	)
	;====(code)

	(setq pt1 (getpoint "Point1:"))
	(setq pt2 (getpoint pt1 "\nPoint2:"))

	(setq os (getvar 'osmode))
	(setvar 'osmode 0)

	(setq l (distance pt1 pt2))
	(setq len (polar pt1 0 l))
	(setq mlen (polar pt1 0 (/ l 2)))
	(setq holder (fix (/ l 16.0)))
	(setq mla (list (car mlen) (cadr mlen)0))
	(setq mlap (list (car mlen) (+ (cadr mlen) 16)0))
	(setq count 0)

	(setq x1 0.0)
	(setq y1 6.0)
	(setq x2 8.0)
	(setq y2 6.0)
	(setq x3 8.0)
	(setq y3 9.0)
	(setq x4 16.0)
	(setq y4 9.0)
	(setq x5 16.0)
	(setq y5 6.0)
	(setq tube  (List
					(List x1 y1)
					(List x2 y2)
					(List x3 y3)
					(List x4 y4)
					(List x5 y5) 
				)
	)

	(while (< count (- holder 1))
		(setq x2 (+ x2 16))
		(setq y2 6.0)
		(setq x3 (+ x3 16))
		(setq y3 9.0)
		(setq x4 (+ x4 16))
		(setq y4 9.0)
		(setq x5 (+ x5 16))
		(setq y5 6.0)
		(setq tube (append tube (List 
									(List x2 y2)
									(List x3 y3)
									(List x4 y4)
									(List x5 y5)
								)
					)
		)
		(setq count (1+ count))
	)
	
	(setq putal (- l (* holder 16)))
	(cond
		( (and (< putal 9) (>= putal 0))
			(setq tube (append tube (List (List (+ x5 putal) y2)  )   ))
			(command "_.pline" (List (+ x5 putal) y2) (List (+ x5 putal) -6) "")
			(setq lline (entlast))
		);lessthan than 8
		( (and (< putal 16) (> putal 9))
			(setq tube (append tube (List (List (+ x5 8) y5)(List (+ x4 8) y4)(List (+ x4 putal) y4)  )   ))
			(command "_.pline" (List (+ x4 putal) y4) (List (+ x4 putal) -9) "")
			(setq lline (entlast))
		);greaterthan than 8
	)
	(command "_.pline" (foreach pt tube (command pt)) "")
	(command "_.chprop" "_last" "" "_LWeight" ".5" "")
	(setq tube1 (entlast))
	(command "_.mirror" "_last" "" '(0 0) '(10 0) "")
	(setq tube2 (entlast))
	(command "_.pline" '(0 6) '(0 -6) "")
	(setq fline (entlast))
	(command "_.join" tube1 tube2 fline lline "")
	(setq finalTube (entlast))
	(command "_.move" finalTube "" '(0 0) pt1)
	(command "_.rotate" finalTube "" pt1 pt2)	
	(print holder)

	;====(endcode)
	(setvar 'osmode os)
)
|;