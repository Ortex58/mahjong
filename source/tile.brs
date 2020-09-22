function tile(object)
    object.const = GetConstants()
    object.type = 0


    object.onCreate = function(args)
        bm_tile = m.game.getBitmap("tiles")
        bm_selected = m.game.getBitmap("selection")
        
        m.region = CreateObject("roRegion", bm_tile, 0, 0, m.const.TILE_W, m.const.TILE_H)
        m.region.SetPretranslation(- m.const.TILE_W / 2, - m.const.TILE_H / 2)
        m.addImage("tile_tex",m.region)

        selRegion = CreateObject("roRegion", bm_selected, 0, 0, bm_selected.GetWidth(), bm_selected.GetHeight())
        selRegion.SetPretranslation(- bm_selected.GetWidth() / 2, - bm_selected.GetWidth() / 2)
        m.select = m.addImage("selected_tex",selRegion,{offset_x: m.const.SELECT_OFF_X, offset_y: m.const.SELECT_OFF_Y})

        if args.type <> invalid then m.setType(args.type)
        if args.depth <> invalid then m.depth = args.depth

        m.setSelected(false)
    end function

    object.setType = function(pType as integer)
        m.type = pType
        col = pType MOD m.const.TILE_COL_NUM
        row = pType \ m.const.TILE_COL_NUM
        regX = col * m.const.TILE_W
        regY = row * m.const.TILE_H

        m.region.Offset(regX - m.region.GetX(), regY - m.region.GetY(), 0, 0)
    end function

    object.setSelected = function(isSelected as boolean)
        m.select.enabled = isSelected
    end function
    
end function