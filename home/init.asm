SoftReset::
	call StopAllSounds
	call GBPalWhiteOut
	ld c, 32
	call DelayFrames
	; fallthrough

TestPlayerName: db "PLAYER@"
TestRivalName: db "RIVAL@"

Init::
;  Program init.

DEF rLCDC_DEFAULT EQU %11100011
; * LCD enabled
; * Window tile map at $9C00
; * Window display enabled
; * BG and window tile data at $8800
; * BG tile map at $9800
; * 8x8 OBJ size
; * OBJ display enabled
; * BG display enabled

	di

	xor a
	ldh [rIF], a
	ldh [rIE], a
	ldh [rSCX], a
	ldh [rSCY], a
	ldh [rSB], a
	ldh [rSC], a
	ldh [rWX], a
	ldh [rWY], a
	ldh [rTMA], a
	ldh [rTAC], a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a

	ld a, rLCDC_ENABLE_MASK
	ldh [rLCDC], a
	call DisableLCD

	ld sp, wStack

	ld hl, WRAM0_Begin
	ld bc, WRAM1_End - WRAM0_Begin
.loop
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jp nz, .loop

	call ClearVram

	ld hl, HRAM_Begin
	ld bc, HRAM_End - HRAM_Begin
	call FillMemory

	call ClearSprites

	ld a, BANK(WriteDMACodeToHRAM)
	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a
	call WriteDMACodeToHRAM

	xor a
	ldh [hTileAnimations], a
	ldh [rSTAT], a
	ldh [hSCX], a
	ldh [hSCY], a
	ldh [rIF], a
	ld a, 1 << VBLANK + 1 << TIMER + 1 << SERIAL
	ldh [rIE], a

	ld a, 144 ; move the window off-screen
	ldh [hWY], a
	ldh [rWY], a
	ld a, 7
	ldh [rWX], a

	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a

	ld h, HIGH(vBGMap0)
	call ClearBgMap
	ld h, HIGH(vBGMap1)
	call ClearBgMap

	ld a, rLCDC_DEFAULT
	ldh [rLCDC], a
	ld a, 16
	ldh [hSoftReset], a
	call StopAllSounds

	ei

	predef LoadSGB

	ld a, BANK(SFX_Shooting_Star)
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	ld a, $9c
	ldh [hAutoBGTransferDest + 1], a
	xor a
	ldh [hAutoBGTransferDest], a
	dec a
	ld [wUpdateSpritesEnabled], a

; Missi: skip intro in debug mode
IF DEF (_DEBUG)
ELSE
	predef PlayIntro
ENDC	
	
	call DisableLCD
	call ClearVram
	call GBPalNormal
	call ClearSprites
	ld a, rLCDC_DEFAULT
	ldh [rLCDC], a

; Missi: immediately jump into a map after game init
IF DEF (_DEBUG)
	call LoadFontTilePatterns
	call LoadHpBarAndStatusTilePatterns
	call ClearSprites
	call RunDefaultPaletteCommand
	
	call EnableLCD
	call RunPaletteCommand
	call GBPalNormal
	
	; Missi: attempt to load a save
	predef LoadSAV
	
	ld hl, wd732
	; set 2, [hl] ; Missi: needed to make this work. marks this warp as fly or dungeon warp
	set 1, [hl] ; Missi: set the debug bit
	
	; Check save file
	ld a, [wSaveFileStatus]
	cp 1
	jr z, .noSaveFile
	
	jr .warpInSaveFile

.noSaveFile
	; Missi: set player and rival names. these are stored far away for space reasons
	ld hl, TestPlayerName
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	call CopyData
	
	ld hl, TestRivalName
	ld de, wRivalName
	ld bc, NAME_LENGTH
	call CopyData
	
	predef InitPlayerData2
	
	call DebugStart
	
	; Missi: do not try to add mons here, this is before everything gets initialized, so it just freezes

	; Missi: fallthrough
.warpIn
	call SpecialWarpIn
	jp SpecialEnterMap
	
.warpInSaveFile
	jp SpecialEnterMap
	
	; Missi: trying to add mons here too will just not work due to not everything being initialized
	
ELSE
	jp PrepareTitleScreen
ENDC
	
ClearVram::
	ld hl, VRAM_Begin
	ld bc, VRAM_End - VRAM_Begin
	xor a
	jp FillMemory


StopAllSounds::
	ld a, BANK("Audio Engine 1")
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	xor a
	ld [wAudioFadeOutControl], a
	ld [wNewSoundID], a
	ld [wLastMusicSoundID], a
	dec a
	jp PlaySound
