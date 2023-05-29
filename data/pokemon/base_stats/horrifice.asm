db DEX_HORRIFICE ; pokedex id
db 50, 20, 60, 100, 130 ; base special
db DARK, POISON ; species type 2
db 30 ; catch rate
db 90 ; base exp yield
INCBIN "gfx/pokemon/front/horrifice.pic",0,1 ; 55, sprite dimensions
dw HorrificePicFront, HorrificePicBack
; attacks known at lvl 0
db LEECH_LIFE, 0, 0, 0
db GROWTH_MEDIUM_FAST ; growth rate
; learnset
	tmhm
db BANK(HorrificePicFront)
assert BANK(HorrificePicFront) == BANK(HorrificePicBack)
