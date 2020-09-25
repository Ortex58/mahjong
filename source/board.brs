function level(object)
  object.onCreate = function(args)
    bm_board = m.game.getBitmap("level0")
    region = CreateObject("roRegion", bm_board, 0, 0, bm_board.GetWidth(), bm_board.GetHeight())
    region.SetPretranslation(- bm_board.GetWidth() / 2, - bm_board.GetHeight() / 2)
    m.addImage(img_key + "_img", region, { offset_x: px, offset_y: py })
    ' img.board_difficulty = ""
    ' img.board_label = ""
    ' img.layout_pos = ""
  end function
end function
