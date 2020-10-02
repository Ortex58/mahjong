function room_start(object)
  object.transdt = 20
  object.trans = false
  object.onCreate = function(args)
    m.game_started = false
    ' set z-order
    m.depth = -1
    'Set background for lobby
    start_bg = m.game.getBitmap("menu_bg")
    width = start_bg.GetWidth()
    height = start_bg.GetHeight()
    region = CreateObject("roRegion", start_bg, 0, 0, width, height)
    bg = m.addImage("main", region)
    bg.offset_x = 0
    bg.offset_y = 0

  end function

  object.onUpdate = function(dt)

  end function

  object.onDrawBegin = function(canvas)

  end function
  'Draw OK image
  object.onDrawEnd = function(canvas)
    
    if m.trans = true
      font2 = m.game.getFont("font2_25")
			DrawText(canvas, "Press OK to Start", canvas.GetWidth()/2, canvas.GetHeight()/2+300, font2, "center", &hFFFFFFFF)
			m.transdt -= 1
			if m.transdt = 0
				m.transdt = 30
				m.trans = false
			end if
		else if m.trans = false
			m.transdt -= 1
			if m.transdt = 0
				m.transdt = 30
				m.trans = true
			end if
		end if
	
  end function

  object.onButton = function(code as integer)

    if code = 0 then ' Back
      m.game.End()
    end if

    if code = 6 OR code = 13 then ' Select
    m.game_started = true
    m.game.changeRoom("room_menu")
    end if
  end function

  object.onGameEvent = function(event as string, data as object)

  end function

end function