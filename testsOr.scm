(load "/home/haims/Desktop/comp181/comp181/compiler.scm")

;Tests for every ast
(define failed-tests (box 0))

(define assert-equal 
    (lambda (test-name exp1 exp2)
    ;(display (string-append "Test " test-name ": "))
    ;(for-each display '("Test " (string<? test-name) ": "))
        (if (equal? exp1 exp2)
        (set-box! failed-tests (unbox failed-tests))
        ;(display "Passed\n")
        (begin 
            (set-box! failed-tests (+ (unbox failed-tests) 1))
            (display (string-append "Test " test-name ": "))
            (display "Failed\n====>expected:") (display exp2) (display "\n====>got:") (display exp1) (display "\n"))
            )))
    
        
;Tests of <Boolean> 

;fail
(assert-equal "<Boolean> F1" (test-string <Boolean> "YYYYTYY") `(failed with report:))  
(assert-equal "<Boolean> F2" (test-string <Boolean> "Y#fYYYYY") `(failed with report:))  
(assert-equal "<Boolean> F3" (test-string <Boolean> " #t")  `(failed with report:))  
(assert-equal "<Boolean> F4" (test-string <Boolean> "7#t")  `(failed with report:))
(assert-equal "<Boolean> F5" (test-string <Boolean> "#r")  `(failed with report:))
(assert-equal "<Boolean> F6" (test-string <Boolean> "fFf")  `(failed with report:))
(assert-equal "<Boolean> F7" (test-string <Boolean> "tTt#")  `(failed with report:))

;succ
(assert-equal "<Boolean> T1" (test-string <Boolean> "#t") '((match #t) (remaining "")))  
(assert-equal "<Boolean> T2" (test-string <Boolean> "#f") '((match #f) (remaining "")))  
(assert-equal "<Boolean> T3" (test-string <Boolean> "#T")  '((match #t) (remaining "")))  
(assert-equal "<Boolean> T4" (test-string <Boolean> "#F")  '((match #f) (remaining "")))
(assert-equal "<Boolean> T5" (test-string <Boolean> "#TYYYYYYY")  '((match #t) (remaining "YYYYYYY")))
(assert-equal "<Boolean> T6" (test-string <Boolean> "#f#234YY4")  '((match #f) (remaining "#234YY4")))
(assert-equal "<Boolean> T7" (test-string <Boolean> "#t  ###")  '((match #t) (remaining "  ###")))
(assert-equal "<Boolean> T8" (test-string <Boolean> "#F#t11")  '((match #f) (remaining "#t11")))


;Tests of <CharPrefix> 

;fail
;(assert-equal "<CharPrefix> F1" (test-string <CharPrefix> "#\nYYYYTYY") `(failed with report:))  
;(assert-equal "<CharPrefix> F2" (test-string <CharPrefix> "  #\\") `(failed with report:))  
;(assert-equal "<CharPrefix> F3" (test-string <CharPrefix> "a34")  `(failed with report:))  
;(assert-equal "<CharPrefix> F4" (test-string <CharPrefix> "!!!")  `(failed with report:))
;(assert-equal "<CharPrefix> F5" (test-string <CharPrefix> "#r")  `(failed with report:))
;(assert-equal "<CharPrefix> F6" (test-string <CharPrefix> "    ")  `(failed with report:))
;(assert-equal "<CharPrefix> F7" (test-string <CharPrefix> "444444444")  `(failed with report:))

;succ
;(assert-equal "<CharPrefix> T1" (test-string <CharPrefix> "#\\") '((match "#\\") (remaining ""))) 
;(assert-equal "<CharPrefix> T2" (test-string <CharPrefix> "#\\123") '((match "#\\") (remaining "123")))  
;(assert-equal "<CharPrefix> T3" (test-string <CharPrefix> "#\\  sdfs")  '((match "#\\") (remaining "  sdfs")))  
;(assert-equal "<CharPrefix> T4" (test-string <CharPrefix> "#\\#\\#\\")  '((match "#\\") (remaining "#\\#\\")))
;(assert-equal "<CharPrefix> T5" (test-string <CharPrefix> "#\\!#\\34242")  '((match "#\\") (remaining "!#\\34242")))

;Tests of <VisibleSimpleChar>

;fail
(assert-equal "<VisibleSimpleChar> F1" (test-string <VisibleSimpleChar> "\nYYYYTYY") `(failed with report:))  
(assert-equal "<VisibleSimpleChar> F2" (test-string <VisibleSimpleChar> (list->string (list (integer->char 31) (integer->char 75)))) `(failed with report:))  
(assert-equal "<VisibleSimpleChar> F3" (test-string <VisibleSimpleChar> (list->string (list (integer->char 0) (integer->char 75))))  `(failed with report:))  
(assert-equal "<VisibleSimpleChar> F4" (test-string <VisibleSimpleChar> (list->string (list (integer->char 32) (integer->char 75))))  `(failed with report:))
(assert-equal "<VisibleSimpleChar> F5" (test-string <VisibleSimpleChar> (list->string (list (integer->char 4) (integer->char 75))))  `(failed with report:))
(assert-equal "<VisibleSimpleChar> F6" (test-string <VisibleSimpleChar> (list->string (list (integer->char 7) (integer->char 75))))  `(failed with report:))
(assert-equal "<VisibleSimpleChar> F7" (test-string <VisibleSimpleChar> (list->string (list (integer->char 6) (integer->char 75) (integer->char 75) (integer->char 75))))  `(failed with report:))
(assert-equal "<VisibleSimpleChar> F8" (test-string <VisibleSimpleChar> " ") `(failed with report:))  
(assert-equal "<VisibleSimpleChar> F9" (test-string <VisibleSimpleChar> "      ") `(failed with report:))  

;succ
(assert-equal "<VisibleSimpleChar> T1" (test-string <VisibleSimpleChar> "#\\") '((match #\#) (remaining "\\"))) 
(assert-equal "<VisibleSimpleChar> T2" (test-string <VisibleSimpleChar> "5") '((match #\5) (remaining "")))  
(assert-equal "<VisibleSimpleChar> T3" (test-string <VisibleSimpleChar> "!")  '((match #\!) (remaining "")))  
(assert-equal "<VisibleSimpleChar> T4" (test-string <VisibleSimpleChar> "#\\!#\\34242")  '((match #\#) (remaining "\\!#\\34242")))
(assert-equal "<VisibleSimpleChar> T4" (test-string <VisibleSimpleChar> "\\    ") '((match #\\) (remaining "    "))) 
(assert-equal "<VisibleSimpleChar> T6" (test-string <VisibleSimpleChar> "sdsfsdf")  '((match #\s) (remaining "dsfsdf")))  
(assert-equal "<VisibleSimpleChar> T7" (test-string <VisibleSimpleChar> "dsfshgsgsf")  '((match #\d) (remaining "sfshgsgsf")))
(assert-equal "<VisibleSimpleChar> T8" (test-string <VisibleSimpleChar> "3534ger")  '((match #\3) (remaining "534ger")))
(assert-equal "<VisibleSimpleChar> T9" (test-string <VisibleSimpleChar> (list->string (list (integer->char 75) (integer->char 75))))  '((match #\K) (remaining "K")))




;tests of <NamedChar>    
;fail
(assert-equal "<NamedChar> F1" (test-string <NamedChar> "\nYYYYTYY") `(failed with report:))  
(assert-equal "<NamedChar> F2" (test-string <NamedChar> "dfhsdjfhjsdfh") `(failed with report:))  
(assert-equal "<NamedChar> F3" (test-string <NamedChar> "  22324234") `(failed with report:))  
(assert-equal "<NamedChar> F4" (test-string <NamedChar> "%^%^%^%##") `(failed with report:))  
(assert-equal "<NamedChar> F5" (test-string <NamedChar> "159874123") `(failed with report:))  
(assert-equal "<NamedChar> F6" (test-string <NamedChar> "dddddd") `(failed with report:))  
(assert-equal "<NamedChar> F7" (test-string <NamedChar> "heko") `(failed with report:))  

;succ
;<NamedChar>::=lambda, newline, nul, page, return, space, tab

(assert-equal "<NamedChar> T1" (test-string <NamedChar> "nul") `((match ,(integer->char 0)) (remaining ""))) 
(assert-equal "<NamedChar> T2" (test-string <NamedChar> "lambda") `((match ,(integer->char 955)) (remaining ""))) 
(assert-equal "<NamedChar> T3" (test-string <NamedChar> "newline") `((match ,(integer->char 10)) (remaining ""))) 
(assert-equal "<NamedChar> T4" (test-string <NamedChar> "page") `((match ,(integer->char 12)) (remaining ""))) 
(assert-equal "<NamedChar> T5" (test-string <NamedChar> "space") `((match ,(integer->char 32)) (remaining ""))) 
(assert-equal "<NamedChar> T6" (test-string <NamedChar> "tab") `((match ,(integer->char 9)) (remaining ""))) 
(assert-equal "<NamedChar> T7" (test-string <NamedChar> "return") `((match ,(integer->char 3)) (remaining ""))) 
(assert-equal "<NamedChar> T8" (test-string <NamedChar> "return8") `((match ,(integer->char 3)) (remaining "8"))) 


;Tests for <HexChar>
;fail

(assert-equal "<HexChar> F1" (test-string <HexChar> "g") `(failed with report:))
(assert-equal "<HexChar> F2" (test-string <HexChar> "hffg") `(failed with report:))
(assert-equal "<HexChar> F3" (test-string <HexChar> "\\\\") `(failed with report:))
(assert-equal "<HexChar> F4" (test-string <HexChar> "    tf") `(failed with report:))
(assert-equal "<HexChar> F5" (test-string <HexChar> "   0") `(failed with report:))
(assert-equal "<HexChar> F6" (test-string <HexChar> "!!!") `(failed with report:))
(assert-equal "<HexChar> F7" (test-string <HexChar> "XXXX") `(failed with report:))
(assert-equal "<HexChar> F8" (test-string <HexChar> "xhhhh") `(failed with report:))
(assert-equal "<HexChar> F9" (test-string <HexChar> "Zrwr") `(failed with report:))

;succ
;(assert-equal "<HexChar> T1" (test-string <HexChar> "0") '((match #\0) (remaining ""))) 
;(assert-equal "<HexChar> T2" (test-string <HexChar> "1   fdgdg") '((match #\1) (remaining "   fdgdg")))
;(assert-equal "<HexChar> T3" (test-string <HexChar> "2gvdfhgf") '((match #\2) (remaining "gvdfhgf")))
;(assert-equal "<HexChar> T4" (test-string <HexChar> "3\nffgdfg") '((match #\3) (remaining "\nffgdfg")))
;(assert-equal "<HexChar> T5" (test-string <HexChar> "49\\\\\\555") '((match #\4) (remaining "9\\\\\\555")))
;(assert-equal "<HexChar> T6" (test-string <HexChar> "59sfbsf") '((match #\5) (remaining "9sfbsf")))
;(assert-equal "<HexChar> T7" (test-string <HexChar> "692424624") '((match #\6) (remaining "92424624")))
;(assert-equal "<HexChar> T8" (test-string <HexChar> "7924b2k4bk") '((match #\7) (remaining "924b2k4bk")))
;(assert-equal "<HexChar> T9" (test-string <HexChar> "8@@$%@%@%@9") '((match #\8) (remaining "@@$%@%@%@9")))
;(assert-equal "<HexChar> T10" (test-string <HexChar> "9&&&&Hhf9") '((match #\9) (remaining "&&&&Hhf9")))
;(assert-equal "<HexChar> T11" (test-string <HexChar> "accsk k439") '((match 10) (remaining "ccsk k439")))
;(assert-equal "<HexChar> T12" (test-string <HexChar> "bsdv ds 9") '((match 11) (remaining "sdv ds 9")))
;(assert-equal "<HexChar> T13" (test-string <HexChar> "c9sdfd gdkdj  k ") '((match 12) (remaining "9sdfd gdkdj  k ")))
;(assert-equal "<HexChar> T14" (test-string <HexChar> "d              9                  ") '((match 13) (remaining "              9                  ")))
;(assert-equal "<HexChar> T15" (test-string <HexChar> "e9fsdf43") '((match 14) (remaining "9fsdf43")))
;(assert-equal "<HexChar> T16" (test-string <HexChar> "fff912312312") '((match 15) (remaining "ff912312312")))
;(assert-equal "<HexChar> T17" (test-string <HexChar> "A{}{}{{}{}{}{}9") '((match 10) (remaining "{}{}{{}{}{}{}9")))
;(assert-equal "<HexChar> T18" (test-string <HexChar> "Bcsycsv359") '((match 11) (remaining "csycsv359")))
;(assert-equal "<HexChar> T19" (test-string <HexChar> "Ccsdc352%^9") '((match 12) (remaining "csdc352%^9")))
;(assert-equal "<HexChar> T20" (test-string <HexChar> "D::::::::::9") '((match 13) (remaining "::::::::::9")))
;(assert-equal "<HexChar> T21" (test-string <HexChar> "ESYmonz9") '((match 14) (remaining "SYmonz9")))
;(assert-equal "<HexChar> T22" (test-string <HexChar> "FSHiraTotahit9") '((match 15) (remaining "SHiraTotahit9")))




;Tests of <HexUnicodeChar>

;fail

;Tests of <HexUnicodeChar>

;fail

(assert-equal "<HexUnicodeChar> F1" (test-string <HexUnicodeChar> "g") `(failed with report:))
(assert-equal "<HexUnicodeChar> F2" (test-string <HexUnicodeChar> "hffg") `(failed with report:))
(assert-equal "<HexUnicodeChar> F3" (test-string <HexUnicodeChar> "\\\\") `(failed with report:))
(assert-equal "<HexUnicodeChar> F4" (test-string <HexUnicodeChar> "    tf") `(failed with report:))
(assert-equal "<HexUnicodeChar> F5" (test-string <HexUnicodeChar> "   0") `(failed with report:))
(assert-equal "<HexUnicodeChar> F6" (test-string <HexUnicodeChar> "!!!") `(failed with report:))
(assert-equal "<HexUnicodeChar> F7" (test-string <HexUnicodeChar> "XXXX") `(failed with report:))
(assert-equal "<HexUnicodeChar> F8" (test-string <HexUnicodeChar> "yabcd3") `(failed with report:))
(assert-equal "<HexUnicodeChar> F9" (test-string <HexUnicodeChar> "Zrwr") `(failed with report:))
(assert-equal "<HexUnicodeChar> F10" (test-string <HexUnicodeChar> "ab3") `(failed with report:))


;succ
;(assert-equal "<HexUnicodeChar> T1" (test-string <HexUnicodeChar> "x0") '((match 0) (remaining ""))) 
;(assert-equal "<HexUnicodeChar> T2" (test-string <HexUnicodeChar> "X1   fdgdg") '((match 1) (remaining "   fdgdg")))
;(assert-equal "<HexUnicodeChar> T3" (test-string <HexUnicodeChar> "x2gvdfhgf") '((match 2) (remaining "gvdfhgf")))
;(assert-equal "<HexUnicodeChar> T4" (test-string <HexUnicodeChar> "X3\nffgdfg") '((match 3) (remaining "\nffgdfg")))
;(assert-equal "<HexUnicodeChar> T5" (test-string <HexUnicodeChar> "x49\\\\\\555") '((match 73) (remaining "\\\\\\555")))
;(assert-equal "<HexUnicodeChar> T6" (test-string <HexUnicodeChar> "X59sfbsf") '((match 89) (remaining "sfbsf")))
;(assert-equal "<HexUnicodeChar> T7" (test-string <HexUnicodeChar> "x692424624") '((match 28223620644) (remaining "")))
;(assert-equal "<HexUnicodeChar> T8" (test-string <HexUnicodeChar> "X7924b2k4bk") '((match 7939250) (remaining "k4bk")))
;(assert-equal "<HexUnicodeChar> T9" (test-string <HexUnicodeChar> "x8@@$%@%@%@9") '((match 8) (remaining "@@$%@%@%@9")))
;(assert-equal "<HexUnicodeChar> T10" (test-string <HexUnicodeChar> "X9X&&&&Hhf9") '((match 9) (remaining "X&&&&Hhf9")))
;(assert-equal "<HexUnicodeChar> T11" (test-string <HexUnicodeChar> "xaccsk k439") '((match 2764) (remaining "sk k439")))
;(assert-equal "<HexUnicodeChar> T12" (test-string <HexUnicodeChar> "Xbsdv ds 9") '((match 11) (remaining "sdv ds 9")))
;(assert-equal "<HexUnicodeChar> T13" (test-string <HexUnicodeChar> "xc9sdfd gdkdj  k ") '((match 201) (remaining "sdfd gdkdj  k ")))
;(assert-equal "<HexUnicodeChar> T14" (test-string <HexUnicodeChar> "Xd              9                  ") '((match 13) (remaining "              9                  ")))
;(assert-equal "<HexUnicodeChar> T15" (test-string <HexUnicodeChar> "xe9fsdf43") '((match 3743) (remaining "sdf43")))
;(assert-equal "<HexUnicodeChar> T16" (test-string <HexUnicodeChar> "Xfff912312312") '((match 281445217149714) (remaining "")))
;(assert-equal "<HexUnicodeChar> T17" (test-string <HexUnicodeChar> "xA{}{}{{}{}{}{}9") '((match 10) (remaining "{}{}{{}{}{}{}9")))
;(assert-equal "<HexUnicodeChar> T18" (test-string <HexUnicodeChar> "XBC6sycsv359") '((match 3014) (remaining "sycsv359")))
;(assert-equal "<HexUnicodeChar> T19" (test-string <HexUnicodeChar> "xCcsdc352%^9") '((match 204) (remaining "sdc352%^9")))
;(assert-equal "<HexUnicodeChar> T20" (test-string <HexUnicodeChar> "XD::::::::::9") '((match 13) (remaining "::::::::::9")))
;(assert-equal "<HexUnicodeChar> T21" (test-string <HexUnicodeChar> "xESYmonz9") '((match 14) (remaining "SYmonz9")))
;(assert-equal "<HexUnicodeChar> T22" (test-string <HexUnicodeChar> "XFSHiraTotahit9") '((match 15) (remaining "SHiraTotahit9")))

;<Char>::=<CharPrefix> ( <VisibleSimpleChar>| <NamedChar> | <HexUnicodeChar> )

;Tests for <Char>
;fail
(assert-equal "<Char> F1" (test-string <Char> "\\\nYYYYTYY") `(failed with report:))  
(assert-equal "<Char> F2" (test-string <Char> (list->string (list (integer->char 31) (integer->char 75)))) `(failed with report:))  
(assert-equal "<Char> F3" (test-string <Char> (list->string (list (integer->char 0) (integer->char 75))))  `(failed with report:))  
(assert-equal "<Char> F4" (test-string <Char> (list->string (list (integer->char 32) (integer->char 75))))  `(failed with report:))
(assert-equal "<Char> F5" (test-string <Char> (list->string (list (integer->char 4) (integer->char 75))))  `(failed with report:))
(assert-equal "<Char> F6" (test-string <Char> (list->string (list (integer->char 7) (integer->char 75))))  `(failed with report:))
(assert-equal "<Char> F7" (test-string <Char> (list->string (list (integer->char 6) (integer->char 75) (integer->char 75) (integer->char 75))))  `(failed with report:))
(assert-equal "<Char> F8" (test-string <Char> " ") `(failed with report:))  
(assert-equal "<Char> F9" (test-string <Char> "      ") `(failed with report:))  
(assert-equal "<Char> F10" (test-string <Char> "\nYYYYTYY") `(failed with report:))  
(assert-equal "<Char> F12" (test-string <Char> "\\dfhsdjfhjsdfh") `(failed with report:))  
(assert-equal "<Char> F13" (test-string <Char> "  22324234") `(failed with report:))  
(assert-equal "<Char> F14" (test-string <Char> "%^%^%^%##") `(failed with report:))  
(assert-equal "<Char> F15" (test-string <Char> "159874123") `(failed with report:))  
(assert-equal "<Char> F16" (test-string <Char> "\ndddddd") `(failed with report:))  
(assert-equal "<Char> F17" (test-string <Char> "heko") `(failed with report:))  
(assert-equal "<Char> F18" (test-string <Char> "g") `(failed with report:))
(assert-equal "<Char> F19" (test-string <Char> "hffg") `(failed with report:))
(assert-equal "<Char> F20" (test-string <Char> "\\\\") `(failed with report:))
(assert-equal "<Char> F21" (test-string <Char> "    tf") `(failed with report:))
(assert-equal "<Char> F22" (test-string <Char> "   0") `(failed with report:))
(assert-equal "<Char> F23" (test-string <Char> "!!!") `(failed with report:))
(assert-equal "<Char> F24" (test-string <Char> "XXXX") `(failed with report:))
(assert-equal "<Char> F25" (test-string <Char> "yabcd3") `(failed with report:))
(assert-equal "<Char> F26" (test-string <Char> "Zrwr") `(failed with report:))
(assert-equal "<Char> F27" (test-string <Char> "ab3") `(failed with report:))


;;;


;Tests of <Natural> 
;fail
(assert-equal "<Natural> F1" (test-string <Natural> "YYYYTYY") `(failed with report:))  
(assert-equal "<Natural> F2" (test-string <Natural> "  6666") `(failed with report:))  
(assert-equal "<Natural> F3" (test-string <Natural> "a34")  `(failed with report:))  
(assert-equal "<Natural> F4" (test-string <Natural> "!!!")  `(failed with report:))
(assert-equal "<Natural> F5" (test-string <Natural> "#r")  `(failed with report:))
(assert-equal "<Natural> F6" (test-string <Natural> "    ")  `(failed with report:))
(assert-equal "<Natural> F7" (test-string <Natural> "dgdgdgdfg534")  `(failed with report:))

;succ
(assert-equal "<Natural> T1" (test-string <Natural> "0") '((match 0) (remaining ""))) 
(assert-equal "<Natural> T2" (test-string <Natural> "4") '((match 4) (remaining "")))  
(assert-equal "<Natural> T3" (test-string <Natural> "5464")  '((match 5464) (remaining "")))  
(assert-equal "<Natural> T4" (test-string <Natural> "0000043")  '((match 0000043) (remaining "")))
;(assert-equal "<Natural> T5" (test-string <Natural> "0000043Ffs")  `(failed with report:))
(assert-equal "<Natural> T6" (test-string <Natural> "4645646   6   /112")  '((match 4645646) (remaining "   6   /112")))
;(assert-equal "<Natural> T7" (test-string <Natural> "1230ff33")  `(failed with report:))
(assert-equal "<Natural> T8" (test-string <Natural> "134 321")  '((match 134) (remaining " 321")))


(assert-equal "<Integer> F1" (test-string <Integer> "YYYYTYY") `(failed with report:))  
(assert-equal "<Integer> F2" (test-string <Integer> "  6666") `(failed with report:))  
(assert-equal "<Integer> F3" (test-string <Integer> "a34")  `(failed with report:))  
(assert-equal "<Integer> F4" (test-string <Integer> "!!!")  `(failed with report:))
(assert-equal "<Integer> F5" (test-string <Integer> "#r")  `(failed with report:))
(assert-equal "<Integer> F6" (test-string <Integer> "    ")  `(failed with report:))
(assert-equal "<Integer> F7" (test-string <Integer> "dgdgdgdfg534")  `(failed with report:))

;succ
(assert-equal "<Integer> T1" (test-string <Integer> "+0") '((match 0) (remaining ""))) 
(assert-equal "<Integer> T2" (test-string <Integer> "-4") '((match -4) (remaining "")))  
(assert-equal "<Integer> T3" (test-string <Integer> "-5464")  '((match -5464) (remaining "")))  
(assert-equal "<Integer> T4" (test-string <Integer> "+0000043")  '((match 0000043) (remaining "")))
;(assert-equal "<Integer> T5" (test-string <Integer> "+0000043Ffs")  `(failed with report:))
(assert-equal "<Integer> T6" (test-string <Integer> "4645646   6   112")  '((match 4645646) (remaining "   6   112")))
;(assert-equal "<Integer> T7" (test-string <Integer> "1230ff33")  `(failed with report:))
(assert-equal "<Integer> T8" (test-string <Integer> "134 321")  '((match 134) (remaining " 321")))



;(assert-equal "<WhiteSpace> T1" (test-string <WhiteSpace> "    2") '((match  "") (remaining "2"))) 

(assert-equal "<Fraction> F1" (test-string <Fraction> "YYYYTYY") `(failed with report:))  
(assert-equal "<Fraction> F2" (test-string <Fraction> "  6666") `(failed with report:))  
(assert-equal "<Fraction> F3" (test-string <Fraction> "a34")  `(failed with report:))  
(assert-equal "<Fraction> F4" (test-string <Fraction> "!!!")  `(failed with report:))
(assert-equal "<Fraction> F5" (test-string <Fraction> "#r")  `(failed with report:))
(assert-equal "<Fraction> F6" (test-string <Fraction> "8\\j")  `(failed with report:))
(assert-equal "<Fraction> F7" (test-string <Fraction> "dgdgdgdfg534")  `(failed with report:))

;succ
(assert-equal "<Fraction> T1" (test-string <Fraction> "+1/2") '((match 1/2) (remaining ""))) 
(assert-equal "<Fraction> T2" (test-string <Fraction> "122/4") '((match 61/2) (remaining "")))  
(assert-equal "<Fraction> T3" (test-string <Fraction> "-5464/13")  '((match -5464/13) (remaining "")))  
(assert-equal "<Fraction> T4" (test-string <Fraction> "+4/4")  '((match 1) (remaining "")))
(assert-equal "<Fraction> T5" (test-string <Fraction> "12/4 xvdv")  '((match 3) (remaining " xvdv")))
;(assert-equal "<Fraction> T6" (test-string <Fraction> "+0000043/1Ffs")  `(failed with report:))
(assert-equal "<Fraction> T7" (test-string <Fraction> "+0000043/1   Ffs")  '((match 43) (remaining "   Ffs")))
;(assert-equal "<Fraction> T8" (test-string <Fraction> "-0000043/1!!!   Ffs")  `(failed with report:))


;Tests of <StringLiteralChar>

;fail
(assert-equal "<StringLiteralChar> F1" (test-string <StringLiteralChar> "\\YYYYTYY") `(failed with report:))  
(assert-equal "<StringLiteralChar> F2" (test-string <StringLiteralChar> "\\$@#$@TYY") `(failed with report:))  
(assert-equal "<StringLiteralChar> F3" (test-string <StringLiteralChar> "\\") `(failed with report:))  
(assert-equal "<StringLiteralChar> F4" (test-string <StringLiteralChar> "\"2424224YYYYTYY") `(failed with report:))  
(assert-equal "<StringLiteralChar> F5" (test-string <StringLiteralChar> "\"   YYYYTYY") `(failed with report:))  
(assert-equal "<StringLiteralChar> F6" (test-string <StringLiteralChar> "\\\\\\YYYYTYY") `(failed with report:))  

;succ
(assert-equal "<StringLiteralChar> T1" (test-string <StringLiteralChar> " ") '((match #\space) (remaining ""))) 
(assert-equal "<StringLiteralChar> T2" (test-string <StringLiteralChar> "#\\") '((match #\#) (remaining "\\"))) 
(assert-equal "<StringLiteralChar> T3" (test-string <StringLiteralChar> "4654646") '((match #\4) (remaining "654646"))) 
(assert-equal "<StringLiteralChar> T4" (test-string <StringLiteralChar> "aasdsad") '((match #\a) (remaining "asdsad"))) 

;tests of <StringMetaChar>

;fail
(assert-equal "<StringMetaChar> F1" (test-string <StringMetaChar> "spaceYYYYTYY") `(failed with report:))  
(assert-equal "<StringMetaChar> F2" (test-string <StringMetaChar> "$@#$@TYY") `(failed with report:))  
(assert-equal "<StringMetaChar> F3" (test-string <StringMetaChar> "") `(failed with report:))  
(assert-equal "<StringMetaChar> F4" (test-string <StringMetaChar> " ") `(failed with report:))  
(assert-equal "<StringMetaChar> F5" (test-string <StringMetaChar> "!@#   YYYYTYY") `(failed with report:))  
(assert-equal "<StringMetaChar> F6" (test-string <StringMetaChar> "533535YYYYTYY") `(failed with report:))  
(assert-equal "<StringMetaChar> F7" (test-string <StringMetaChar> "rtrt\neteYYYYTYY") `(failed with report:))  
(assert-equal "<StringMetaChar> F8" (test-string <StringMetaChar> "     YYYYTYY") `(failed with report:))  

;(StringMetaChar>::=\\| \"| \t| \f| \n| \r


;succ 
(assert-equal "<StringMetaChar> T1" (test-string <StringMetaChar> "\\\\YYYYTYY") '((match #\\) (remaining "YYYYTYY")))  
(assert-equal "<StringMetaChar> T2" (test-string <StringMetaChar> "\\\"$#$@TYY") '((match #\") (remaining "$#$@TYY")))  
(assert-equal "<StringMetaChar> T3" (test-string <StringMetaChar> "\\t") '((match #\tab) (remaining "")))  
(assert-equal "<StringMetaChar> T4" (test-string <StringMetaChar> "\\f2424224YYYYTYY") '((match #\page) (remaining "2424224YYYYTYY")))  
(assert-equal "<StringMetaChar> T5" (test-string <StringMetaChar> "\\n   YYYYTYY") '((match #\newline) (remaining "   YYYYTYY")))  
(assert-equal "<StringMetaChar> T6" (test-string <StringMetaChar> "\\r\\\\YYYYTYY") '((match #\return) (remaining "\\\\YYYYTYY")))  
;<StringHexChar> 

;fail
(assert-equal "<StringHexChar> F1" (test-string <StringHexChar> "\\xspaceYYYYTYY") `(failed with report:))
(assert-equal "<StringHexChar> F2" (test-string <StringHexChar> "\\xSpaceYYYYTYY") `(failed with report:))
(assert-equal "<StringHexChar> F3" (test-string <StringHexChar> "\\x   spaceYYYYTYY") `(failed with report:))
(assert-equal "<StringHexChar> F4" (test-string <StringHexChar> "xABspaceYYYYTYY") `(failed with report:))
(assert-equal "<StringHexChar> F5" (test-string <StringHexChar> "123;spaceYYYYTYY") `(failed with report:))
(assert-equal "<StringHexChar> F6" (test-string <StringHexChar> "  spaceYYYYTYY") `(failed with report:))
(assert-equal "<StringHexChar> F7" (test-string <StringHexChar> "!!!!!YYTYY") `(failed with report:))
(assert-equal "<StringHexChar> F8" (test-string <StringHexChar> "\\xGGG%#^#$%#aceYYYYTYY") `(failed with report:))
(assert-equal "<StringHexChar> F9" (test-string <StringHexChar> "\\x12345YYYTYY") `(failed with report:))
(assert-equal "<StringHexChar> F10" (test-string <StringHexChar> "\\\\\\\\xspaceYYYYTYY") `(failed with report:))

;succ
(assert-equal "<StringHexChar> T1" (test-string <StringHexChar> "\\x1234;") `((match ,(integer->char 4660)) (remaining "")))
;(assert-equal "<StringHexChar> T2" (test-string <StringHexChar> "\\XFFFF;") `((match ,(integer->char 65535)) (remaining "")))
;(assert-equal "<StringHexChar> T3" (test-string <StringHexChar> "\\xABF1;") `((match ,(integer->char 44017)) (remaining "")))
;(assert-equal "<StringHexChar> T4" (test-string <StringHexChar> "\\X14Fe;gdg") `((match ,(integer->char 5374)) (remaining "gdg")))
;(assert-equal "<StringHexChar> T5" (test-string <StringHexChar> "\\xaAAa;") `((match ,(integer->char 43690)) (remaining "")))
(assert-equal "<StringHexChar> T6" (test-string <StringHexChar> "\\Xa123;Sfsdf;") `((match ,(integer->char 41251)) (remaining "Sfsdf;")))
(assert-equal "<StringHexChar> T7" (test-string <StringHexChar> "\\x11111;YYYYTYY;") `((match ,(integer->char 69905)) (remaining "YYYYTYY;")))
(assert-equal "<StringHexChar> T8" (test-string <StringHexChar> "\\X24;      !") `((match ,(integer->char 36)) (remaining "      !")))
(assert-equal "<StringHexChar> T9" (test-string <StringHexChar> "\\x1;    ") `((match ,(integer->char 1)) (remaining "    ")))
(assert-equal "<StringHexChar> T10"(test-string <StringHexChar> "\\X0000;R") `((match,(integer->char 0) ) (remaining "R")))
(assert-equal "<StringHexChar> T11" (test-string <StringHexChar> "\\x0f;") `((match ,(integer->char 15)) (remaining "")))
(assert-equal "<StringHexChar> T12" (test-string <StringHexChar> "\\X1;\\x63;YYYYTYY") `((match ,(integer->char 1)) (remaining "\\x63;YYYYTYY")))



;Tests <Vector>
;fail
(assert-equal "<Vector> F1" (test-string <Vector> "2") `(failed with report:))  
(assert-equal "<Vector> F2" (test-string <Vector> "#(2") `(failed with report:)) 
(assert-equal "<Vector> F3" (test-string <Vector> "#(#t") `(failed with report:))  
(assert-equal "<Vector> F4" (test-string <Vector> "#2)") `(failed with report:))  
(assert-equal "<Vector> F5" (test-string <Vector> "#hate my life") `(failed with report:))  
(assert-equal "<Vector> F6" (test-string <Vector> "##") `(failed with report:))  
(assert-equal "<Vector> F7" (test-string <Vector> "#[why]") `(failed with report:))  
(assert-equal "<Vector> F8" (test-string <Vector> "#{why)") `(failed with report:))

;sucess
;(assert-equal "<Vector> T1" (test-string <Vector> "#(#t#t)") '((match #(#t#t)) (remaining ""))) 
;(assert-equal "<Vector> T2" (test-string <Vector> "#(2)") '((match #(2)) (remaining ""))) 
;(assert-equal "<Vector> T3" (test-string <Vector> "#((2)(3)(4))") '((match#((2)(3)(4))) (remaining ""))) 
;(assert-equal "<Vector> T4" (test-string <Vector> "#((2/2)(-3)(4/12))") '((match #((1)(-3)(1/3))) (remaining ""))) 
;(assert-equal "<Vector> T5" (test-string <Vector> "#((ofir))") '((match #(("ofir"))) (remaining ""))) 
;(assert-equal "<Vector> T6" (test-string <Vector> "#((ofir)(2)(-12/1))") '((match #(("ofir")(2)(-12))) (remaining ""))) 
;(assert-equal "<Vector> T7" (test-string <Vector> "#(#(ofir)#(2)#(-12/1))") '((match #(#("ofir")#(2)#(-12))) (remaining ""))) 



;sucess
;(assert-equal "<Symbol> F1" (test-string <Symbol> "~~~") `(failed with report:))  
;(assert-equal "<Symbol> F2" (test-string <Symbol> "#(2)") `(failed with report:))  
;(assert-equal "<Symbol> F3" (test-string <Symbol> "#t") `(failed with report:))  
;(assert-equal "<Symbol> F4" (test-string <Symbol> "#((hi))") `(failed with report:))  
;(assert-equal "<Symbol> F5" (test-string <Symbol> "]!((!") `(failed with report:))  
;(assert-equal "<Symbol> F6" (test-string <Symbol> "#((hi~))") `(failed with report:))  
;(assert-equal "<Symbol> F7" (test-string <Symbol> "#((hi:))") `(failed with report:))  
;(assert-equal "<Symbol> F8" (test-string <Symbol> "#((hi]))") `(failed with report:))  

;<SymbolChar>::=(0 | · · · | 9) | (a | · · · | z) | (A | · · · | Z) | ! | $
;| ^ | * | - | _ | = | + | < | > | ? | /


;fail
;(assert-equal "<Symbol> T1" (test-string <Symbol> "1a") '((match "1a") (remaining ""))) 
;(assert-equal "<Symbol> T2" (test-string <Symbol> "2gvdfhgf") '((match "2gvdfhgf") (remaining ""))) 
;(assert-equal "<Symbol> T3" (test-string <Symbol> "!!!sdfjdshfkjshd") '((match "!!!sdfjdshfkjshd") (remaining ""))) 
;(assert-equal "<Symbol> T4" (test-string <Symbol> "DSGFFDJ12!") '((match "DSGFFDJ12!") (remaining ""))) 
;(assert-equal "<Symbol> T5" (test-string <Symbol> "+<>-?/") '((match "+<>-?/") (remaining ""))) 
;(assert-equal "<Symbol> T6" (test-string <Symbol> "_$$_DFFDG123^") '((match "_$$_DFFDG123^") (remaining ""))) 
;(assert-equal "<Symbol> T7" (test-string <Symbol> "1a") '((match "1a") (remaining ""))) 

;(assert-equal "<sexpr> T1" (test-string <sexpr> "1a") '((match "1a") (remaining ""))) 
(assert-equal "<sexpr> T2" (test-string <sexpr> "'()") '((match '()) (remaining "")))

;fail
;(assert-equal "<ProperList> F1" (test-string <ProperList> "2") `(failed with report:))  

;sucess
;(assert-equal "<ProperList> T1" (test-string <ProperList> "(#t#t)") '((match (#t#t)) (remaining ""))) 
;(assert-equal "<ProperList> T2" (test-string <ProperList> "(2)") '((match (2)) (remaining ""))) 
;(assert-equal "<ProperList> T3" (test-string <ProperList> "((2)(3)(4))") '((match ((2)(3)(4))) (remaining ""))) 
;(assert-equal "<ProperList> T4" (test-string <ProperList> "((2/2)(-3)(4/12))") '((match ((1)(-3)(1/3))) (remaining ""))) 
;(assert-equal "<ProperList> T5" (test-string <ProperList> "((ofir))") '((match (("ofir"))) (remaining ""))) 
;(assert-equal "<ProperList> T6" (test-string <ProperList> "((ofir)(2)(-12/1))") '((match (("ofir")(2)(-12))) (remaining ""))) 
;(assert-equal "<ProperList> T7" (test-string <ProperList> "(#(ofir)#(2)#(-12/1))") '((match (#("ofir")#(2)#(-12))) (remaining ""))) 


;tests for ImproperList
;fail
;(assert-equal "<ImproperList> F1" (test-string <ProperList> "2") `(failed with report:))  

;sucess
;(assert-equal "<ImproperList> T1" (test-string <ImproperList> "(#t . #t)") '((match (#t . #t)) (remaining ""))) 
;(assert-equal "<ImproperList> T2" (test-string <ImproperList> "(2 . 2)") '((match (2 . 2)) (remaining ""))) 
;(assert-equal "<ImproperList> T3" (test-string <ImproperList> "(1 . '())") '((match (1 . '())) (remaining ""))) 
;(assert-equal "<ImproperList> T4" (test-string <ImproperList> "((2/2)(-3)(4/12))") '((match ((1)(-3)(1/3))) (remaining ""))) 
;(assert-equal "<ImproperList> T5" (test-string <ImproperList> "((ofir))") '((match (("ofir"))) (remaining ""))) 
;(assert-equal "<ImproperList> T6" (test-string <ImproperList> "((ofir)(2)(-12/1))") '((match (("ofir")(2)(-12))) (remaining ""))) 
;(assert-equal "<ImproperList> T7" (test-string <ImproperList> "(#(ofir)#(2)#(-12/1))") '((match (#("ofir")#(2)#(-12))) (remaining ""))) 



;(ImproperList>::=( <Sexpr>^+ . (Sexpr> )

(assert-equal "<Quoted> T1" (test-string <Quoted> "'7") '((match '7) (remaining ""))) 
(assert-equal "<ProperList> T1" (test-string <ProperList> "(a b)") '((match (a b)) (remaining ""))) 
(assert-equal "<Vector> T1" (test-string <Vector> "#(a b)") '((match #(a b)) (remaining "")))
(assert-equal "<Vector> T2" (test-string <Vector> "#(a)") '((match #(a)) (remaining "")))
(assert-equal "<Vector> T3" (test-string <Vector> "#()") '((match #()) (remaining "")))
(assert-equal "<Vector> T4" (test-string <Vector> "#(a b c d e)") '((match #(a b c d e)) (remaining ""))) 
(assert-equal "<ImproperList> T2" (test-string <ImproperList> "(#t . #t)") '((match (#t . #t)) (remaining "")))
(assert-equal "<ImproperList> T2" (test-string <ImproperList> "((#t) . #t)") '((match ((#t) . #t)) (remaining "")))
(assert-equal "<sexpr> T00" (test-string <sexpr> "##(-b - d)") '((match (- (- b) d)) (remaining "")))
(assert-equal "<sexpr> T0" (test-string <sexpr> "##(-b - d) / (2 * a)") '((match (/ (- (- b) d) (* 2 a))) (remaining "")))
(assert-equal "<sexpr> T1" (test-string <sexpr> "(x2 ##((-b - d) / (2 * a)))") '((match (x2 (/ (- (- b) d) (* 2 a)))) (remaining "")))
(assert-equal "<sexpr> T4" (test-string <InfixExtension> "##sqrt(b ^ 2 - 4 * a * c)") '((match (sqrt (- (expt b 2) (* (* 4 a) c)))) (remaining "")))
(assert-equal "<Assigm> T1" (test-string <sexpr> "   (let* ((d ##sqrt(b ^ 2 - 4 * a * c))  (x1 ##((-b + d) / (2 * a)))          (x2 ##((-b - d) / (2 * a))))    `((x1 ,x1) (x2 ,x2)))   ") 
'((match (let* ((d (sqrt (- (expt b 2) (* (* 4 a) c))))
(x1 (/ (+ (- b) d) (* 2 a)))
(x2 (/ (- (- b) d) (* 2 a))))
`((x1 ,x1) (x2 ,x2))))
(remaining "")))


(assert-equal "<Assigm> T2"
(test-string <sexpr> "
(let ((result ##a[0] + 2 * a[1] + 3 ^ a[2] - a[3] * b[i][j][i + j]))
result)
")
'((match (let ((result (- (+ (+ (vector-ref a 0)
(* 2 (vector-ref a 1)))
(expt 3 (vector-ref a 2)))
(* (vector-ref a 3)
(vector-ref
(vector-ref (vector-ref b i) j)
(+ i j))))))
result))
(remaining "")))

(assert-equal "<assign> T3" (test-string <sexpr> "
(let ((result (* n ##3/4^3 + 2/7^5)))
(* result (f result) ##g(g(g(result, result), result), result)))
") '((match (let ((result (* n (+ (expt 3/4 3) (expt 2/7 5)))))
(* result
(f result)
(g (g (g result result) result) result))))
(remaining "")))


(assert-equal "<assign> T4" (test-string <sexpr> "
## a[0] + a[a[0]] * a[a[a[0]]] ^ a[a[a[a[0]]]] ^ a[a[a[a[a[0]]]]]
") '((match (+ (vector-ref a 0)
(* (vector-ref a (vector-ref a 0))
(expt
(vector-ref a (vector-ref a (vector-ref a 0)))
(expt
(vector-ref
a
(vector-ref a (vector-ref a (vector-ref a 0))))
(vector-ref
a
(vector-ref
a
(vector-ref a (vector-ref a (vector-ref a 0))))))))))
(remaining "")))



(assert-equal "<assign> T5"   (test-string <sexpr> "
## 2 + #; 3 - 4 + 5 * 6 ^ 7 8
") '((match (+ 2 8)) (remaining "")))


(assert-equal "<assign> T6"  (test-string <sexpr> "
`(the answer is: ##2 * 3 + 4 * 5)
") '((match `(the answer is: (+ (* 2 3) (* 4 5))))
(remaining "")))


(assert-equal "<assign> T7"  (test-string <sexpr> "(+ 1 ##2 + 3 a b c)") '((match (+ 1 (+ 2 3) a b c)) (remaining "")))

(assert-equal "<assign> T8"  (test-string <sexpr> "(4 #;#;#;9 6 3 5 1)") '((match (4 5 1)) (remaining "")))

(assert-equal "<assign> T90"  (test-string <sexpr> "##f(x+y, x-z, x*t)")  '((match (f (+ x y) (- x z) (* x t))) (remaining "")))



(assert-equal "<assign> T9"  

 (test-string <sexpr>
"
(cons
#;this-is-in-infix
#%f(x+y, x-z, x*t,
#;this-is-in-prefix
#%(g (cons x y)
#;#%this-is-in-infix
#%cons(x, y)
#;#%this-is-in-infix
#%list(x, y)
#;#%this-is-in-infix
#%h(#;this-is-in-prefix
#%(* x y),
#;this-is-in-prefix
#%(expt x z))))
#%2)
") 

'((match (cons
(f (+ x y)
(- x z)
(* x t)
(g (cons x y)
(cons x y)
(list x y)
(h (* x y)
(expt x z))))
2))
(remaining "")))


(assert-equal "<assign> T10"  
 (test-string <sexpr> "@a")
'((match (cbname a)) (remaining "")))
(assert-equal "<assign> T11"   (test-string <sexpr> "@(* a b)")
'((match (cbname (* a b))) (remaining "")))
(assert-equal "<assign> T10"   (test-string <sexpr> "{(* a b)}")
'((match (cbname (* a b))) (remaining "")))
(assert-equal "<assign> T11"   (test-string <sexpr> "{ (* a b) }")
'((match (cbname (* a b))) (remaining "")))
(assert-equal "<assign> T12"   (test-string <sexpr> "{ #%a + b * c ^ d }")
'((match (cbname (+ a (* b (expt c d))))) (remaining "")))
(assert-equal "<assign> T13"   (test-string <sexpr> " @ #%a + b * c ^ d ")
'((match (cbname (+ a (* b (expt c d))))) (remaining "")))

(assert-equal "<assign> T14" (test-string <sexpr> "#%f(x, #%@#%x + 1)")
'((match (f x (cbname (+ x 1)))) (remaining "")))
(assert-equal "<assign> T15" (test-string <sexpr> "#%f(i, #%@#%A[i], #%@#%A[i + 1]^i)")
'((match (f i
(cbname (vector-ref a i))
(cbname (expt (vector-ref a (+ i 1)) i))))
(remaining "")))


;(assert-equal "<ImproperList> T4" (test-string <ImproperList> "(1 . (2 . (3 . (4 . ()))))") '((match (1 2 3 4)) (remaining "")))
(display "\n")
(assert-equal "<ImproperList> T4" (test-string <ImproperList> "(a   aaa  (a0)  a . 123)") '((match (a aaa (a0) a . 123)) (remaining "")))

;start
 

 
;succ (almost like us because we suck lol)
(assert-equal "<String> T1" (test-string <String> "\"not capital letters\"") '((match "not capital letters") (remaining "")))


 
(assert-equal "<Vector> F1" (test-string <Vector> "##(aaa)") `(failed with report:))  
(assert-equal "<Vector> F2" (test-string <Vector> "#(a a a") `(failed with report:)) 
(assert-equal "<Vector> F3" (test-string <Vector> "#a a a)") `(failed with report:))  
(assert-equal "<Vector> F4" (test-string <Vector> "#[a a a]") `(failed with report:))  
(assert-equal "<Vector> F5" (test-string <Vector> "hi") `(failed with report:))  
(assert-equal "<Vector> F6" (test-string <Vector> "((3))") `(failed with report:))  
(assert-equal "<Vector> F7" (test-string <Vector> "'77") `(failed with report:))  

;succ
(assert-equal "<Vector> T1" (test-string <Vector> "#(a b)") '((match #(a b)) (remaining "")))
(assert-equal "<Vector> T2" (test-string <Vector> "#(a)") '((match #(a)) (remaining "")))
(assert-equal "<Vector> T3" (test-string <Vector> "#()") '((match #()) (remaining "")))
(assert-equal "<Vector> T4" (test-string <Vector> "#(a b c d e)") '((match #(a b c d e)) (remaining ""))) 
(assert-equal "<Vector> T5" (test-string <Vector> "#((a) (b) (c))") '((match #((a) (b) (c))) (remaining ""))) 
(assert-equal "<Vector> T6" (test-string <Vector> "#(#(#(3)))") '((match #(#(#(3)))) (remaining ""))) 
(assert-equal "<Vector> T7" (test-string <Vector> "#(this12Is23Symbol)") '((match #(this12is23symbol)) (remaining ""))) 
(assert-equal "<Vector> T8" (test-string <Vector> "#()") '((match #()) (remaining ""))) 
(assert-equal "<Vector> T9" (test-string <Vector> "#(((1 . 2) . 3))") '((match #(((1 . 2) . 3))) (remaining ""))) 
(assert-equal "<Vector> T10" (test-string <Vector> "#(((#t) . #t))") '((match #(((#t) . #t))) (remaining ""))) 
(assert-equal "<Vector> T11" (test-string <Vector> "#('7)") '((match #('7)) (remaining ""))) 


;fail
(assert-equal "<ImproperList> F1" (test-string <ImproperList> "#(aaa)") `(failed with report:))  
(assert-equal "<ImproperList> F1" (test-string <ImproperList> "#(a b)") `(failed with report:)) 
(assert-equal "<ImproperList> F2" (test-string <ImproperList> "#(a).b") `(failed with report:)) 
(assert-equal "<ImproperList> F3" (test-string <ImproperList> "#()") `(failed with report:)) 
(assert-equal "<ImproperList> F4" (test-string <ImproperList> "#(a b.() c d e)") `(failed with report:)) 
(assert-equal "<ImproperList> F5" (test-string <ImproperList> "((a) (b) (c))") `(failed with report:)) 
(assert-equal "<ImproperList> F6" (test-string <ImproperList> "#(#(#(3)))") `(failed with report:)) 
(assert-equal "<ImproperList> F7" (test-string <ImproperList> "#(this12Is23Symbol)") `(failed with report:)) 
(assert-equal "<ImproperList> F8" (test-string <ImproperList> "#(1.1.1.1.1)") `(failed with report:)) 
(assert-equal "<ImproperList> F9" (test-string <ImproperList> "(((1 . 2) . 3))") `(failed with report:)) 
(assert-equal "<ImproperList> F10" (test-string <ImproperList> "(((#t) . #t))") `(failed with report:))  
(assert-equal "<ImproperList> F11" (test-string <ImproperList> "(dammmmmmmmm") `(failed with report:)) 


;succ
(assert-equal "<ImproperList> T1" (test-string <ImproperList> "(#t . #t)") '((match (#t . #t)) (remaining "")))
(assert-equal "<ImproperList> T2" (test-string <ImproperList> "((#t) . #t)") '((match ((#t) . #t)) (remaining "")))
(assert-equal "<ImproperList> T3" (test-string <ImproperList> "((1 . 2) . 3)") '((match ((1 . 2) . 3)) (remaining "")))
(assert-equal "<ImproperList> T4" (test-string <ImproperList> "((1 . 2) . (3))") '((match ((1 . 2) . (3))) (remaining "")))
(assert-equal "<ImproperList> T5" (test-string <ImproperList> "((1 . 2) . #((2)))") '((match ((1 . 2) . #((2)))) (remaining "")))
(assert-equal "<ImproperList> T6" (test-string <ImproperList> "((#(1) . (2)) . hiiii)") '((match ((#(1) . (2)) . hiiii)) (remaining "")))
(assert-equal "<ImproperList> T7" (test-string <ImproperList> "((1a . 2$$$$) . 3)") '((match ((1a . 2$$$$) . 3)) (remaining "")))
(assert-equal "<ImproperList> T8" (test-string <ImproperList> "((!!!!!!! . ((((5))))) . ////llp)") '((match ((!!!!!!! . ((((5))))) . ////llp)) (remaining "")))
(assert-equal "<ImproperList> T9" (test-string <ImproperList> "((1 . #((2 . 3))) . 3)") '((match ((1 . #((2 . 3))) . 3)) (remaining "")))


;fail
(assert-equal "<ProperList> F1" (test-string <ProperList> "#(aaa)") `(failed with report:))  
(assert-equal "<ProperList> F2" (test-string <ProperList> "(aaa") `(failed with report:))  
(assert-equal "<ProperList> F3" (test-string <ProperList> "#((a)     a a]") `(failed with report:))  
(assert-equal "<ProperList> F4" (test-string <ProperList> "shhhhhhhh") `(failed with report:))  
(assert-equal "<ProperList> F6" (test-string <ProperList> "329324929384fd") `(failed with report:))  
(assert-equal "<ProperList> F7" (test-string <ProperList> "(()()") `(failed with report:))  
(assert-equal "<ProperList> F8" (test-string <ProperList> "(hi()") `(failed with report:))  
(assert-equal "<ProperList> F9" (test-string <ProperList> "#(!!!!!!!))") `(failed with report:))  
(assert-equal "<ProperList> F10" (test-string <ProperList> "(#)(aaa)") `(failed with report:))  

;succ
(assert-equal "<ProperList> T1" (test-string <ProperList> "(())") '((match (())) (remaining "")))
(assert-equal "<ProperList> T2" (test-string <ProperList> "((2))") '((match ((2))) (remaining "")))
(assert-equal "<ProperList> T3" (test-string <ProperList> "((2) (3))") '((match ((2) (3))) (remaining "")))
(assert-equal "<ProperList> T4" (test-string <ProperList> "((dammmmmmmmm) (hiiiii))") '((match ((dammmmmmmmm) (hiiiii))) (remaining "")))
(assert-equal "<ProperList> T5" (test-string <ProperList> "(#($$$$erer43))") '((match (#($$$$erer43))) (remaining "")))
(assert-equal "<ProperList> T6" (test-string <ProperList> "((1 . 2))") '((match ((1 . 2))) (remaining "")))
(assert-equal "<ProperList> T7" (test-string <ProperList> "(AfterFiveYears (Came) #(Reason))") '((match (afterfiveyears (came) #(reason))) (remaining "")))
(assert-equal "<ProperList> T8" (test-string <ProperList> "((whattttttt))") '((match ((whattttttt))) (remaining "")))
(assert-equal "<ProperList> T9" (test-string <ProperList> "(1111 (111 . 111) #($) (!!!!!^^^^??????=+++++>>><<<))") '((match(1111 (111 . 111) #($) (!!!!!^^^^??????=+++++>>><<<))) (remaining "")))


(assert-equal "TMeir T1" (test-string <sexpr> "#t") '((match #t) (remaining ""))) 
(assert-equal "TMeir T2" (test-string <sexpr> "1001") '((match 1001) (remaining ""))) 
(assert-equal "TMeir T3" (test-string <sexpr> "-125") '((match -125) (remaining ""))) 
(assert-equal "TMeir T4" (test-string <sexpr> "1/2") '((match 1/2) (remaining ""))) 
(assert-equal "TMeir T5" (test-string <sexpr> "-2/3") '((match -2/3) (remaining ""))) 
(assert-equal "TMeir T6" (test-string <sexpr> "#\\a") '((match #\a) (remaining ""))) 
(assert-equal "TMeir T7" (test-string <sexpr> "#\\lambda") `((match ,(integer->char 955)) (remaining ""))) 
(assert-equal "TMeir T8" (test-string <sexpr> "\"test\"") '((match "test") (remaining ""))) 
(assert-equal "TMeir T9" (test-string <sexpr> "\"test\\\\\\n\\t\"") '((match "test\n") (remaining ""))) 
(assert-equal "TMeir T10" (test-string <sexpr> "symbol") '((match symbol) (remaining ""))) 
(assert-equal "TMeir T11" (test-string <sexpr> "()") '((match ()) (remaining ""))) 
(assert-equal "TMeir T12" (test-string <sexpr> "'a") '((match 'a) (remaining ""))) 
(assert-equal "TMeir T13" (test-string <sexpr> "(1 . 2)") '((match (1 . 2)) (remaining ""))) 
(assert-equal "TMeir T14" (test-string <sexpr> "(1 2 3)") '((match ( 1 2 3 )) (remaining ""))) 
(assert-equal "TMeir T15" (test-string <sexpr> "(1 (2 (3)))") '((match (1 (2 (3)))) (remaining ""))) 
(assert-equal "TMeir T16" (test-string <sexpr> "(1 2 3 . ())") '((match (1 2 3)) (remaining ""))) 
(assert-equal "TMeir T17" (test-string <sexpr> "1 ;comment") '((match 1) (remaining ""))) 
(assert-equal "TMeir T18" (test-string <sexpr> "#;'(sexpr comment) 1") '((match 1) (remaining ""))) 
(assert-equal "TMeir T19" (test-string <sexpr> "`a") '((match `a) (remaining ""))) 
(assert-equal "TMeir T20" (test-string <sexpr> "`,'e") '((match `,'e) (remaining "")))


;(assert-equal "TMeir T21" (test-string <sexpr> "`(1 ,@a 3)") '((match `(1 ,@a 3)) (remaining ""))) 









(assert-equal "TMeir T22" (test-string <sexpr> "#()") '((match #()) (remaining ""))) 
(assert-equal "TMeir T23" (test-string <sexpr> "#(1 2)") '((match #(1 2)) (remaining ""))) 
(assert-equal "TMeir T24" (test-string <sexpr> "#((a b) #(1) 3)") '((match #((a b) #(1) 3)) (remaining ""))) 
(assert-equal "TMeir T25" (test-string <sexpr> "## 2 - #; 3 - 4 + 5 * 6 ^ 7 8 - 5") '((match (- (- 2 8) 5)) (remaining ""))) 
(assert-equal "TMeir T26" (test-string <sexpr> "(let* ((d ##sqrt(b ^ 2 - 5 * 3 - 1 - 1 - 4 * a * c)) (x1 ##((-b + d) / (2 * a))) (x2 ##((-b - d) / (a * 2)))) `((x1 ,x1) (x2 ,x2)))") '((match (let* ((d (sqrt (- (- (- (- (expt b 2) (* 5 3)) 1) 1) (* (* 4 a) c)))) (x1 (/ (+ (- b) d) (* 2 a))) (x2 (/ (- (- b) d) (* a 2)))) `((x1 ,x1) (x2 ,x2)))) (remaining ""))) 

(assert-equal "TMeir T27" (test-string <sexpr> "## - 5 / 1 - (4 - 5) + ## (+ 1 2)") '((match  (+ (- (/ (- 5) 1) (- 4 5)) (+ 1 2))) (remaining ""))) 

(assert-equal "TMeir T28" (test-string <sexpr> "## a[0] + a[a[0]] * #% (+ 5 7 4) * ## a[a[a[0]]] ^ a[a[a[a[0]]]] ^ a[a[a[a[a[0]]]]]") '((match (+ (vector-ref a 0) (* (* (vector-ref a (vector-ref a 0)) (+ 5 7 4)) (expt (vector-ref a (vector-ref a (vector-ref a 0))) (expt (vector-ref a (vector-ref a (vector-ref a (vector-ref a 0)))) (vector-ref a (vector-ref a (vector-ref a (vector-ref a (vector-ref a 0))))))))))  (remaining ""))) 

(assert-equal "TMeir T29" (test-string <sexpr> "(let* ((inf ##f(3 * 2 ^ a)) (pre (- 1 1 1 s)) (t ## inf * pre)) (+ inf pre t))") '((match (let* ((inf (f (* 3 (expt 2 a)))) (pre (- 1 1 1 s)) (t (* inf pre))) (+ inf pre t))) (remaining ""))) 
(assert-equal "TMeir T30" (test-string <sexpr> "(let ((vec (- 1 ##3/5-2^4*6))) (- vec (g vec) ## g(g(g(vec - a[vec])))))") '((match (let ((vec (- 1 (- 3/5 (* (expt 2 4) 6))))) (- vec (g vec) (g (g (g (- vec (vector-ref a vec)))))))) (remaining ""))) 
(assert-equal "TMeir T31" (test-string <sexpr> "##f( a[a[a[a[9]]]], cons(x * 5, x ^ x), list(a , a[2]))") '((match (f (vector-ref a (vector-ref a (vector-ref a (vector-ref a 9)))) (cons (* x 5) (expt x x)) (list a (vector-ref a 2)))) (remaining "")))



(assert-equal "TMeir T32" (test-string <sexpr> "(+ 4 5 ## (3 - 5 * 2 - 1 - 5 - 6) ## 6)") '((match (+ 4 5 (- (- (- (- 3 (* 5 2)) 1) 5) 6) 6)) (remaining ""))) 
(assert-equal "TMeir T33" (test-string <sexpr> "(/ ( - 3 5) ## (2 / 5 + 3))") '((match (/ (- 3 5) (+ (/ 2 5) 3))) (remaining ""))) 
(assert-equal "TMeir T34" (test-string <sexpr> "##f(4+5/2-3-4, a[f(##(+ 6 7))])") '((match (f (- (- (+ 4 5/2) 3) 4) (vector-ref a (f (+ 6 7))))) (remaining ""))) 
(assert-equal "TMeir T35" (test-string <sexpr> "(let ((result ##a[0] + 2 * a[1] +   3 ^ a[2] - a[3] * b[i][j][i + j])) result) ") '((match (let ((result (- (+ (+ (vector-ref a 0) (* 2 (vector-ref a 1))) (expt 3 (vector-ref a 2))) (* (vector-ref a 3) (vector-ref (vector-ref (vector-ref b i) j) (+ i j)))))) result)) (remaining ""))) 
(assert-equal "TMeir T36" (test-string <sexpr> "## 2 + #; 3 - 4 8") '((match (+ 2 8)) (remaining ""))) 
(assert-equal "TMeir T37" (test-string <sexpr> "(+ 1 ##2 + 3 a b c)") '((match  (+ 1 (+ 2 3) a b c)) (remaining ""))) 
(assert-equal "TMeir T38" (test-string <sexpr> "(let ((result (* n ##3/4^3 + 2/7^5))) (* result   (f result) ##g(g(g(result, result), result), result)))") '((match (let ((result (* n (+ (expt 3/4 3) (expt 2/7 5))))) (* result (f result) (g (g (g result result) result) result)))) (remaining ""))) 
(assert-equal "TMeir T39" (test-string <sexpr> "(## 1 + (2 + 3)     * 4 + 2 ^ 2 + ( 3 / 4)) ; + 4") '((match ((+ (+ (+ 1 (* (+ 2 3) 4)) (expt 2 2)) (/ 3 4)))) (remaining ""))) 

(assert-equal "TMeir T40" (test-string <sexpr> "(+ ##9 + 4^3 6)") '((match (+ (+ 9 (expt 4 3)) 6)) (remaining ""))) 
(assert-equal "TMeir T41" (test-string <sexpr> "( let ((x 2) (y 8)) + x y		)") '((match (let ((x 2) (y 8)) + x y)) (remaining ""))) 
(assert-equal "TMeir T42" (test-string <sexpr> " \" SHALOM \" ; 4") '((match " SHALOM ") (remaining ""))) 
(assert-equal "PreTMeir T43" (test-string <sexpr> "##FUNC(a#;1+2+3,b,1+5)") '((match (func a b (+ 1 5)))  (remaining ""))) 
(assert-equal "TMeir T43" (test-string <sexpr> "#; #\\lambda ## #; 5^2*-12 1+1/2+FUNC(a#;1+2+3,b,1+5)") '((match  (+ (+ 1 1/2) (func a b (+ 1 5))))  (remaining ""))) 
(assert-equal "TMeir T44" (test-string <sexpr> "#% (1+2) " ) '((match (+ 1 2)) (remaining ""))) 
(assert-equal "TMeir T45" (test-string <sexpr> "##1+2   [3+4]" ) '((match  (+ 1 (vector-ref 2 (+ 3 4)))) (remaining ""))) 
(assert-equal "TMeir T46" (test-string <sexpr> "#\\newline" ) `((match ,(integer->char 10)) (remaining "")))
 
 
 
 
(display "Number of failed tests  ")
(display (unbox failed-tests))