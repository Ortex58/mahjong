function popupLose(object)
  object.const = GetConstants()
  
  object.btn_yes_popup = invalid
  object.btn_no_popup = invalid

  object.onCreate = function(args)
    m.depth = -10
    panel_bg = m.game.getBitmap("panel_bg")
    btn_play = m.game.getBitmap("but_play")

    win_region = CreateObject("roRegion", panel_bg, 0, 0, panel_bg.GetWidth(), panel_bg.GetHeight())
    win_region.SetPretranslation(- panel_bg.GetWidth() / 2, - panel_bg.GetHeight() / 2)

    btn_play_region = CreateObject("roRegion", btn_play, 0, 0, btn_play.GetWidth(), btn_play.GetHeight())
    btn_play_region.SetPretranslation(- btn_play.GetWidth() / 2, - btn_play.GetHeight() / 2)
    win_popup = m.addImage("panel-bg", win_region, {offset_x: 1280 / 2, offset_y: 720 / 2 })

    m.btn_play = m.addImage("btn-no", btn_play_region, { offset_x: 1280 / 2, offset_y: 420})
    m.onSoundPopup("game_win", 50)
  end function

  object.onUpdate = function(dt)

  end function

  object.onDrawBegin = function(canvas)

  end function

  object.onDrawEnd = function(canvas)
    font1 = m.game.getFont("font1_60")
    text1 = DrawText(canvas, "GAME OVER", canvas.GetWidth() / 2, canvas.GetHeight() - 460, font1, "center", &hFFFFFFFF)
  end function

  object.onButton = function(code as integer)

    if code = 6 ' Click on menu item
      m.closePopup()
		end if
    
  end function
  
  
  object.closePopup = function()
    m.onSoundPopup("click", 100)
    globalm = GetGlobalAA()
    globalm.game.postGameEvent(m.const.EVT_RESTART_OK,{})
    m.game.destroyInstance(m)
  end function

  object.onSoundPopup = function(sound as string, volume as integer)
    if m.game.audio.status = true
      m.game.playSound(sound, volume)
    end if
  end function

end function