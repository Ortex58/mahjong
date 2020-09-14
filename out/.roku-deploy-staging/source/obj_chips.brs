function obj_chips(object)

	object.opacity = 100
	object.no_opacity = 255
	object.arrImages = []

	object.onCreate = function(args)

		' Add arr of images to arrImage array
		arrImage = CreateObject("roArray", 0, true)

		c_y = m.game.getCanvas().GetHeight()/2
		c_x = m.game.getCanvas().GetWidth()/2

		levelsFile = "pkg:/config/config.json"
		m.currentConfig = ParseJSON(ReadAsciiFile(levelsFile))
		num = m.currentConfig["post"]
		'print num[0]
		for i = 0 to 5 step +1
		m.addChip("chip4_4",c_x-num[i].x, c_y-100)
		end for
		
		
		
		'm.addChip("chip4_4",c_x-100,c_y-100)
		m.addChip("chip4_5",c_x,    c_y-100)
		m.addChip("chip4_6",c_x+100,c_y-100)
		m.addChip("chip5_5",c_x-100,c_y+100)
		m.addChip("chip5_6",c_x,    c_y+100)
		m.addChip("chip6_6",c_x+100,c_y+100)

		m.arrImages[0].state = true
		m.arrImages[0].alpha = m.opacity

	end function

	object.addChip = function(bm_key,px,py)
		bm_chip = m.game.getBitmap(bm_key)
		region = CreateObject("roRegion", bm_chip, 0, 0, bm_chip.GetWidth(), bm_chip.GetHeight())

		'make offset for chip coordinate center (anchor point)
		region.SetPretranslation(- bm_chip.GetWidth()/2, - bm_chip.GetHeight()/2)

		img = m.addImage(bm_key + "_img", region,{offset_x:px,offset_y:py})
		
		m.arrImages.Push(img)
		m.arrImages.Peek().state = false
	end function

	object.onUpdate = function(dt)


	end function

	object.onButton = function(code as integer)
		for i = 0 to m.arrImages.Count() - 1
			if code = 5 ' Right
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
			end if

			if code = 4 ' Left
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
			end if

			if code = 3 ' Down
				if m.arrImages[i].state = true and i = 0
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 3
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				end if

				if m.arrImages[i].state = true and i = 1
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 4
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				end if
				if m.arrImages[i].state = true and i = 2
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 5
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				end if
			end if
			
			if code = 2 ' Up
				if m.arrImages[i].state = true and i = 3
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 0
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				end if

				if m.arrImages[i].state = true and i = 4
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 1
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				end if
				if m.arrImages[i].state = true and i = 5
					m.arrImages[i].state = false
					m.arrImages[i].alpha = m.no_opacity
					i = 2
					m.arrImages[i].state = true
					m.arrImages[i].alpha = m.opacity
				end if
			end if
		end for
	end function

end function