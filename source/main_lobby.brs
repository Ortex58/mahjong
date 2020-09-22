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
		
		'Audio Icon
		btn_Audio = m.game.getBitmap("but_audio")
    	audio_w = 80
		audio_h = 73
		width = btn_Audio.GetWidth()
		height = btn_Audio.GetHeight()
		region = CreateObject("roRegion", btn_Audio, 0, 0, audio_w, audio_h)
		region.SetPretranslation(- audio_w / 2, - audio_h / 2)
		m.addImage("button_Audio", region, { offset_x: 1195, offset_y: 80})

		btn_Hint = m.game.getBitmap("but_hint")
		width = btn_Hint.GetWidth()
		height = btn_Hint.GetHeight()
		region = CreateObject("roRegion", btn_Hint, 0, 0, width, height)
		region.SetPretranslation(- width / 2, - height / 2)
		m.addImage("button_Hint", region, { offset_x: 1200, offset_y: 220 })
		
		btn_Restart = m.game.getBitmap("but_restart")
		width = btn_Restart.GetWidth()
		height = btn_Restart.GetHeight()
		region = CreateObject("roRegion", btn_Restart, 0, 0, width, height)
		region.SetPretranslation(- width / 2, - height / 2)
		m.addImage("button_Restart", region, { offset_x: 1200, offset_y: 350 })
		
		btn_Shuffle = m.game.getBitmap("but_shuffle")
		width = btn_Shuffle.GetWidth()
		height = btn_Shuffle.GetHeight()
		region = CreateObject("roRegion", btn_Shuffle, 0, 0, width, height)
		region.SetPretranslation(- width / 2, - height / 2)
		m.addImage("button_Shuffle", region, { offset_x: 1200, offset_y: 480 })

		
		m.game.createInstance("chips")

	end function

	object.onUpdate = function(dt)
		
	end function

	object.onDrawBegin = function(canvas)
		
	end function

	object.onDrawEnd = function(canvas)
		font2 = m.game.getFont("font2_25")

		DrawText(canvas, "SCORE 0", 200, 20, font2, "center", &hFFFFFFFF)
		DrawText(canvas, "TIME 500", 400, 20, font2, "center", &hFFFFFFFF)
	end function

	object.onButton = function(button)
		
	end function

	object.onGameEvent = function(event as string, data as object)
	
	end function

end function