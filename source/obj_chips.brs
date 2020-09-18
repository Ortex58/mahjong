function obj_chips(object)

	object.opacity = 100
	object.no_opacity = 255
	object.arrImages = []
	'Parse JSON and add to num array
	levelsFile = "pkg:/config/config-new.json"
	m.currentConfig = ParseJSON(ReadAsciiFile(levelsFile))
	object.num = m.currentConfig

	object.onCreate = function(args)

		' Add arr of images to arrImage array
		c_x = 0
		c_y = 0
		for k = 0 to m.num.Count() - 1
			if m.num[k].difficulty = "medium" and m.num[k].label = "classic"
				c_x = m.num[k].layout_pos.x ' Чому така мала відстань зліва якщо 30
				c_y = m.num[k].layout_pos.y
				for i = 0 to 4
					rows = m.num[k].pos
					for j = 0 to 8
						m.addTile(j + i * 9, c_x + j * 50, c_y + i * 100)
					end for
				end for
			end if
		end for

	end function
	'Function create a Chip

	object.addTile = function(idx, px, py)
		bm_tile = m.game.getBitmap("tiles")
		tile_w = 60
		tile_h = 78
		col = idx MOD 9
		row = idx \ 9
		region = CreateObject("roRegion", bm_tile, col * tile_w, row * tile_h, tile_w, tile_h)
		region.SetPretranslation(- tile_w / 2, - tile_h / 2)
		img = m.addImage("tile_" + str(idx) + "_img", region, { offset_x: px, offset_y: py })

		m.arrImages.Push(img)
		m.arrImages.Peek().state = false
		m.arrImages.Peek().row = 0
	end function

	object.onUpdate = function(dt)


	end function

	object.onButton = function(code as integer)

		if code = 5 ' Right
			for i = 0 to m.arrImages.Count() - 1
				if m.arrImages[i].state = true
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i++
					if m.arrImages.Count() = i
						m.arrImages[0].state = true
						m.arrImages[0].alpha = m.opacity
					else
						m.arrImages[i].state = true
						m.arrImages[i].alpha = m.opacity
					end if
				end if
			end for
		end if

		if code = 4 ' Left
			for i = 0 to m.arrImages.Count() - 1
				if m.arrImages[i].state = true and i <> 0
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i--
					if m.arrImages.Count() = i
						m.arrImages[0].state = true
						m.arrImages[0].alpha = m.opacity
					else
						m.arrImages[i].state = true
						m.arrImages[i].alpha = m.opacity
					end if
				end if
			end for
		end if

		if code = 3 ' Down
			for i = 0 to m.arrImages.Count() - 1
				if m.arrImages[i].state = true and m.arrImages[i].row = 1
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 12
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity

				else if m.arrImages[i].state = true and m.arrImages[i].row = 2
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 20
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 3
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 30
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 4
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 45
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 5
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 57
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 6
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 67
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 7
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 75
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 8
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 0
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				end if
			end for
		end if

		if code = 2 ' Up
			for i = 0 to m.arrImages.Count() - 1
				if m.arrImages[i].state = true and m.arrImages[i].row = 1
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 75
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 2
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 0
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 3
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 12
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 4
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 20
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 5
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 30
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 6
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 45
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 6
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 57
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 7
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 57
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				else if m.arrImages[i].state = true and m.arrImages[i].row = 8
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 0
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				end if
			end for
		end if

		if code = 0 then
			m.game.changeRoom("room_menu")
		end if

	end function

end function