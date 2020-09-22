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
		for k = levelData.pos.Count() - 1 to 0 Step -1
			chipCode = k MOD 42
			tileItem = m.addTile(chipCode, c_x + levelData.pos[k].x, c_y + levelData.pos[k].y, levelData.heights[k])
			tileItem.blocks = levelData.blocks[k]
		end for
		m.arrImages.Reverse()

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
		return arrFree
	end function

	object.addTile = function(idx, px, py, pz) as Dynamic
		tileItem = m.game.createInstance("tile",{type:idx,depth:-pz})
		tileItem.x = px
		tileItem.y = py

		'TODO apply pz when chip will created  by "createObject"
		m.arrImages.Push(tileItem)
		m.arrImages.Peek().state = false
		m.arrImages.Peek().blocks = []
		m.arrImages.Peek().free = false

		return tileItem
	end function

	object.onButton = function(code as integer)
		if code = 5 ' Right
			for i = 0 to m.arrFree.Count() - 1
				if m.arrFree[i].state = true
					m.arrFree[i].state = false
					m.arrFree[i].setSelected(false)
					i++
					if m.arrFree.Count() = i
						m.arrFree[0].state = true
						m.arrFree[i].setSelected(true)
					else
						m.arrFree[i].state = true
						m.arrFree[i].setSelected(true)
					end if
				end if
			end for
		end if

		if code = 4 ' Left
			' for i = 0 to m.arrFree.Count() - 1
			' 	if m.arrFree[i] = 0 and m.arrFree[i].state = true
			' 		m.arrFree[i].state = false
			' 		m.arrFree[i].index = 0
			' 		i = m.arrFree[m.arrFree.Count() - 1]
			' 		if m.arrFree[i].state = true
			' 		m.arrFree[i].state = false
			' 		m.arrFree[i].index = 0
			' 		i--
			' 		else
			' 			m.arrFree[i].state = true
			' 			m.arrFree[i].index = 1
			' 		end if
			' 	end if
			' end for
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