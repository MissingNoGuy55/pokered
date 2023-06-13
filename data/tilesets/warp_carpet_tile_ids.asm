MACRO warp_carpet_tiles
	IF _NARG
		db \# ; all args
	ENDC
	db -1 ; end
ENDM

WarpTileListPointers:
	dw .FacingDownWarpTiles
	dw .FacingUpWarpTiles
	dw .FacingLeftWarpTiles
	dw .FacingRightWarpTiles

.FacingDownWarpTiles:
	warp_carpet_tiles $01, $12, $17, $3D, $04, $18, $33

.FacingUpWarpTiles:
	warp_carpet_tiles $01, $5C

.FacingLeftWarpTiles:
	warp_carpet_tiles $1A, $4B

.FacingRightWarpTiles:
	warp_carpet_tiles $0F, $4E
	
WarpTileListPointersJohto:
	dw .FacingDownWarpTilesJohto
	dw .FacingUpWarpTilesJohto
	dw .FacingLeftWarpTilesJohto
	dw .FacingRightWarpTilesJohto

.FacingDownWarpTilesJohto:
	warp_carpet_tiles $01, $12, $17, $3D, $04, $18, $33

.FacingUpWarpTilesJohto:
	warp_carpet_tiles $01, $5C, $40

.FacingLeftWarpTilesJohto:
	warp_carpet_tiles $16, $1C, $40

.FacingRightWarpTilesJohto:
	warp_carpet_tiles $01, $1A, $40
