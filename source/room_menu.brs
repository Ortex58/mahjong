function room_menu(object)

  object.opacity = 150
  object.no_opacity = 255
  object.arrBoards = []
  object.countBoard = 0
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
    m.addImage("button_Audio", region, { offset_x: 1200, offset_y: 80 })
  end function

  'Function create a boards level
  object.addLevel = function(bm_key, img_key, px, py)
    bm_chip = m.game.getBitmap(bm_key)
    region = CreateObject("roRegion", bm_chip, 0, 0, bm_chip.GetWidth(), bm_chip.GetHeight())
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

    x_b = 400
    y_b = 213
    y_l = 355
    for i = 0 to m.arrBoards.Count() - 1
      DrawText(canvas, m.arrBoards[i].board_difficulty, x_b, y_b, font2, "center", &hFFFFFFFF)
      DrawText(canvas, m.arrBoards[i].board_label, x_b, y_l, font2, "center", &hFFFFFFFF)
      x_b += 230
      if i = 2
        x_b = 400
        y_b = 447
        y_l = 590
      end if
    end for
  end function

  object.onButton = function(code as integer)
    'Select
    if code = 6 then
      m.game.changeRoom("room_lobby")
    end if

    
    if code = 5 ' Right
      if m.arrBoards.[m.countBoard].state = true
        m.arrBoards[m.countBoard].state = false
        m.arrBoards[m.countBoard].alpha = m.opacity
        m.countBoard++
        if m.arrBoards.Count() = m.countBoard 
          m.arrBoards[0].state = true
          m.arrBoards[0].alpha = m.no_opacity
          m.countBoard = 0
        end if
        m.arrBoards[m.countBoard].state = true
        m.arrBoards[m.countBoard].alpha = m.no_opacity
      end if
    end if

    if code = 4 ' Left
      if m.arrBoards[m.countBoard].state = true AND m.countBoard = 0
        m.countBoard = m.arrBoards.Count() - 1
        m.arrBoards[0].state = false
        m.arrBoards[0].alpha = m.opacity
        m.countBoard = m.arrBoards.Count() - 1
        m.arrBoards[m.countBoard].state = true
        m.arrBoards[m.countBoard].alpha = m.no_opacity
      else if m.countBoard > 0 AND m.arrBoards[m.countBoard].state = true
        m.arrBoards[m.countBoard].state = false
        m.arrBoards[m.countBoard].alpha = m.opacity
        m.countBoard--
        m.arrBoards[m.countBoard].state = true
        m.arrBoards[m.countBoard].alpha = m.no_opacity
      end if
    end if

    if code = 3 ' Down
    
    end if

    if code = 2 ' Up
     
    end if
    'Back
    if code = 0 then ' Back
      m.game.End()
    end if
  end function

  object.onGameEvent = function(event as string, data as object)

  end function

end function