sub Main()
	'Initializes the game engine
	game = new_game(1280, 720, true)

	'load bitmap
	game.loadBitmap("menu_bg", "pkg:/sprites/bg_menu.jpg")
	game.loadBitmap("game_bg", "pkg:/sprites/bg_game.jpg")
	game.loadBitmap("tiles", "pkg:/sprites/tiles.png")
	game.loadBitmap("selection", "pkg:/sprites/selection.png")
	game.loadBitmap("but_play", "pkg:/sprites/but_play.png")
	game.loadBitmap("but_back", "pkg:/sprites/but_no.png")
	game.loadBitmap("level1", "pkg:/sprites/but_level_classic.png")
	game.loadBitmap("level2", "pkg:/sprites/but_level_monument.png")
	game.loadBitmap("level3", "pkg:/sprites/but_level_pyramids.png")
	game.loadBitmap("level4", "pkg:/sprites/but_level_arena.png")
	game.loadBitmap("level5", "pkg:/sprites/but_level_four.png")
	game.loadBitmap("level6", "pkg:/sprites/but_level_thewall.png")

	'Load room
	game.defineRoom("room_lobby", room_lobby)
	game.defineRoom("room_start", room_start)
	game.defineRoom("room_menu", room_menu)
	'Chips
	game.defineObject("chips", obj_chips)

	'Sellect room
	game.changeRoom("room_menu")

	'Start game
	game.Play()

end sub