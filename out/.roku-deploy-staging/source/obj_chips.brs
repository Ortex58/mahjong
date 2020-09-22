function obj_chips(object)

	object.opacity = 100
	object.no_opacity = 255
	object.arrImages = []
	object.levelsFile = "pkg:/config/config-new.json"


	object.onCreate = function(args)
		m.levelConfig = ParseJSON(ReadAsciiFile(m.levelsFile))
		levelID = 0 'level Type
		levelData = m.levelConfig[levelID]
		m.levelData = levelData
		' Add arr of images to arrImage array
		c_x = levelData.layout_pos.x
		c_y = levelData.layout_pos.y
		for k = 0 to levelData.pos.Count() - 1
			chipCode = k MOD 42
			m.addTile(chipCode, str(k), c_x + levelData.pos[k].x, c_y + levelData.pos[k].y, levelData.heights[k], "chip" + str(chipCode).trim())
			m.arrImages[k].blocks = levelData.blocks[k]
		end for

		' Give elements who a not blocked
		for i = 0 to m.arrImages.Count() - 1
			up = m.arrImages[i].blocks.up_block[0]
			right_block = m.arrImages[i].blocks.right_block[0]
			left_block = m.arrImages[i].blocks.left_block[0]
			if up = invalid and left_block = invalid and right_block = invalid or left_block <> invalid or right_block <> invalid
				if left_block <> invalid and right_block <> invalid
					m.arrImages[i].free = false
				else
					m.arrImages[i].free = true
				end if
			end if
		end for
		m.arrFree = m.addArrFree()
	end function

	object.addArrFree = function()
		arrFree = []
		for i = 0 to m.arrImages.Count() - 1
			if m.arrImages[i].free = true
				arrFree.Push(m.arrImages[i])
			end if
		end for
		arrFree[0].state = true
		arrFree[0].index = 1
		return arrFree
	end function

	'Function create a Chip
	object.addTile = function(idx, name, px, py, pz, className)
		bm_tile = m.game.getBitmap("tiles")
		bm_tile_selected = m.game.getBitmap("selection")
		tile_w = 60
		tile_h = 78
		col = idx MOD 9
		row = idx \ 9
		region = CreateObject("roRegion", bm_tile, col * tile_w, row * tile_h, tile_w, tile_h)
		region2 = CreateObject("roRegion", bm_tile_selected, col * tile_w, row * tile_h, tile_w, tile_h)
		region.SetPretranslation(- tile_w / 2, - tile_h / 2)
		region2.SetPretranslation(- tile_w / 2, - tile_h / 2)
		img = m.addAnimatedImage("tile_" + name + "_img", [region, region2], { index: 0
		offset_x: px, offset_y: py, class: className })

		'TODO apply pz when chip will created  by "createObject"
		m.arrImages.Push(img)
		m.arrImages.Peek().state = false
		m.arrImages.Peek().blocks = []
		m.arrImages.Peek().free = false
	end function

	object.onButton = function(code as integer)
		if code = 5 ' Right
			for i = 0 to m.arrFree.Count() - 1
				if m.arrFree[i].state = true
					m.arrFree[i].state = false
					m.arrFree[i].index = 0
					i++
					if m.arrFree.Count() = i
						m.arrFree[0].state = true
						m.arrFree[0].index = 1
					else
						m.arrFree[i].state = true
						m.arrFree[i].index = 1
					end if
				end if
			end for
		end if

		if code = 4 ' Left
			for i = 0 to m.arrFree.Count() - 1
				if i = 0 and m.arrFree[i].state = true
					i = m.arrFree.Count() - 1
					m.arrFree[0].state = false
					m.arrFree[0].index = 0
					i = m.arrFree.Count() - 1
					m.arrFree[i].state = true
					m.arrFree[i].index = 1
				else if i > 0 and m.arrFree[i].state = true
					m.arrFree[i].state = false
					m.arrFree[i].index = 0
					i--
					m.arrFree[i].state = true
					m.arrFree[i].index = 1
				end if
			
			end for
		end if

		if code = 3 ' Down
			for i = 0 to m.arrImages.Count() - 1

			end for
		end if

		if code = 2 ' Up
			for i = 0 to m.arrImages.Count() - 1

			end for
		end if

		if code = 0 then
			m.game.changeRoom("room_menu")
		end if

		' if code = 6
		' 	for i = 0 to m.arrFree.Count() - 1
		' 		if m.arrFree[i].free = true
		' 			m.arrFree[i].index = 1
		' 		end if
		' 	end for
		' end if

	end function

end function