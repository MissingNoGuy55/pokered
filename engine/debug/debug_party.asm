; This function is a debugging feature to give the player Tsunekazu Ishihara's
; favorite Pokemon. This is indicated by the overpowered Exeggutor, which
; Ishihara (president of Creatures Inc.) said was his favorite Pokemon in an ABC
; interview on February 8, 2000.
; "Exeggutor is my favorite. That's because I was always using this character
; while I was debugging the program."
; http://www.ign.com/articles/2000/02/09/abc-news-pokamon-chat-transcript

FailedText::
	text "Failed to find"
	line "trainer data!@"
	prompt
	
TrainerType::
	text "Trainer is:"
	line "@"
	text_ram wcd6d
	text "!@"
	text_end

SetIshiharaTeam:
	;ld de, IshiharaTeam
	ld de, MissiTeam
.loop
	ld a, [de]
	cp -1
	; jr z, .drawTrainerClass
	ret z
	ld [wcf91], a
	inc de
	ld a, [de]
	ld [wCurEnemyLVL], a
	ld a, $00
	ld [wMonDataLocation], a
	inc de
	call AddPartyMon
	jr .loop	
	
.drawTrainerClass
	; ld a,&4000
	; or a ; Missi: reset carry flag (5/21/2023)
	; sbc a,[hl]
	
	; ld [hl], a
	; call PrintText
	
	ld a, $04
	ld [wd0b5], a
	ld a, TRAINER_NAME
	ld [wNameListType], a
	ld a, BANK(TrainerNames)
	ld [wPredefBank], a
	call GetName
	; ld de, wcd6d
	ld hl, TrainerTypePrompt
	call PrintText
	ld c, 100
	call DelayFrames
	
	ld a, OPP_ID_OFFSET + SAILOR
	ld [wCurOpponent], a
	ld a, SAILOR
	ld [wTrainerClass], a
	
	predef InitOpponent
	
	ret
	
.fail
	ld hl, FailedTextPrompt
	call PrintText
	ret
	
.foundName
	ld de, wTrainerName
	ld bc, $d
	jp CopyData

FailedTextPrompt::
	text_far FailedText
	text_end
	
TrainerTypePrompt::
	text_far TrainerType
	text_end

MissiTeam:
	db HORRIFICE, 100
IF DEF(_DEBUG)
	db MEW, 100
ELSE
	db MEW, 5
ENDC
	db SANS, 100
	db YOURPAL, 100
	db DICCMAN, 100
IF DEF(_DEBUG)
	db POSTAL, 100
ENDC
	db -1 ; end

IshiharaTeam:
	db EXEGGUTOR, 90
IF DEF(_DEBUG)
	db MEW, 5
ELSE
	db MEW, 20
ENDC
	db JOLTEON, 56
	db DUGTRIO, 56
	db ARTICUNO, 57
IF DEF(_DEBUG)
	db PIKACHU, 5
ENDC
	db -1 ; end

; Missi: exported so it can be accessed through init.asm
IF DEF (_DEBUG)
DebugStart::
ELSE
DebugStart:
ENDC
IF DEF(_DEBUG)
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a

	; Fly anywhere.
	dec a ; $ff
	ld [wTownVisitedFlag], a
	ld [wTownVisitedFlag + 1], a

	; Get all badges except Earth Badge.
	ld a, ~(1 << BIT_EARTHBADGE)
	ld [wObtainedBadges], a

	call SetIshiharaTeam

	; Exeggutor gets four HM moves.
	; ld hl, wPartyMon1Moves
	; ld a, FLY
	; ld [hli], a
	; ld a, CUT
	; ld [hli], a
	; ld a, SURF
	; ld [hli], a
	; ld a, STRENGTH
	; ld [hl], a
	; ld hl, wPartyMon1PP
	; ld a, 15
	; ld [hli], a
	; ld a, 30
	; ld [hli], a
	; ld a, 15
	; ld [hli], a
	; ld [hl], a

	; Jolteon gets Thunderbolt.
	ld hl, wPartyMon3Moves + 3
	ld a, THUNDERBOLT
	ld [hl], a
	ld hl, wPartyMon3PP + 3
	ld a, 15
	ld [hl], a

	; Articuno gets Fly.
	ld hl, wPartyMon5Moves
	ld a, FLY
	ld [hl], a
	ld hl, wPartyMon5PP
	ld a, 15
	ld [hl], a

	; Pikachu gets Surf.
	ld hl, wPartyMon6Moves + 2
	ld a, SURF
	ld [hl], a
	ld hl, wPartyMon6PP + 2
	ld a, 15
	ld [hl], a

	; Get some debug items.
	ld hl, wNumBagItems
	ld de, DebugItemsList
.items_loop
	ld a, [de]
	cp -1
	jr z, .items_end
	ld [wcf91], a
	inc de
	ld a, [de]
	inc de
	ld [wItemQuantity], a
	call AddItemToInventory
	jr .items_loop
.items_end

	; Complete the Pokédex.
	ld hl, wPokedexOwned
	call DebugSetPokedexEntries
	ld hl, wPokedexSeen
	call DebugSetPokedexEntries
	SetEvent EVENT_GOT_POKEDEX

	; Rival chose Squirtle,
	; Player chose Charmander.
	ld hl, wRivalStarter
	ld a, STARTER2
	ld [hli], a
	inc hl ; hl = wPlayerStarter
	ld a, STARTER1
	ld [hl], a

	ret

DebugSetPokedexEntries:
	ld b, wPokedexOwnedEnd - wPokedexOwned - 1
	ld a, %11111111
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld [hl], %01111111
	ret

DebugItemsList:
	db BICYCLE, 1
	db FULL_RESTORE, 99
	db FULL_HEAL, 99
	db ESCAPE_ROPE, 99
	db RARE_CANDY, 99
	db MASTER_BALL, 99
	db TOWN_MAP, 1
	db SECRET_KEY, 1
	db CARD_KEY, 1
	db S_S_TICKET, 1
	db LIFT_KEY, 1
	db -1 ; end

DebugUnusedList:
	db -1 ; end
ELSE
	ret
ENDC
