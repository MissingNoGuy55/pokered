db DEX_ELROTH ; pokedex id
db 30, 50, 30, 50, 70 ; base stats
db DARK, DARK ; species type 2
db 60 ; catch rate
db 30 ; base exp yield
INCBIN "gfx/pokemon/front/elroth.pic",0,1 ; 55, sprite dimensions
dw ElrothPicFront, ElrothPicBack
; attacks known at lvl 0
db LEECH_LIFE, 0, 0, 0
db GROWTH_MEDIUM_FAST ; growth rate
; learnset
	tmhm
db BANK(ElrothPicFront)
assert BANK(ElrothPicFront) == BANK(ElrothPicBack)
