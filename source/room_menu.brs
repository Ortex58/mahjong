function room_menu(object)

  object.opacity = 150
  object.no_opacity = 255
  object.arrBoards = []

  'Parse JSON and add to num array
  levelsFile = "pkg:/config/config-new.json"
  m.currentConfig = ParseJSON(ReadAsciiFile(levelsFile))
  object.num = m.currentConfig

  object.onCreate = function(args)
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
    c_x = 0
    c_y = 0
    for i = 0 to m.num.[0].["menu_pos"].Count() - 1
      name = "level" + str(i - Int(i / 6) * 6).trim()
      m.addLevel(name, "level" + str(i), c_x + m.num[0].["menu_pos"].[i].x, c_y + m.num[0].["menu_pos"].[i].y)
      m.arrBoards[i].alpha = m.opacity
      m.arrBoards[i].board_difficulty = m.num[i].["difficulty"]
      m.arrBoards[i].board_label = m.num[i].["label"]
      m.arrBoards[i].layout_pos = m.num[i].["layout_pos"]
    end for
    m.arrBoards[0].state = true
    m.arrBoards[0].alpha = m.no_opacity

    
    btn_Audio = m.game.getBitmap("but_audio")
    audio_w = 80
		audio_h = 73
		width = btn_Audio.GetWidth()
		height = btn_Audio.GetHeight()
		region = CreateObject("roRegion", btn_Audio, 0, 0, audio_w, audio_h)
		region.SetPretranslation(- audio_w / 2, - audio_h / 2)
		m.addImage("button_Audio", region, { offset_x: 1200, offset_y: 80})
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
    m.arrBoards.Peek().board_difficulty = ""
    m.arrBoards.Peek().board_label = ""
    m.arrBoards.Peek().layout_pos = ""
  end function

  object.onUpdate = function(dt)

  end function

  object.onDrawBegin = function(canvas)

  end function
  'Draw OK image
  object.onDrawEnd = function(canvas)
    font1 = m.game.getFont("font1_60")
    font2 = m.game.getFont("font2_25")

    DrawText(canvas, "SELECT A LEVEL", canvas.GetWidth() / 2, canvas.GetHeight() - 670, font1, "center", &hFFFFFFFF)

    DrawText(canvas, m.arrBoards[0].board_difficulty, 400, 213, font2, "center", &hFFFFFFFF)
    DrawText(canvas, m.arrBoards[1].board_difficulty, 630, 213, font2, "center", &hFFFFFFFF)
    DrawText(canvas, m.arrBoards[2].board_difficulty, 860, 213, font2, "center", &hFFFFFFFF)
    DrawText(canvas, m.arrBoards[3].board_difficulty, 400, 447, font2, "center", &hFFFFFFFF)
    DrawText(canvas, m.arrBoards[4].board_difficulty, 630, 447, font2, "center", &hFFFFFFFF)
    DrawText(canvas, m.arrBoards[5].board_difficulty, 860, 447, font2, "center", &hFFFFFFFF)

    DrawText(canvas, m.arrBoards[0].board_label, 400, 355, font2, "center", &hFFFFFFFF)
    DrawText(canvas, m.arrBoards[1].board_label, 630, 355, font2, "center", &hFFFFFFFF)
    DrawText(canvas, m.arrBoards[2].board_label, 860, 355, font2, "center", &hFFFFFFFF)
    DrawText(canvas, m.arrBoards[3].board_label, 400, 590, font2, "center", &hFFFFFFFF)
    DrawText(canvas, m.arrBoards[4].board_label, 630, 590, font2, "center", &hFFFFFFFF)
    DrawText(canvas, m.arrBoards[5].board_label, 860, 590, font2, "center", &hFFFFFFFF)
  end function

  object.onButton = function(code as integer)
    'Select
    if code = 6 then
      m.game.changeRoom("room_lobby")
    end if

    if code = 5 ' Right
      for i = 0 to m.arrBoards.Count() - 1
        if m.arrBoards[i].state = true
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i++
          if m.arrBoards.Count() = i
            m.arrBoards[0].state = true
            m.arrBoards[0].alpha = m.no_opacity
          else
            m.arrBoards[i].state = true
            m.arrBoards[i].alpha = m.no_opacity
          end if
        end if
      end for
    end if

    if code = 4 ' Left
      for i = 0 to m.arrBoards.Count() - 1
        if m.arrBoards[i].state = true and i <> 0
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i--
          if m.arrBoards.Count() = i
            m.arrBoards[0].state = true
            m.arrBoards[0].alpha = m.no_opacity
          else
            m.arrBoards[i].state = true
            m.arrBoards[i].alpha = m.no_opacity
          end if
        end if
      end for
    end if

    if code = 3 ' Down
      for i = 0 to m.arrBoards.Count() - 1
        if m.arrBoards[i].state = true and i = 0
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 3
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        else if m.arrBoards[i].state = true and i = 1
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 4
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        else if m.arrBoards[i].state = true and i = 2
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 5
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        else if m.arrBoards[i].state = true and i = 3
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 0
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        else if m.arrBoards[i].state = true and i = 4
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 1
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        else if m.arrBoards[i].state = true and i = 5
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 2
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        end if
      end for
    end if

    if code = 2 ' Up
      for i = 0 to m.arrBoards.Count() - 1
        if m.arrBoards[i].state = true and i = 0
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 3
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        else if m.arrBoards[i].state = true and i = 1
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 4
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        else if m.arrBoards[i].state = true and i = 2
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 5
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        else if m.arrBoards[i].state = true and i = 3
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 0
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        else if m.arrBoards[i].state = true and i = 4
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 1
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        else if m.arrBoards[i].state = true and i = 5
          m.arrBoards[i].state = false
          m.arrBoards[i].alpha = m.opacity
          i = 2
          m.arrBoards[i].state = true
          m.arrBoards[i].alpha = m.no_opacity
        end if
      end for
    end if
    'Back
    if code = 0 then ' Back
      m.game.End()
    end if
  end function

  object.onGameEvent = function(event as string, data as object)

  end function

end function