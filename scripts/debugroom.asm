DebugRoom_Script:
	call EnableAutoTextBoxDrawing
	ld hl, DebugRoomTrainerHeaders
	ld de, DebugRoom_ScriptPointers
	ld a, [wDebugRoomCurScript]
	call ExecuteCurMapScriptInTable
	ld [wDebugRoomCurScript], a
	ret

DebugRoom_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

DebugRoom_TextPointers:
	dw DebugRoomText1
	dw DebugRoomText2
	dw PickUpItemText	; Missi: this has to be defined for as many items as there are in the map
	dw PickUpItemText	; quality programming, courtesy of game freak

DebugRoomTrainerHeaders:
	def_trainers 2
DebugRoomTrainerHeader0:
	trainer EVENT_BEAT_DEBUGROOM_TRAINER_0, 2, DebugRoomBattleText1, DebugRoomEndBattleText1, DebugRoomAfterBattleText1
DebugRoomTrainerHeader1:
	trainer EVENT_BEAT_DEBUGROOM_TRAINER_1, 2, DebugRoomBattleText2, DebugRoomEndBattleText2, DebugRoomAfterBattleText2
	db -1
	
DebugRoomText1:
	text_asm
	ld hl, DebugRoomTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd
	
DebugRoomText2:
	text_asm
	ld hl, DebugRoomTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

DebugRoomBattleText1:
	text_far _DebugRoomBattleText1
	text_end

DebugRoomEndBattleText1:
	text_far _DebugRoomEndBattleText1
	text_end

DebugRoomAfterBattleText1:
	text_far _DebugRoomAfterBattleText1
	text_end
	
DebugRoomBattleText2:
	text_far _DebugRoomBattleText2
	text_end

DebugRoomEndBattleText2:
	text_far _DebugRoomEndBattleText2
	text_end

DebugRoomAfterBattleText2:
	text_far _DebugRoomAfterBattleText2
	text_end
