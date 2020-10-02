function popupRestart(object)
  object.const = GetConstants()
  object.opacity = 150
  object.no_opacity = 255
  object.btn_yes_popup = invalid
  object.btn_no_popup = invalid
  object.onCreate = function(args)
    m.depth = -10
    panel_bg = m.game.getBitmap("panel_bg")
    bt_yes = m.game.getBitmap("but_yes")
    but_no = m.game.getBitmap("but_no")

    restart_region = CreateObject("roRegion", panel_bg, 0, 0, panel_bg.GetWidth(), panel_bg.GetHeight())
    restart_region.SetPretranslation(- panel_bg.GetWidth() / 2, - panel_bg.GetHeight() / 2)
    bt_yes_region = CreateObject("roRegion", bt_yes, 0, 0, bt_yes.GetWidth(), bt_yes.GetHeight())
    bt_no_region = CreateObject("roRegion", but_no, 0, 0, but_no.GetWidth(), but_no.GetHeight())

    restart_popup = m.addImage("panel-bg", restart_region, {offset_x: 1280 / 2, offset_y: 720 / 2 })

    m.btn_yes_popup = m.addImage("btn-yes", bt_yes_region, { offset_x: 762, offset_y: 380})
    m.btn_no_popup = m.addImage("btn-no", bt_no_region, { offset_x: 420, offset_y: 380})

    m.btn_yes_popup.alpha = m.const.opacity
    m.btn_yes_popup.status = false
    m.btn_no_popup.status = true
    
  end function

  object.onUpdate = function(dt)

  end function

  object.onDrawBegin = function(canvas)

  end function

  object.onDrawEnd = function(canvas)
    font1 = m.game.getFont("font1_60")
    text1 = DrawText(canvas, "DO YOU REALLY", canvas.GetWidth() / 2, canvas.GetHeight() - 480, font1, "center", &hFFFFFFFF)
    DrawText(canvas, "WANT TO RESTART", canvas.GetWidth() / 2, canvas.GetHeight() - 420, font1, "center", &hFFFFFFFF)
  end function

  object.onButton = function(code as integer)

    if code = 5 or code = 4' Right
      m.onSoundPopup("tab", 50)
      if m.btn_no_popup.status = true
        m.btn_no_popup.status = false
        m.btn_no_popup.alpha = m.const.opacity
        m.btn_yes_popup.status = true
        m.btn_yes_popup.alpha = m.const.no_opacity
      else
        m.btn_yes_popup.status = false
        m.btn_yes_popup.alpha = m.opacity
        m.btn_no_popup.status = true
        m.btn_no_popup.alpha = m.const.no_opacity
      end if
    end if

    if code = 6 ' Click on menu item
      m.onSoundPopup("click", 50)
      if m.btn_yes_popup.status = true'Cancel
        globalm = GetGlobalAA()
        globalm.game.postGameEvent(m.const.EVT_RESTART_OK,{})
      end if
      m.closePopup() ' close for every button
		end if

  end function


  object.closePopup = function()
    globalm = GetGlobalAA()
    globalm.game.postGameEvent(m.const.EVT_CLOSE_POP,{})
    m.game.destroyInstance(m)
  end function

  object.onSoundPopup = function(sound as string, volume as integer)
    if m.game.audio.status = false
      m.game.playSound(sound, volume)
    end if
  end function

end function