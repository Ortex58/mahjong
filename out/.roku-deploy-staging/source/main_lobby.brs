function room_lobby(object)
	' object.x = invalid
	' object.y = invalid
	' object.width = invalid
	' object.height = invalid

	object.onCreate = function(args)
		m.game.createInstance("chips")
		'Set background for lobby
		' m.y = m.game.getCanvas().GetHeight()
		' m.x = m.game.getCanvas().GetWidth()
		' bm_paddle = m.game.getBitmap("game_bg")
		' m.width = bm_paddle.GetWidth()
		' m.height = bm_paddle.GetHeight()
		' region = CreateObject("roRegion", bm_paddle, 0, 0, m.width, m.height)
		' region.SetPretranslation(-m.width-500, -m.height)
		' m.addImage("main", region)

	end function

	object.onUpdate = function(dt)
		
	end function

	object.onDrawBegin = function(canvas)
		
	end function

	object.onButton = function(button)
		
	end function

	object.onGameEvent = function(event as string, data as object)
	
	end function

end function