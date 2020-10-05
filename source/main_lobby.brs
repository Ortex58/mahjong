function room_lobby(object)
	object.const = GetConstants()
	object.menuItems = []
	object.menuActive = false
	object.blockInput = false
	object.selected_idx = 0
	object.gameManager = invalid
	m.main_music_theme = invalid
	object.const = GetConstants()

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
		if m.game.audio.status = true
			audio_index = 0
		else audio_index = 1
		end if
		m.game.audio = m.addAnimatedImage("button_Audio", [region1, region2], { index: audio_index
      offset_x: 1205,
    offset_y: 80 })
		m.audio = m.game.audio
		m.audio.status = m.game.audio.status
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
			m.menuItems[i].alpha = m.const.opacity
		end for

		m.gameManager = m.game.createInstance("chips", args)'pass level type with args
		m.game_timer = CreateObject_GameTimeSpan()
		m.game_timer.Mark()
	end function

	object.onUpdate = function(dt)

	end function

	object.onDrawBegin = function(canvas)

	end function
	object.onDrawEnd = function(canvas)
		font2 = m.game.getFont("font2_25")
		score = m.gameManager.score
		DrawText(canvas, "SCORE " + str(score), 300, 50, font2, "center", &hFFFFFFFF)
		seconds = m.game_timer.TotalSeconds()
		minutes = seconds \ 60
		hour = minutes \ 3600
		minutes = minutes - (hour * 60)
		seconds = seconds - (minutes * 60)
		if seconds < 10
			seconds = "0" + str(seconds).trim()
		else
			seconds = str(seconds).trim()
		end if
		if minutes < 10
			minutes = "0" + str(minutes).trim()
		else
			minutes = str(minutes).trim()
		end if
		DrawText(canvas, "TIME " + "0" + str(hour).trim() + ":" + minutes + ":" + seconds, 500, 50, font2, "center", &hFFFFFFFF)

	end function

	object.onButton = function(code as integer)
		if m.blockInput then return 0

		if code = 10 and not m.menuActive then ' Switch to right menu
			m.menuItems[m.selected_idx].alpha = m.const.no_opacity
			m.menuActive = true
		else if code = 10 and m.menuActive then
			m.menuItems[m.selected_idx].alpha = m.const.opacity
			m.menuActive = false
		end if
		if code = 3 ' Down on right menu
			if m.menuActive
				m.menuItems[m.selected_idx].alpha = m.const.opacity
				m.selected_idx++
				m.selected_idx = m.selected_idx MOD m.menuItems.Count()
				m.menuItems[m.selected_idx].alpha = m.const.no_opacity
				m.onSoundLobyMenu("tab", 100)
			end if
		end if
		if code = 2 'Up on right menu
			if m.menuActive
				m.menuItems[m.selected_idx].alpha = m.const.opacity
				m.selected_idx--
				if m.selected_idx < 0
					m.selected_idx = m.menuItems.Count() - 1
				else
					m.selected_idx = m.selected_idx MOD m.menuItems.Count()
				end if
				m.menuItems[m.selected_idx].alpha = m.const.no_opacity
				m.onSoundLobyMenu("tab", 100)
			end if
		end if

		if code = 6 ' Click on menu item

			if m.menuActive and m.selected_idx = 3 'Shuffle
				'Popup Shuffle
				m.blockInput = true
				m.game.createInstance("popupShuffle")
				m.onSoundLobyMenu("click", 100)
			end if

			if m.menuActive and m.selected_idx = 2 'Restart
				'Popup Restart
				m.blockInput = true
				m.game.createInstance("popupRestart")
				m.onSoundLobyMenu("click", 100)
			end if

			if m.menuActive and m.selected_idx = 1 'Hint
				arrHint = m.gameManager.showHint()
				m.onSoundLobyMenu("click", 100)
			end if

			if m.menuActive and m.selected_idx = 0 'Sound
				if m.game.audio.status = false
					m.game.audio.status = true
					m.game.playSound("click", 100)
					m.main_music_theme = m.game.musicResume()
					m.audio.index = 0
				else
					m.game.audio.status = false
					m.main_music_theme = m.game.musicPause()
					m.audio.index = 1
				end if
			end if
		end if
		
		if code = 0 then
			m.game.audio.status = false
			m.main_music_theme = m.game.musicStop()
			m.game.changeRoom("room_menu")
		end if
	end function

	object.onGameEvent = function(event as string, data as object)
		if event = m.const.EVT_CLOSE_POP then m.blockInput = false

		if event = m.const.EVT_SHUFFLE_OK then m.gameManager.shuffle()

		if event = m.const.EVT_RESTART_OK then m.gameManager.resetField()

		'TODO resetField()
	end function

	object.onSoundLobyMenu = function(sound as string, volume as integer)
		if m.game.audio.status = true
			m.game.playSound(sound, volume)
		end if
	end function

end function