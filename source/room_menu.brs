function room_menu(object)

  object.arrBoards = []

  object.onCreate = function(args)
    m.game_started = false
    'set z-order
    m.depth = 1
    'Set background for lobby
    menu_bg = m.game.getBitmap("game_bg")
    width = menu_bg.GetWidth()
    height = menu_bg.GetHeight()
    region = CreateObject("roRegion", menu_bg, 0, 0, width, height)
    bg = m.addImage("main", region)
    bg.offset_x = 0
    bg.offset_y = 0

    ' Add arr of images to arrImage array
    
    for i = 1 to 3
      c_x = 300
		  c_y = 250
			'name = "level" + str(i - Int(i / 6) * 6).trim()
			m.addLevel("level" + str(i).trim(), "level" + str(i), c_x + 250, c_y)
    end for

  end function

  'Function create a boards level
	object.addLevel = function(bm_key, img_key, px, py)
    bm_chip = m.game.getBitmap(bm_key)
    region = CreateObject("roRegion", bm_chip, 0, 0, bm_chip.GetWidth(), bm_chip.GetHeight())

    'make offset for chip coordinate center (anchor point)
    region.SetPretranslation(- bm_chip.GetWidth() / 2, - bm_chip.GetHeight() / 2)

    img = m.addImage(img_key + "_img", region, { offset_x: px, offset_y: py })

    m.arrBoards.Push(img)
    m.arrBoards.Peek().state = false
	end function

  object.onUpdate = function(dt)

  end function

  object.onDrawBegin = function(canvas)
    if m.game_started = false
      btn_Back = m.game.getBitmap("but_back")
      width = btn_Back.GetWidth()
      height = btn_Back.GetHeight()
      region = CreateObject("roRegion", btn_Back, 0, 0, width, height)
      region.SetPretranslation(- width / 2, - height / 2)
      m.addImage("button_Play", region, { offset_x: 1200, offset_y: 80 })
      
      ' level_classic = m.game.getBitmap("level_classic")
      ' l_width = level_classic.GetWidth()
      ' l_height = level_classic.GetHeight()
      ' region = CreateObject("roRegion", level_classic, 0, 0, l_width, l_height)
      ' region.SetPretranslation(- l_width / 2, - l_height / 2)
      ' m.addImage("level_clc", region, { offset_x: 1200 / 2, offset_y: 80 })
      
    end if
  end function
  'Draw OK image
  object.onDrawEnd = function(canvas)
    DrawText(canvas, "SELECT A LEVEL", canvas.GetWidth()/2, canvas.GetHeight()-670, m.game.getFont("default"), "center")
  end function

  object.onButton = function(code as integer)

    if code = 0 then ' Back
      m.game.changeRoom("room_start")
    end if

    if code = 6 then ' Select
      m.game.changeRoom("room_menu")
      m.game_started = true
    end if
  end function

  object.onGameEvent = function(event as string, data as object)

  end function

end function