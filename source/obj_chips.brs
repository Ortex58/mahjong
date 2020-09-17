function obj_chips(object)

	object.opacity = 100
	object.no_opacity = 255
	object.arrImages = []
	'Parse JSON and add to num array
	levelsFile = "pkg:/config/config.json"
	m.currentConfig = ParseJSON(ReadAsciiFile(levelsFile))
	object.num = m.currentConfig["post"]

	object.onCreate = function(args)

		' Add arr of images to arrImage array
		arrImage = CreateObject("roArray", 0, true)

		c_x = m.game.getCanvas().GetWidth() - 1255
		c_y = m.game.getCanvas().GetHeight() - 670

		'Loop add images
		for i = 0 to m.num.Count() - 1
			name = "chip" + str(i - Int(i / 6) * 6).trim()
			m.addChip(name, "chip" + str(i).trim(), c_x + m.num[i].x, c_y + m.num[i].y)
			m.arrImages[i].row = m.num[i].j
		end for

		m.arrImages[0].state = true
		m.arrImages[0].alpha = m.opacity
	end function
	'Function create a Chip
	object.addChip = function(bm_key, img_key, px, py)
		bm_chip = m.game.getBitmap(bm_key)
		region = CreateObject("roRegion", bm_chip, 0, 0, bm_chip.GetWidth(), bm_chip.GetHeight()-30)

		'make offset for chip coordinate center (anchor point)
		region.SetPretranslation(- bm_chip.GetWidth() / 2, - bm_chip.GetHeight() / 2)

		img = m.addImage(img_key + "_img", region, { offset_x: px, offset_y: py })

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

	end function

end function