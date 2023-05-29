db DEX_SANS ; pokedex id
db 150, 20, 20, 100, 180 ; base special
db NORMAL, PSYCHIC_TYPE ; species type 2
db 3 ; catch rate
db 255 ; base exp yield
INCBIN "gfx/pokemon/front/sans.pic",0,1 ; 55, sprite dimensions
dw SansPicFront, SansPicBack
; attacks known at lvl 0
db TACKLE, 0, 0, 0
db 0 ; growth rate
; learnset
	tmhm
db BANK(SansPicFront)
assert BANK(SansPicFront) == BANK(SansPicBack)
