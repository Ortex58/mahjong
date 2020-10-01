function obj_chips(object)
	object.select_menu = false
	object.equalArr = []
	object.activeCount = 0
	object.aveilableCount = 0
	object.score = 0
	object.arrTiles = []
	object.levelsFile = "pkg:/config/config-new-2.json"
	object.selTile_idx = -1

	object.const = GetConstants()

	'********************************************************************
	'	interface methods
	'********************************************************************
	object.onCreate = function(args)
		m.levelConfig = ParseJSON(ReadAsciiFile(m.levelsFile))

		'TODO get level Type from args
		levelID = args.level

		' levelID = 5 'DEBUG level Type

		levelData = m.levelConfig[levelID]
		m.levelData = levelData

		c_x = levelData.layout_pos.x
		c_y = levelData.layout_pos.y

		arrType = []
		arrLength = levelData.pos.Count() \ 2
		for j = 0 to arrLength - 1
			chipCode = j MOD m.const.TILES_COUNT
			arrType.Push(chipCode)
			arrType.Push(chipCode)
		end for
		arrType = m.ShuffleArray(arrType)

		for k = levelData.pos.Count() - 1 to 0 step -1
			' chipCode = k MOD 42 'REMOVE and use shuffle!
			chipCode = arrType[k]

			px = c_x + levelData.pos[k].x
			py = c_y + levelData.pos[k].y
			pz = levelData.heights[k]

			tileItem = m.game.createInstance("tile", { type: chipCode, depth: - pz, id: k })
			tileItem.x = Cint(px)
			tileItem.y = Cint(py)
			tileItem.setBlocks(levelData.blocks[k])
			tileItem.setNeighbours(levelData.blocks_list[k]) 'TODO add neighbours Data

			m.arrTiles.Push(tileItem)
		end for
		m.arrTiles.Reverse()

		'add relation to below tiles
		for i = 0 to m.arrTiles.Count() - 1
			tileItem = m.arrTiles[i]
			blockersDIR = tileItem.getBlocksList()
			if m.arrHasActive(blockersDIR[2])
				tileAboweID = m.arrGetActiveId(blockersDIR[2])
				tileAbowe = m.arrTiles[tileAboweID]
				tileAbowe.setBelowNeighbour(i)
			end if
		end for

		'TODO
		m.selTile_idx = m.arrTiles.Count() - 1
		m.arrTiles[m.selTile_idx].setSelected(true)

		m.updateStats()
	end function

	object.onButton = function(code as integer)
		if code = 10 and m.select_menu = false
			m.select_menu = true
			print true
		else if code = 10 and m.select_menu = true
			m.select_menu = false
			print false
		end if
		if m.select_menu = false
			if code = 4 or code = 5 'arrow codes horizontal
				m.trySelectTile(m.selTile_idx, code, false)
			else if code = 2 or code = 3 'arrow codes vertical
				m.trySelectTile(m.selTile_idx, code, true)
			end if
			if code = 6
				tileItem = m.arrTiles[m.selTile_idx]
				' tileItem.setMarked(NOT tileItem.isMarked())
				if m.equalArr.Count() < 2
					tileItem.setMarked(not tileItem.isMarked())

					'TODO use "enable" prooerty to disable tile pairs
					if tileItem.isMarked() and m.equalArr.Count() < 2
						m.equalArr.Push(tileItem)
						print m.equalArr.Count()
					end if
					if m.equalArr.Count() > 1
						if m.equalArr[0].idx <> m.equalArr[1].idx and IsTileEqual(m.equalArr[0].type, m.equalArr[1].type)
							print "is a pair!"
							m.equalArr[0].setEnabled(false)
							m.equalArr[1].setEnabled(false)
							m.score += 500
							last = m.arrTiles.Count() - 1
							while last >= 0 and not m.arrTiles[last].enabled
								last--
							end while
							m.selTile_idx = last
							m.arrTiles[m.selTile_idx].setSelected(true)

							m.updateStats()
							m.equalArr.Clear()
						else
							print "isn't a pair!"
							m.equalArr[0].skin.alpha = 255
							m.equalArr[1].skin.alpha = 255
							m.equalArr.Clear()
							m.updateStats()
							print m.equalArr.Count()
						end if
					end if
				end if
				m.updateStats()
			end if
		end if
		if code = 0 then
			m.game.changeRoom("room_menu")
		end if



	end function

	object.onDrawEnd = function(canvas)
		'TODO move this stats to room draw method
		font2 = m.game.getFont("font2_25")
		DrawText(canvas, "active: " + str(m.activeCount), 300, 650, font2, "center", &hFFFFFFFF)
		DrawText(canvas, "aveilable: " + str(m.aveilableCount), 500, 650, font2, "center", &hFFFFFFFF)
	end function


	'********************************************************************
	' public methods
	'********************************************************************
	object.shuffle = function()
		arrType = []
		'collect all tiles types
		for i = 0 to m.arrTiles.Count() - 1
			tileItem = m.arrTiles[i]
			arrType.Push(tileItem.type)
		end for
		arrType = m.ShuffleArray(arrType)
		m.resetField()
		for i = 0 to m.arrTiles.Count() - 1
			tileItem = m.arrTiles[i]
			tileItem.setType(arrType[i])
		end for
	end function
	' Hint
	object.showHint = function()
		aveilables = []
		arrEqual = []
		for i = 0 to m.arrTiles.Count() - 1
			tileItem = m.arrTiles[i]
			if not m.isBlocked(i) and tileItem.enabled then aveilables.push(tileItem)
		end for

		for i = 0 to aveilables.Count() - 2
			for j = i + 1 to aveilables.Count() - 1
				first = aveilables[i].type
				second = aveilables[j].type
				if IsTileEqual(first, second)
					arrEqual.Push(aveilables[i])
					arrEqual.Push(aveilables[j])
					arrEqual[0].images[0].alpha = m.const.opacity
					arrEqual[1].images[0].alpha = m.const.opacity
				end if
			end for
		end for
	end function

	object.resetField = function()
		for i = 0 to m.arrTiles.Count() - 1
			tileItem = m.arrTiles[i]
			tileItem.setEnabled(true)
		end for
		m.updateStats()
	end function

	'********************************************************************
	' private methods
	'********************************************************************
	object.trySelectTile = function(base_idx, _dir, row_lookup = false) as boolean

		curr_tile = m.arrTiles[base_idx]
		neighbourID = curr_tile.getNeighbour(_dir)
		neighbourID = m.tileGetLowestActive(neighbourID)

		'lookup in straight direction
		while neighbourID >= 0
			candidate = m.arrTiles[neighbourID]
			blockersDIR = candidate.getBlocksList()

			if m.arrHasActive(blockersDIR[2]) 'check layer above
				neighbourID = m.arrGetActiveId(blockersDIR[2])
			else if not candidate.enabled or (m.arrHasActive(blockersDIR[0]) and m.arrHasActive(blockersDIR[1])) 'block by Neighbours

				if row_lookup and (m.trySelectTile(neighbourID, 4) or m.trySelectTile(neighbourID, 5))
					curr_tile.setSelected(false)
					return true
				end if

				neighbourID = candidate.getNeighbour(_dir)
				neighbourID = m.tileGetLowestActive(neighbourID)
			else
				curr_tile.setSelected(false)
				candidate.setSelected(true)
				m.selTile_idx = neighbourID
				return true
			end if
		end while

		return false
	end function

	object.updateStats = function()
		m.activeCount = 0
		m.aveilableCount = 0
		aveilables = []
		for i = 0 to m.arrTiles.Count() - 1
			tileItem = m.arrTiles[i]
			if tileItem.enabled then m.activeCount++
			if not m.isBlocked(i) and tileItem.enabled then aveilables.push(tileItem)
		end for

		for i = 0 to aveilables.Count() - 2
			for j = i + 1 to aveilables.Count() - 1
				first = aveilables[i].type
				second = aveilables[j].type
				if IsTileEqual(first, second) then m.aveilableCount++
			end for
		end for
	end function
	'********************************************************************
	'	helpers
	'********************************************************************

	'check if tile blocked by it`s index
	object.isBlocked = function(idx) as boolean
		curr_tile = m.arrTiles[idx]
		blockersDIR = curr_tile.getBlocksList()

		if m.arrHasActive(blockersDIR[2]) then return true ' blocked by upper layer

		if m.arrHasActive(blockersDIR[0]) and m.arrHasActive(blockersDIR[1]) then
			return true ' blocked by 2 neighbours
		end if

		return false
	end function

	'check tiles present on field
	'input may be tile index or array of tile indexes
	object.arrHasActive = function(arr) as boolean
		if not IsValid(arr) return false

		if IsArray(arr) then
			for i = 0 to arr.Count() - 1
				tileID = arr[i]
				if m.arrTiles[tileID].enabled then return true
			end for
		else
			if arr >= m.arrTiles.Count() then return false

			return m.arrTiles[arr].enabled
		end if

		return false
	end function

	object.arrGetActiveId = function(arr) as dynamic
		if not IsValid(arr) return -1

		if IsArray(arr) then
			for i = 0 to arr.Count() - 1
				tileID = arr[i]
				if m.arrTiles[tileID].enabled then return tileID
			end for
		else
			if m.arrTiles[arr].enabled then return arr
		end if

		return -1
	end function

	object.tileGetLowestActive = function(baseID) as integer
		retIdx = baseID
		while retIdx >= 0
			tileItem = m.arrTiles[retIdx]

			if not tileItem.enabled
				retIdx = tileItem.getBlocksList()[3] 'check below neighbour
			else
				return retIdx
			end if
		end while

		return baseID
	end function

	object.ShuffleArray = function(argArray) as object
		rndArray = []
		for i = 0 to argArray.Count() - 1
			intIndex = Rnd(argArray.Count())
			rndArray.Push(argArray[intIndex - 1])
			argArray.Delete(intIndex - 1)
		next
		return rndArray
	end function

end function