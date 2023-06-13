db DEX_ULTRA ; pokedex id
db 50, 20, 60, 100, 130 ; base special
db DARK, ELECTRIC ; species type 2
db 10 ; catch rate
db 120 ; base exp yield
INCBIN "gfx/pokemon/front/ultra.pic",0,1 ; 55, sprite dimensions
dw UltraPicFront, UltraPicBack
; attacks known at lvl 0
db LEECH_LIFE, 0, 0, 0
db GROWTH_MEDIUM_FAST ; growth rate
; learnset
	tmhm
db BANK(UltraPicFront)
assert BANK(UltraPicFront) == BANK(UltraPicBack)
