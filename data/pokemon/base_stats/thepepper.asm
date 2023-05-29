db DEX_THE_PEPPER ; pokedex id
db 150, 20, 20, 40, 90 ; base special
db GRASS, FIRE ; species type 2
db 60 ; catch rate
db 30 ; base exp yield
INCBIN "gfx/pokemon/front/thepepper.pic",0,1 ; 55, sprite dimensions
dw ThePepperPicFront, ThePepperPicBack
; attacks known at lvl 0
db DOUBLESLAP, SPLASH, 0, 0
db 0 ; growth rate
; learnset
	tmhm
db BANK(ThePepperPicFront)
assert BANK(ThePepperPicFront) == BANK(ThePepperPicBack)
