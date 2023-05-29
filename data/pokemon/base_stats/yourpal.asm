db DEX_YOURPAL ; pokedex id
db 80, 80, 80, 80, 80 ; base special
db NORMAL, NORMAL ; species type 2
db 3 ; catch rate
db 110 ; base exp yield
INCBIN "gfx/pokemon/front/yourpal.pic",0,1 ; 55, sprite dimensions
dw YourPalPicFront, YourPalPicBack
; attacks known at lvl 0
db EJACULATE, 0, 0, 0
db 0 ; growth rate
; learnset
	tmhm
db BANK(YourPalPicFront)
assert BANK(YourPalPicFront) == BANK(YourPalPicBack)
