function room_lobby(object)
	object.menuItems = []
	object.opacity = 150
	object.no_opacity = 255
	object.selected_idx = 0
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
		region1 = CreateObject("roRegion", btn_Audio, 0, 0, audio_w, audio_h)
		region2 = CreateObject("roRegion", btn_Audio, 86, 0, audio_w, audio_h)
		region1.SetPretranslation(- audio_w / 2, - audio_h / 2)
		region2.SetPretranslation(- audio_w / 2, - audio_h / 2)
		m.audio = m.addAnimatedImage("button_Audio", [region1, region2], { offset_x: 1205, offset_y: 80, index: 0 })
		m.audio.status = false
		m.menuItems.Push(m.audio)

		btn_Hint = m.game.getBitmap("but_hint")
		width = btn_Hint.GetWidth()
		height = btn_Hint.GetHeight()
		region = CreateObject("roRegion", btn_Hint, 0, 0, width, height)
		region.SetPretranslation(- width / 2, - height / 2)
		hint = m.addImage("button_Hint", region, { offset_x: 1200, offset_y: 220 })
		m.menuItems.Push(hint)

		btn_Restart = m.game.getBitmap("but_restart")
		width = btn_Restart.GetWidth()
		height = btn_Restart.GetHeight()
		region = CreateObject("roRegion", btn_Restart, 0, 0, width, height)
		region.SetPretranslation(- width / 2, - height / 2)
		restart = m.addImage("button_Restart", region, { offset_x: 1200, offset_y: 350 })
		m.menuItems.Push(restart)

		btn_Shuffle = m.game.getBitmap("but_shuffle")
		width = btn_Shuffle.GetWidth()
		height = btn_Shuffle.GetHeight()
		region = CreateObject("roRegion", btn_Shuffle, 0, 0, width, height)
		region.SetPretranslation(- width / 2, - height / 2)
		shuffle = m.addImage("button_Shuffle", region, { offset_x: 1200, offset_y: 480 })
		m.menuItems.Push(shuffle)

		for i = 0 to m.menuItems.Count() - 1
			m.menuItems[i].alpha = m.opacity
			m.menuItems[i].active = false
		end for

		m.game.createInstance("chips", args)'pass level type with args

	end function

	object.onUpdate = function(dt)

	end function

	object.onDrawBegin = function(canvas)

	end function

	object.onDrawEnd = function(canvas)
		font2 = m.game.getFont("font2_25")

		DrawText(canvas, "SCORE 0", 300, 50, font2, "center", &hFFFFFFFF)
		DrawText(canvas, "TIME 500", 500, 50, font2, "center", &hFFFFFFFF)
	end function

	object.onButton = function(code as integer)
		if code = 10 and m.menuItems[m.selected_idx].active = false then ' Switch to right menu
			m.menuItems[m.selected_idx].alpha = m.no_opacity
			m.menuItems[m.selected_idx].active = true
		else if code = 10 and m.menuItems[m.selected_idx].active = true then
			m.menuItems[m.selected_idx].alpha = m.opacity
			m.menuItems[m.selected_idx].active = false
		end if
		if code = 3 ' Down on right menu
			if m.selected_idx < m.menuItems.Count() and m.menuItems[m.selected_idx].active = true
				m.menuItems[m.selected_idx].alpha = m.opacity
				m.menuItems[m.selected_idx].active = false
				m.selected_idx++
				if m.selected_idx = 4
					m.menuItems[m.selected_idx - 1].alpha = m.opacity
					m.menuItems[m.selected_idx - 1].active = false
					m.menuItems[0].active = true
					m.menuItems[0].alpha = m.no_opacity
					m.selected_idx = 0
				end if
				m.menuItems[m.selected_idx].alpha = m.no_opacity
				m.menuItems[m.selected_idx].active = true
			end if
		end if
		if code = 2 'Up on right menu
			if m.selected_idx = 0 and m.menuItems[m.selected_idx].active = true
				m.menuItems[m.selected_idx].alpha = m.opacity
				m.menuItems[m.selected_idx].active = false
				m.selected_idx = m.menuItems.Count() - 1
				m.menuItems[m.selected_idx].alpha = m.no_opacity
				m.menuItems[m.selected_idx].active = true
			else if m.selected_idx > 0 and m.menuItems[m.selected_idx].active = true
				m.menuItems[m.selected_idx].active = false
				m.menuItems[m.selected_idx].alpha = m.opacity
				m.selected_idx--
				m.menuItems[m.selected_idx].active = true
				m.menuItems[m.selected_idx].alpha = m.no_opacity
			end if
		end if

		if code = 6 ' Click on menu item
			if m.menuItems[m.selected_idx].active = true and m.selected_idx = 0 ' Audio on/off
				if m.audio.status = false
					m.audio.status = true
					m.audio.index = 1
				else
					m.audio.status = false
					m.audio.index = 0
				end if
			end if

			if m.menuItems[m.selected_idx].active = true and m.selected_idx = 3 'Shuffle
					m.menuItems[m.selected_idx].active = false
					m.menuItems[m.selected_idx].alpha = m.opacity
					'Popup Shuffle
					m.game.createInstance("popupShuffle")
			end if
		end if
	end function

	object.onGameEvent = function(event as string, data as object)

	end function

end function