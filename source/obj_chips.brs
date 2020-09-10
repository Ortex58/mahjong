function obj_chips(object)

	object.x = invalid
	object.y = invalid
	object.opacity = 100
	object.no_opacity = 255

	object.onCreate = function(args)

		m.y = m.game.getCanvas().GetHeight()
		m.x = m.game.getCanvas().GetWidth()

		bm_chip = m.game.getBitmap("chip4_4")
		region = CreateObject("roRegion", bm_chip, 0, 0, bm_chip.GetWidth(), bm_chip.GetHeight())
		region.SetPretranslation(- bm_chip.GetWidth() - 1200, - bm_chip.GetHeight() - 600)
		m.addImage("chip", region, { alpha: 255, state: false })

		bm_chip2 = m.game.getBitmap("chip4_5")
		region = CreateObject("roRegion", bm_chip2, 0, 0, bm_chip2.GetWidth(), bm_chip2.GetHeight())
		region.SetPretranslation(- bm_chip2.GetWidth() - 1100, - bm_chip2.GetHeight() - 600)
		m.addImage("chip2", region, { alpha: 255, state: false })

		bm_chip3 = m.game.getBitmap("chip4_6")
		region = CreateObject("roRegion", bm_chip3, 0, 0, bm_chip3.GetWidth(), bm_chip3.GetHeight())
		region.SetPretranslation(- bm_chip3.GetWidth() - 1000, - bm_chip3.GetHeight() - 600)
		m.addImage("chip3", region, { alpha: 255, state: false })

		bm_chip4 = m.game.getBitmap("chip5_5")
		region = CreateObject("roRegion", bm_chip4, 0, 0, bm_chip4.GetWidth(), bm_chip4.GetHeight())
		region.SetPretranslation(- bm_chip4.GetWidth() - 1200, - bm_chip4.GetHeight() - 450)
		m.addImage("chip4", region, { alpha: 255, state: false })

		bm_chip5 = m.game.getBitmap("chip5_6")
		region = CreateObject("roRegion", bm_chip5, 0, 0, bm_chip5.GetWidth(), bm_chip5.GetHeight())
		region.SetPretranslation(- bm_chip5.GetWidth() - 1100, - bm_chip5.GetHeight() - 450)
		m.addImage("chip5", region, { alpha: 255, state: false })

		bm_chip6 = m.game.getBitmap("chip6_6")
		region = CreateObject("roRegion", bm_chip6, 0, 0, bm_chip6.GetWidth(), bm_chip6.GetHeight())
		region.SetPretranslation(- bm_chip6.GetWidth() - 1000, - bm_chip6.GetHeight() - 450)
		m.addImage("chip6", region, { alpha: 255, state: false })
		m.images[0].state = true
		m.images[0].alpha = m.opacity
	end function

	object.onUpdate = function(dt)


	end function

	object.onButton = function(code as integer)

		for i = 0 to m.images.Count() - 1
			if code = 5 ' Right
				if m.images[i].state = true
					m.images[i].state = false
					m.images[i].alpha = m.no_opacity
					i++
					if m.images.Count() = i
						m.images[0].state = true
						m.images[0].alpha = m.opacity
					else
						m.images[i].state = true
						m.images[i].alpha = m.opacity
					end if
				end if
			end if

			if code = 4 ' Left
				if m.images[i].state = true and i <> 0
					m.images[i].state = false
					m.images[i].alpha = m.no_opacity
					i--
					if m.images.Count() = i
						m.images[0].state = true
						m.images[0].alpha = m.opacity
					else
						m.images[i].state = true
						m.images[i].alpha = m.opacity
					end if
				end if
			end if

			if code = 3 ' Down
				if m.images[i].state = true and i = 0
					m.images[i].state = false
					m.images[i].alpha = m.no_opacity
					i = 3
					m.images[i].state = true
					m.images[i].alpha = m.opacity
				end if

				if m.images[i].state = true and i = 1
					m.images[i].state = false
					m.images[i].alpha = m.no_opacity
					i = 4
					m.images[i].state = true
					m.images[i].alpha = m.opacity
				end if
				if m.images[i].state = true and i = 2
					m.images[i].state = false
					m.images[i].alpha = m.no_opacity
					i = 5
					m.images[i].state = true
					m.images[i].alpha = m.opacity
				end if
			end if
			
			if code = 2 ' Up
				if m.images[i].state = true and i = 3
					m.images[i].state = false
					m.images[i].alpha = m.no_opacity
					i = 0
					m.images[i].state = true
					m.images[i].alpha = m.opacity
				end if

				if m.images[i].state = true and i = 4
					m.images[i].state = false
					m.images[i].alpha = m.no_opacity
					i = 1
					m.images[i].state = true
					m.images[i].alpha = m.opacity
				end if
				if m.images[i].state = true and i = 5
					m.images[i].state = false
					m.images[i].alpha = m.no_opacity
					i = 2
					m.images[i].state = true
					m.images[i].alpha = m.opacity
				end if
			end if
		end for

	end function

end function