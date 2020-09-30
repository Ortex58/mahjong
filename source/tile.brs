function tile(object)
    object.const = GetConstants()
    object.type = 0

    object.left_block = invalid
    object.right_block = invalid
    object.up_block = invalid
    object.below_block = -1

    object._neighbours = {"2":-1, "3":-1, "4":-1, "5":-1}

    object.onCreate = function(args)
        bm_tile = m.game.getBitmap("tiles")
        bm_selected = m.game.getBitmap("selection")
        
        m.region = CreateObject("roRegion", bm_tile, 0, 0, m.const.TILE_W, m.const.TILE_H)
        m.region.SetPretranslation(- m.const.TILE_W / 2, - m.const.TILE_H / 2)
        m.skin = m.addImage("tile_tex",m.region)

        selRegion = CreateObject("roRegion", bm_selected, 0, 0, bm_selected.GetWidth(), bm_selected.GetHeight())
        selRegion.SetPretranslation(- bm_selected.GetWidth() / 2, - bm_selected.GetWidth() / 2)
        m.select = m.addImage("selected_tex",selRegion,{offset_x: m.const.SELECT_OFF_X, offset_y: m.const.SELECT_OFF_Y})

        if args.type <> invalid then m.setType(args.type)
        if args.depth <> invalid then m.depth = args.depth

        m.idx = args.id

        m.setSelected(false)
    end function

    object.onDrawEnd = function(canvas)
        if m.const.DEBUG
            font = m.game.getFont("font3_12")
            DrawText(canvas, "id:"+str(m.idx), m.x-2, m.y-14, font, "center", &h00FF00FF)
            DrawText(canvas, "id:"+str(m.idx), m.x-3, m.y-15, font, "center", &h000000FF)
        end if
        
    
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

    object.isSelected = function() as boolean
        return m.select.enabled
    end function

    object.setMarked = function(isMarked as boolean)
        if isMarked
            m.skin.alpha = 150
        else
            m.skin.alpha = 255
        end if
    end function

    object.isMarked = function() as boolean
        return m.skin.alpha < 255
    end function

    object.setBlocks = function(bData As Dynamic)
        if NOT IsObject(bData) then return 0
        m.left_block  = bData.left_block
        m.right_block = bData.right_block
        m.up_block    = bData.up_block
    end function

    object.setBelowNeighbour = function(tileID)
        m.below_block = tileID
    end function

    object.getBlocksList = function() as Dynamic
        ret = [m.left_block,m.right_block,m.up_block,m.below_block]
        return ret
    end function

    object.setNeighbours = function(nData)
        'map neighbours data to direction array
        if nData.u <> invalid then m._neighbours["2"] = nData.u 'up
        if nData.d <> invalid then m._neighbours["3"] = nData.d 'down
        if nData.l <> invalid then m._neighbours["4"] = nData.l 'left
        if nData.r <> invalid then m._neighbours["5"] = nData.r 'right
    end function

    object.getNeighbour = function(_side as integer) as integer
        side_key = _side.ToStr()
        return m._neighbours[side_key]
    end function
    
end function

Function IsTileEqual(idLeft, idRight) as boolean
    if idLeft = idRight then return true

    '30-33 - flowers
    if idLeft >=30 AND idLeft<=33 AND idRight >=30 AND idRight<=33 then return true

    '34-37 - seasons
    if idLeft >=34 AND idLeft<=37 AND idRight >=34 AND idRight<=37 then return true

    return false
end Function