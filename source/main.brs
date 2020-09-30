sub Main()
	'Initializes the game engine
	game = new_game(1280, 720, true)
	m.game = game
	'load bitmap
	game.loadBitmap("menu_bg", "pkg:/sprites/bg_menu.jpg")
	game.loadBitmap("game_bg", "pkg:/sprites/bg_game.jpg")

	game.loadBitmap("panel_bg", "pkg:/sprites/panel_bg.png")
	game.loadBitmap("but_yes", "pkg:/sprites/but_yes.png")
	game.loadBitmap("but_no", "pkg:/sprites/but_no.png")

	game.loadBitmap("tiles", "pkg:/sprites/tiles.png")
	game.loadBitmap("selection", "pkg:/sprites/selection.png")
	game.loadBitmap("but_audio", "pkg:/sprites/audio_icon.png")
	game.loadBitmap("but_play", "pkg:/sprites/but_play.png")
	game.loadBitmap("but_hint", "pkg:/sprites/but_hint.png")
	game.loadBitmap("but_restart", "pkg:/sprites/but_restart.png")
	game.loadBitmap("but_shuffle", "pkg:/sprites/but_shuffle.png")
	game.loadBitmap("level0", "pkg:/sprites/but_level_classic.png")
	game.loadBitmap("level1", "pkg:/sprites/but_level_monument.png")
	game.loadBitmap("level2", "pkg:/sprites/but_level_pyramids.png")
	game.loadBitmap("level3", "pkg:/sprites/but_level_arena.png")
	game.loadBitmap("level4", "pkg:/sprites/but_level_four.png")
	game.loadBitmap("level5", "pkg:/sprites/but_level_thewall.png")

	'load font
	game.loadFont("font1_60", "TradeGothic LT CondEighteen", 60, false, false)
	game.loadFont("font2_25", "TradeGothic LT CondEighteen", 25, false, false)
	game.loadFont("font3_12", "TradeGothic LT CondEighteen", 12, false, false)

	'Load room
	game.defineRoom("room_lobby", room_lobby)
	game.defineRoom("room_menu", room_menu)
	game.defineRoom("room_start", room_start)
	'Chips
	game.defineObject("chips", obj_chips)
	game.defineObject("tile", tile)

	'Popup
	game.defineObject("popupShuffle", popupShuffle)

	'Sellect room
	game.changeRoom("room_menu")

	'Start game
	game.Play()

end sub

Function IsValid(value As Dynamic) As Boolean
    Return Type(value) <> "<uninitialized>" And value <> invalid
End Function

Function IsArray(value As Dynamic) As Boolean
    Return IsValid(value) And GetInterface(value, "ifArray") <> invalid
End Function

Function IsObject(value As Dynamic) As Boolean
    Return IsValid(value) And GetInterface(value, "ifAssociativeArray") <> invalid
End Function


Function GetConstants() as object
	c = {}
	c.DEBUG = true
	c.TILE_W = 60
	c.TILE_H = 78
	c.TILE_COL_NUM = 9
	c.SELECT_OFF_X = -8
	c.SELECT_OFF_Y = -17
	c.TILES_COUNT = 42

	c.opacity = 150
	c.no_opacity = 255

	c.EVT_CLOSE_POP = "close_popup"

	return c
End Function