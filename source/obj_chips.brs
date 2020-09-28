function obj_chips(object)
	object.equalArr = []
	object.activeCount = 0
	object.aveilableCount = 0

	object.arrTiles = []
	object.levelsFile = "pkg:/config/config-new-2.json"
	object.selTile_idx = -1

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
		' Add arr of images to arrImage array
		c_x = levelData.layout_pos.x
		c_y = levelData.layout_pos.y
		arrType = []
		for j = levelData.pos.Count() - 1 to 0 step -1
			chipCode = j MOD 42
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
			tileItem.x = px
			tileItem.y = py
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
		if code = 4 or code = 5 'arrow codes horizontal
			m.trySelectTile(m.selTile_idx, code, false)
		else if code = 2 or code = 3 'arrow codes vertical
			m.trySelectTile(m.selTile_idx, code, true)
		end if

		if code = 0 then
			m.game.changeRoom("room_menu")
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
					if m.equalArr[0].type = m.equalArr[1].type and m.equalArr[0].idx <> m.equalArr[1].idx
						print "is a pair!"
						m.equalArr[0].enabled = false
						m.equalArr[0].x = -100
						m.equalArr[1].enabled = false
						m.equalArr[1].x = -100
						m.selTile_idx = m.arrTiles.Count() - 1
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
		'utilize tile types and randomize it on field
	end function

	object.showHint = function() as boolean
		'calculate aveilable pairs on field and hightlight them
		return false
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
		for i = 0 to m.arrTiles.Count() - 1
			tileItem = m.arrTiles[i]
			if tileItem.enabled then m.activeCount++
			if not m.isBlocked(i) and tileItem.enabled then m.aveilableCount++
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