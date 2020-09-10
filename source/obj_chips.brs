function obj_chips(object)

	object.x = invalid
	object.y = invalid
	object.opacity = 100
	object.no_opacity = 255
	object.k = invalid
	object.arrImages = []

	object.onCreate = function(args)

		m.y = m.game.getCanvas().GetHeight()
		m.x = m.game.getCanvas().GetWidth()

		bm_chip = m.game.getBitmap("chip4_4")
		region = CreateObject("roRegion", bm_chip, 0, 0, bm_chip.GetWidth(), bm_chip.GetHeight())
		region.SetPretranslation(- bm_chip.GetWidth() - 1200, - bm_chip.GetHeight() - 600)
		m.addImage("chip", region)

		bm_chip2 = m.game.getBitmap("chip4_5")
		region = CreateObject("roRegion", bm_chip2, 0, 0, bm_chip2.GetWidth(), bm_chip2.GetHeight())
		region.SetPretranslation(- bm_chip2.GetWidth() - 1100, - bm_chip2.GetHeight() - 600)
		m.addImage("chip2", region)

		bm_chip3 = m.game.getBitmap("chip4_6")
		region = CreateObject("roRegion", bm_chip3, 0, 0, bm_chip3.GetWidth(), bm_chip3.GetHeight())
		region.SetPretranslation(- bm_chip3.GetWidth() - 1000, - bm_chip3.GetHeight() - 600)
		m.addImage("chip3", region)

		bm_chip4 = m.game.getBitmap("chip5_5")
		region = CreateObject("roRegion", bm_chip4, 0, 0, bm_chip4.GetWidth(), bm_chip4.GetHeight())
		region.SetPretranslation(- bm_chip4.GetWidth() - 1200, - bm_chip4.GetHeight() - 450)
		m.addImage("chip4", region)

		bm_chip5 = m.game.getBitmap("chip5_6")
		region = CreateObject("roRegion", bm_chip5, 0, 0, bm_chip5.GetWidth(), bm_chip5.GetHeight())
		region.SetPretranslation(- bm_chip5.GetWidth() - 1100, - bm_chip5.GetHeight() - 450)
		m.addImage("chip5", region)

		bm_chip6 = m.game.getBitmap("chip6_6")
		region = CreateObject("roRegion", bm_chip6, 0, 0, bm_chip6.GetWidth(), bm_chip6.GetHeight())
		region.SetPretranslation(- bm_chip6.GetWidth() - 1000, - bm_chip6.GetHeight() - 450)
		m.addImage("chip6", region)
		
		' Add arr of images to arrImage array
		arrImage = CreateObject("roArray", 0, true)
		for i = 0 to m.images.Count() - 1
			m.k = m.images[i]
			m.arrImages.Push(m.k)
			m.arrImages[i].state = false
		end for
		
		m.arrImages[0].state = true
		m.arrImages[0].alpha = m.opacity

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