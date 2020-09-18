function room_start(object)


  object.onCreate = function(args)
    m.game_started = false
    'set z-order
    m.depth = 1
    'Set background for lobby
    start_bg = m.game.getBitmap("menu_bg")
    width = start_bg.GetWidth()
    height = start_bg.GetHeight()
    region = CreateObject("roRegion", start_bg, 0, 0, width, height)
    bg = m.addImage("main", region)
    bg.offset_x = 0
    bg.offset_y = 0

    btn_Play = m.game.getBitmap("but_play")
    width = btn_Play.GetWidth()
    height = btn_Play.GetHeight()
    region = CreateObject("roRegion", btn_Play, 0, 0, width, height)
    region.SetPretranslation(- width / 2, - height / 2)
    m.addImage("button_Play", region, { offset_x: 1280 / 2, offset_y: 550 })
    
  end function

  object.onUpdate = function(dt)

  end function

  object.onDrawBegin = function(canvas)

  end function
  'Draw OK image
  object.onDrawEnd = function(canvas)
    
  end function

  object.onButton = function(code as integer)

    if code = 0 then ' Back
      m.game.End()
    end if

    if code = 6 OR code = 13 then ' Select
      m.game.changeRoom("room_menu")
      m.game_started = true
    end if
  end function

  object.onGameEvent = function(event as string, data as object)

  end function

end function