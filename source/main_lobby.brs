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


		btn_Hint = m.game.getBitmap("but_hint")
		width = btn_Hint.GetWidth()
		height = btn_Hint.GetHeight()
		region = CreateObject("roRegion", btn_Hint, 0, 0, width, height)
		region.SetPretranslation(- width / 2, - height / 2)
		m.addImage("button_Hint", region, { offset_x: 1200, offset_y: 120 })
		
		btn_Restart = m.game.getBitmap("but_restart")
		width = btn_Restart.GetWidth()
		height = btn_Restart.GetHeight()
		region = CreateObject("roRegion", btn_Restart, 0, 0, width, height)
		region.SetPretranslation(- width / 2, - height / 2)
		m.addImage("button_Restart", region, { offset_x: 1200, offset_y: 250 })
		
		btn_Shuffle = m.game.getBitmap("but_shuffle")
		width = btn_Shuffle.GetWidth()
		height = btn_Shuffle.GetHeight()
		region = CreateObject("roRegion", btn_Shuffle, 0, 0, width, height)
		region.SetPretranslation(- width / 2, - height / 2)
		m.addImage("button_Shuffle", region, { offset_x: 1200, offset_y: 380 })

		
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