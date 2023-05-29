DebugMenuTitleText:
	db	"DEBUG MENU@"
	
DebugMenuBattleTestText:
	db	"BATTLE TEST@"
	
DebugMenuItemTestText:
	db	"ITEM TEST@"
	
DebugMenuSoundTestText:
	db	"SOUND TEST@"

DisplayDebugMenu:
	hlcoord 0, 0
	ld b, 1
	ld c, 18	; was 18
	call TextBoxBorder
	hlcoord 0, 3	; was 0, 5
	ld b, 13
	ld c, 18	; was 18
	call TextBoxBorder
	; hlcoord 0, 10
	; ld b, 3
	; ld c, 18
	; call TextBoxBorder
	hlcoord 5, 1
	ld de, DebugMenuTitleText
	call PlaceString
	hlcoord 2, 5
	ld de, DebugMenuBattleTestText
	call PlaceString
	hlcoord 2, 6
	ld de, DebugMenuItemTestText
	call PlaceString
	hlcoord 2, 7
	ld de, DebugMenuSoundTestText
	call PlaceString
	; hlcoord 1, 11
	; ld de, BattleStyleOptionText
	; call PlaceString
	hlcoord 2, 16
	ld de, OptionMenuCancelText
	call PlaceString
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	inc a
	ld [wLetterPrintingDelayFlags], a
	ld [wOptionsCancelCursorX], a
	ld a, 5 ; text speed cursor Y coordinate
	ld [wTopMenuItemY], a
	call SetCursorPositionsFromOptions
	ld a, 1
	ld [wOptionsTextSpeedCursorX], a
	ld a, [wOptionsTextSpeedCursorX] ; text speed cursor X coordinate
	ld [wTopMenuItemX], a
	ld a, $01
	ldh [hAutoBGTransferEnabled], a ; enable auto background transfer
	call Delay3
.loop
	call PlaceMenuCursor
.getJoypadStateLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	and A_BUTTON | B_BUTTON | START | D_RIGHT | D_LEFT | D_UP | D_DOWN ; any key besides select pressed?
	jr z, .getJoypadStateLoop
	bit BIT_B_BUTTON, b
	jr nz, .exitMenu
	bit BIT_START, b
	jr nz, .exitMenu
	bit BIT_A_BUTTON, b
	jr z, .checkDirectionKeys
	ld a, [wTopMenuItemY]
	cp 7 ; Missi: cursor on Battle Test?
	jr z, .soundTest
	cp 8 ; Missi: cursor on Item Test?
	jr z, .loop
	cp 9 ; Missi: cursor on Sound Test?
	jr z, .loop
	cp 16 ; is the cursor on Cancel?
	jr nz, .loop
.exitMenu
	ld a, SFX_PRESS_AB
	call PlaySound
	ret
.eraseOldMenuCursor
	ld [wTopMenuItemX], a
	call EraseMenuCursor
	jp .loop
.checkDirectionKeys
	ld a, [wTopMenuItemY]
	bit BIT_D_DOWN, b
	jr nz, .downPressed
	bit BIT_D_UP, b
	jr nz, .upPressed
	cp 5 ; Missi: cursor on Battle Test option?
	jr z, .loop
	cp 6 ; Missi: cursor on Item Test option?
	jr z, .loop
	cp 7 ; Missi: cursor on Sound Test option?
	jr z, .loop
	cp 16 ; cursor on Cancel?
	jr z, .loop
	
.downPressed
	cp 16
	ld b, -11	; Missi: amount to jump the cursor by, if we're at the CANCEL option and press down
	ld hl, wOptionsTextSpeedCursorX
	jr z, .updateMenuVariables
	ld b, 9		; Missi: amount to jump the cursor by, if we're at the last possible option
	cp 7		; Missi: are we at the last possible menu option barring CANCEL?
	inc hl
	jr z, .updateMenuVariables
	cp 1
	inc hl
	jr z, .updateMenuVariables
	ld b, 1
	inc hl
	jr .updateMenuVariables
.upPressed
	cp 5
	ld b, -1
	ld hl, wOptionsTextSpeedCursorX
	jr z, .updateMenuVariables
	cp 6
	inc hl
	jr z, .updateMenuVariables
	cp 16
	ld b, -9
	inc hl
	jr z, .updateMenuVariables
	ld b, 12
	inc hl
.updateMenuVariables
	add b
	ld [wTopMenuItemY], a
	ld a, [hl]
	ld [wTopMenuItemX], a
	call PlaceUnfilledArrowMenuCursor
	ld [hl], " "
	jp .loop
.soundTest
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	jp ShowSoundTestMenu
	
DebugMenuSoundTestOptions:
	db "PALLET TOWN"
	next "VIRIDIAN CITY"
	next "PEWTER CITY@"
	
ShowSoundTestMenu::
	hlcoord 0, 0
	ld b, 1
	ld c, 18	; was 18
	call TextBoxBorder
	hlcoord 0, 3	; was 0, 5
	ld b, 13
	ld c, 18	; was 18
	call TextBoxBorder
	hlcoord 5, 1
	ld de, DebugMenuSoundTestText
	call PlaceString
	hlcoord 2, 5
	ld de, DebugMenuSoundTestOptions
	call PlaceString
	hlcoord 2, 16
	ld de, OptionMenuCancelText
	call PlaceString
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	inc a
	ld [wLetterPrintingDelayFlags], a
	ld [wOptionsCancelCursorX], a
	ld a, 5 ; text speed cursor Y coordinate
	ld [wTopMenuItemY], a
	call SetCursorPositionsFromOptions
	ld a, 1
	ld [wOptionsTextSpeedCursorX], a
	ld a, [wOptionsTextSpeedCursorX] ; text speed cursor X coordinate
	ld [wTopMenuItemX], a
	ld a, $01
	ldh [hAutoBGTransferEnabled], a ; enable auto background transfer
	call Delay3
.loop
	call PlaceMenuCursor
.getJoypadStateLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	and A_BUTTON | B_BUTTON | START | D_RIGHT | D_LEFT | D_UP | D_DOWN ; any key besides select pressed?
	jr z, .getJoypadStateLoop
	bit BIT_B_BUTTON, b
	jr nz, .exitMenu
	bit BIT_START, b
	jr nz, .exitMenu
	bit BIT_A_BUTTON, b
	jr z, .checkDirectionKeys
	ld a, [wTopMenuItemY]
	cp 5 ; Missi: cursor on Battle Test?
	jr z, .playMusic
	cp 6 ; Missi: cursor on Battle Test?
	jr z, .playMusic
	cp 7 ; Missi: cursor on Battle Test?
	jr z, .playMusic
	cp 16 ; is the cursor on Cancel?
	jr nz, .loop
.exitMenu
	ld a, SFX_PRESS_AB
	call PlaySound
	ret
.eraseOldMenuCursor
	ld [wTopMenuItemX], a
	call EraseMenuCursor
	jp .loop
.checkDirectionKeys
	ld a, [wTopMenuItemY]
	bit BIT_D_DOWN, b
	jr nz, .downPressed
	bit BIT_D_UP, b
	jr nz, .upPressed
	cp 7 ; Missi: cursor on Battle Test option?
	jr z, .loop
	cp 8 ; Missi: cursor on Item Test option?
	jr z, .loop
	cp 9 ; Missi: cursor on Sound Test option?
	jr z, .loop
	cp 16 ; cursor on Cancel?
	jr z, .loop
	
.downPressed
	cp 16
	ld b, -11	; Missi: amount to jump the cursor by, if we're at the CANCEL option and press down
	ld hl, wOptionsTextSpeedCursorX
	jr z, .updateMenuVariables
	ld b, 9		; Missi: amount to jump the cursor by, if we're at the last possible option
	cp 7		; Missi: are we at the last possible menu option barring CANCEL?
	inc hl
	jr z, .updateMenuVariables
	cp 1
	inc hl
	jr z, .updateMenuVariables
	ld b, 2
	inc hl
	jr .updateMenuVariables
.upPressed
	cp 5
	ld b, -2
	ld hl, wOptionsTextSpeedCursorX
	jr z, .updateMenuVariables
	cp 6
	inc hl
	jr z, .updateMenuVariables
	cp 16
	ld b, -9
	inc hl
	jr z, .updateMenuVariables
	ld b, 12
	inc hl
.updateMenuVariables
	add b
	ld [wTopMenuItemY], a
	ld a, [hl]
	ld [wTopMenuItemX], a
	call PlaceUnfilledArrowMenuCursor
	ld [hl], " "
	jp .loop
.playMusic
	ld c, BANK(Music_PalletTown)
	ld a, MUSIC_PALLET_TOWN
	ld [wNewSoundID], a
	call PlayMusic
	jp .loop
