function obj_chips(object)

	object.opacity = 100
	object.no_opacity = 255
	object.arrTiles = []
	object.levelsFile = "pkg:/config/config-new.json"
	object.selTile_idx = -1


	'********************************************************************
	'	interface methods
	'********************************************************************
	object.onCreate = function(args)
		m.levelConfig = ParseJSON(ReadAsciiFile(m.levelsFile))
		
		'TODO get level Type from args
		levelID = args.level
		levelID = 0 'DEBUG level Type

		levelData = m.levelConfig[levelID]
		m.levelData = levelData
		' Add arr of images to arrImage array
		c_x = levelData.layout_pos.x
		c_y = levelData.layout_pos.y
		for k = levelData.pos.Count() - 1 to 0 Step -1
			chipCode = k MOD 42 'REMOVE and use shuffle!

			px = c_x + levelData.pos[k].x
			py = c_y + levelData.pos[k].y
			pz = levelData.heights[k]

			tileItem = m.game.createInstance("tile",{type:chipCode,depth:-pz,id:k})
			tileItem.x = px
			tileItem.y = py
			tileItem.setBlocks(levelData.blocks[k])
			tileItem.setNeighbours(levelData.blocks_list[k]) 'TODO add neighbours Data

			m.arrTiles.Push(tileItem)
		end for
		m.arrTiles.Reverse()
		

		'TODO
		m.selTile_idx = 0
		m.arrTiles[m.selTile_idx].setSelected(true)

		
	end function

	object.onButton = function(code as integer)
		if code >= 0 AND code <= 5 ' Right
			m.trySelectTile(code)
		end if

		if code = 0 then
			m.game.changeRoom("room_menu")
		end if

		if code = 6
			m.arrTiles[m.selTile_idx].setSelected(NOT m.arrTiles[m.selTile_idx].isSelected())
		end if

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
	object.trySelectTile = function(_dir) as boolean

		curr_tile = m.arrTiles[m.selTile_idx]

		'TODO: add recursive search on field

		neighbourID = curr_tile.getNeighbour(_dir)

		if neighbourID >= 0 
			neighbour = m.arrTiles[neighbourID]
			curr_tile.setSelected(false)
			neighbour.setSelected(true)
			m.selTile_idx = neighbourID

			print "tile ";neighbourID.toStr();" blocked = ";m.isBlocked(neighbourID)

			return true
		end if


		return false
	end function
	'********************************************************************
	'	helpers
	'********************************************************************

	'check if tile blocked by it`s index
	object.isBlocked = function(idx) as boolean
		curr_tile = m.arrTiles[idx]
		blockersDIR = curr_tile.getBlocksList()
		if m.arrHasActive(blockersDIR[2]) OR m.arrHasActive(blockersDIR[0]) AND m.arrHasActive(blockersDIR[1]) then
			return true ' blocked by upper layer
		end if

		return false
	end function

	'check tiles present on field
	'input may be tile index or array of tile indexes
	object.arrHasActive = function(arr) as boolean
		if NOT IsValid(arr) return false

		if IsArray(arr) then
			for i = 0 to arr.Count() - 1
				tileID = arr[i]
				if m.arrTiles[tileID].enabled then return true
			end for
		else
			return m.arrTiles[arr].enabled
		end if

		return false
	end function

	
end function