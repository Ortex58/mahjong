function room_lobby(object)
	

	object.onCreate = function(args)
		
		'set z-order
		m.depth = 1

		'Set background for lobby

		bm_bg = m.game.getBitmap("game_bg")
		width = bm_bg.GetWidth()
		height = bm_bg.GetHeight()
		region = CreateObject("roRegion", bm_bg, 0, 0, width, height)
		bg = m.addImage("main", region)
		bg.offset_x = 0
		bg.offset_y = 0


		m.game.createInstance("chips")

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