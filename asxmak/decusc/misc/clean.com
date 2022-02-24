set error none
del/noq *.bak
del/noq *.lst
del/noq *.s
del/noq *.tm1
del/noq *.tm2
del/noq *.tmp
del/noq *.obj
del/noq *.sav
set error error
