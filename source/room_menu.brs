function room_menu(object)
  object.const = GetConstants()
  object.arrBoards = []
  object.selected_idx = 0
  object.rows = 2
  object.cols = 3
  object.main_music_theme = invalid
  
  'Parse JSON and add to num array
  levelsFile = "pkg:/config/config-new-2.json"
  m.currentConfig = ParseJSON(ReadAsciiFile(levelsFile))
  object.num = m.currentConfig

  object.onCreate = function(args)
    m.main_music_theme = m.game.musicPlay("pkg:/sounds/Our_Mountain.wav", true)
    m.main_music_theme = m.game.musicPause()
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
      m.arrBoards[i].alpha = m.const.opacity
      m.arrBoards[i].board_difficulty = m.num[i].["difficulty"]
      m.arrBoards[i].board_label = m.num[i].["label"]
      m.arrBoards[i].layout_pos = m.num[i].["layout_pos"]
    end for
    m.arrBoards[0].alpha = m.const.no_opacity
    m.arrBoards[0].scale_x = 1.1
    m.arrBoards[0].scale_y = 1.1
    'Audio
    btn_Audio = m.game.getBitmap("but_audio")
    audio_w = 80
    audio_h = 75
    width = btn_Audio.GetWidth()
    height = btn_Audio.GetHeight()
    region1 = CreateObject("roRegion", btn_Audio, 0, 0, audio_w, audio_h)
    region2 = CreateObject("roRegion", btn_Audio, 86, 0, audio_w, audio_h)
    region1.SetPretranslation(- audio_w / 2, - audio_h / 2)
    region2.SetPretranslation(- audio_w / 2, - audio_h / 2)
    m.game.audio = m.addAnimatedImage("button_Audio", [region1, region2], { index: 1
      offset_x: 1205,
    offset_y: 80 })
    m.game.audio.status = false
  end function

  'Function create a boards level
  object.addLevel = function(bm_key, img_key, px, py)
    bm_chip = m.game.getBitmap(bm_key)
    region = CreateObject("roRegion", bm_chip, 0, 0, bm_chip.GetWidth(), bm_chip.GetHeight())
    region.SetPretranslation(- bm_chip.GetWidth() / 2, - bm_chip.GetHeight() / 2)
    img = m.addImage(img_key + "_img", region, { offset_x: px, offset_y: py, scale_x: 1.0, scale_y: 1.0 })
    img.state = false
    img.board_difficulty = ""
    img.board_label = ""
    img.layout_pos = ""
    m.arrBoards.Push(img)
  end function

  object.onDrawBegin = function(canvas)

  end function
  'Draw OK image
  object.onDrawEnd = function(canvas)
    font1 = m.game.getFont("font1_60")
    font2 = m.game.getFont("font2_25")
    DrawText(canvas, "SELECT A LEVEL", canvas.GetWidth() / 2, canvas.GetHeight() - 670, font1, "center", &hFFFFFFFF)
    x_b = 400
    y_b = 216
    y_l = 350
    for i = 0 to m.arrBoards.Count() - 1
      DrawText(canvas, m.arrBoards[i].board_difficulty, x_b, y_b, font2, "center", &hFFFFFFFF)
      DrawText(canvas, m.arrBoards[i].board_label, x_b, y_l, font2, "center", &hFFFFFFFF)
      x_b += 230
      if i MOD 3 = 2
        x_b = 400
        y_b += 234
        y_l += 234
      end if
    end for
  end function

  object.onButton = function(code as integer)
    'Select
    if code = 6 then
      m.game.changeRoom("room_lobby", { level: m.selected_idx })
    end if

    if code = 5 ' Right
      m.onSoundMenu("tab", 100)
      if m.selected_idx < m.arrBoards.Count()
        m.arrBoards[m.selected_idx].alpha = m.const.opacity
        m.arrBoards[m.selected_idx].scale_x = 1.0
        m.arrBoards[m.selected_idx].scale_y = 1.0
        m.selected_idx++
        if m.arrBoards.Count() = m.selected_idx
          m.arrBoards[0].alpha = m.const.no_opacity
          m.arrBoards[0].scale_x = 1.0
        m.arrBoards[0].scale_y = 1.0
          m.selected_idx = 0
        end if
        m.arrBoards[m.selected_idx].alpha = m.const.no_opacity
        m.arrBoards[m.selected_idx].scale_x = 1.1
        m.arrBoards[m.selected_idx].scale_y = 1.1
      end if
    end if

    if code = 4 ' Left
      m.onSoundMenu("tab", 100)
      if m.selected_idx = 0
        m.selected_idx = m.arrBoards.Count() - 1
        m.arrBoards[0].alpha = m.const.opacity
        m.arrBoards[0].scale_x = 1.0
        m.arrBoards[0].scale_y = 1.0
        m.selected_idx = m.arrBoards.Count() - 1
      
        m.arrBoards[m.selected_idx].alpha = m.const.no_opacity
        m.arrBoards[m.selected_idx].scale_x = 1.1
        m.arrBoards[m.selected_idx].scale_y = 1.1
      else if m.selected_idx > 0
        m.arrBoards[m.selected_idx].alpha = m.const.opacity
        m.arrBoards[m.selected_idx].scale_x = 1.0
        m.arrBoards[m.selected_idx].scale_y = 1.0
        m.selected_idx--
        m.arrBoards[m.selected_idx].alpha = m.const.no_opacity
        m.arrBoards[m.selected_idx].scale_x = 1.1
        m.arrBoards[m.selected_idx].scale_y = 1.1
       
      end if
    end if

    if code = 3 ' Down
      m.onSoundMenu("tab", 100)
      if m.selected_idx >= 0 and m.selected_idx <= m.rows
        m.arrBoards[m.selected_idx].alpha = m.const.opacity
        m.arrBoards[m.selected_idx].scale_x = 1.0
        m.arrBoards[m.selected_idx].scale_y = 1.0
        m.selected_idx = m.selected_idx + m.cols
        m.arrBoards[m.selected_idx].alpha = m.const.no_opacity
        m.arrBoards[m.selected_idx].scale_x = 1.1
        m.arrBoards[m.selected_idx].scale_y = 1.1
      else if m.selected_idx >= m.cols
        m.arrBoards[m.selected_idx].alpha = m.const.opacity
        m.arrBoards[m.selected_idx].scale_x = 1.0
        m.arrBoards[m.selected_idx].scale_y = 1.0
        m.selected_idx = m.selected_idx - m.cols
        m.arrBoards[m.selected_idx].alpha = m.const.no_opacity
        m.arrBoards[m.selected_idx].scale_x = 1.1
        m.arrBoards[m.selected_idx].scale_y = 1.1
      end if
    end if

    if code = 2 ' Up
      m.onSoundMenu("tab", 100)
      if m.selected_idx >= m.cols and m.selected_idx <= m.arrBoards.Count() - 1
        m.arrBoards[m.selected_idx].alpha = m.const.opacity
        m.arrBoards[m.selected_idx].scale_x = 1.0
        m.arrBoards[m.selected_idx].scale_y = 1.0
        m.selected_idx = m.selected_idx - m.cols
        m.arrBoards[m.selected_idx].alpha = m.const.no_opacity
        m.arrBoards[m.selected_idx].scale_x = 1.1
        m.arrBoards[m.selected_idx].scale_y = 1.1
      else if m.selected_idx <= m.rows
        m.arrBoards[m.selected_idx].alpha = m.const.opacity
        m.arrBoards[m.selected_idx].scale_x = 1.0
        m.arrBoards[m.selected_idx].scale_y = 1.0
        m.selected_idx = m.selected_idx + m.cols
        m.arrBoards[m.selected_idx].alpha = m.const.no_opacity
        m.arrBoards[m.selected_idx].scale_x = 1.1
        m.arrBoards[m.selected_idx].scale_y = 1.1
      end if
    end if
    'Back
    if code = 0 then ' Back
      m.onSoundMenu("click", 100)
      m.game.End()
    end if

    if code = 10 then ' Volume
    if m.game.audio.status = false
      m.game.playSound("click", 100)
      m.main_music_theme = m.game.musicResume()
      m.game.audio.status = true
      m.game.audio.index = 0
    else
      m.game.audio.status = false
      m.game.audio.index = 1
      m.main_music_theme = m.game.musicPause()
    end if
  end if
  end function

  object.onSoundMenu = function(sound as string, volume as integer)
    if m.game.audio.status = true
      m.game.playSound(sound, volume)
    end if
  end function

  object.onGameEvent = function(event as string, data as object)

  end function

end function