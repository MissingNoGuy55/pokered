db DEX_DICCMAN ; pokedex id
db 80, 140, 40, 90, 20 ; base special
db NORMAL, ROCK ; species type 2
db 60 ; catch rate
db 170 ; base exp yield
INCBIN "gfx/pokemon/front/diccman.pic",0,1 ; 55, sprite dimensions
dw DiccmanPicFront, DiccmanPicBack
; attacks known at lvl 0
db EJACULATE, 0, 0, 0
db 0 ; growth rate
; learnset
	tmhm
db BANK(DiccmanPicFront)
assert BANK(DiccmanPicFront) == BANK(DiccmanPicBack)
