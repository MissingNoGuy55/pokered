	db DEX_POSTAL ; pokedex id
	db 50, 80, 50, 50, 50 ; base special
	db NORMAL, NORMAL ; species type 2
	db 60 ; catch rate
	db 30 ; base exp yield
	INCBIN "gfx/pokemon/front/postal.pic",0,1 ; 55, sprite dimensions
	dw PostalPicFront, PostalPicBack
; attacks known at lvl 0
	db TACKLE, SPLASH, 0, 0
	db 0 ; growth rate
; learnset
	tmhm
	db BANK(PostalPicFront)
	assert BANK(PostalPicFront) == BANK(PostalPicBack)
