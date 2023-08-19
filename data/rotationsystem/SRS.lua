local piecekicks={
	["CW"]={
	[0]={
	{-1,0},{-1,1},{0,-2},{-1,-2},
	},
	[1]={
	{1,0},{1,-1},{0,2},{1,2},
	},
	[2]={
	{1,0},{1,1},{0,-2},{1,-2},
	},
	[3]={
	{-1,0},{-1,-1},{0,2},{-1,2},
	},
	},
	["CCW"]={
	[0]={
	{1,0},{1,1},{0,-2},{1,-2},
	},
	[1]={
	{1,0},{1,-1},{0,2},{1,2},
	},
	[2]={
	{-1,0},{-1,1},{0,-2},{-1,-2},
	},
	[3]={
	{-1,0},{-1,-1},{0,2},{-1,2},
	},
	},
	}
local ipiecekicks={
	["CW"]={
	[0]={
	{-2,0},{1,0},{-2,-1},{1,2},
	},
	[1]={
	{-1,0},{2,0},{-1,2},{2,-1},
	},
	[2]={
	{2,0},{-1,0},{2,1},{-1,-2},
	},
	[3]={
	{1,0},{-2,0},{1,-2},{-2,1},
	},
	},
	["CCW"]={
	[0]={
	{-1,0},{2,0},{-1,2},{2,-1},
	},
	[1]={
	{2,0},{-1,0},{2,1},{-1,-2},
	},
	[2]={
	{1,0},{-2,0},{1,-2},{-2,1},
	},
	[3]={
	{-2,0},{1,0},{2,1},{-1,-2},
	},
	},
	}
local piecetype={
	["I"]={
	[0]={
	{0,0,0,0},
	{1,1,1,1},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,0,1,0},
	{0,0,1,0},
	{0,0,1,0},
	{0,0,1,0},
	},
	[2]={
	{0,0,0,0},
	{0,0,0,0},
	{1,1,1,1},
	{0,0,0,0},
	},
	[3]={
	{0,1,0,0},
	{0,1,0,0},
	{0,1,0,0},
	{0,1,0,0},
	},
	},
	["O"]={
	[0]={
	{0,1,1,0},
	{0,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,1,1,0},
	{0,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[2]={
	{0,1,1,0},
	{0,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[3]={
	{0,1,1,0},
	{0,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	},
	["T"]={
	[0]={
	{0,1,0,0},
	{1,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,1,0,0},
	{0,1,1,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	[2]={
	{0,0,0,0},
	{1,1,1,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	[3]={
	{0,1,0,0},
	{1,1,0,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	},
	["J"]={
	[0]={
	{1,0,0,0},
	{1,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,1,1,0},
	{0,1,0,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	[2]={
	{0,0,0,0},
	{1,1,1,0},
	{0,0,1,0},
	{0,0,0,0},
	},
	[3]={
	{0,1,0,0},
	{0,1,0,0},
	{1,1,0,0},
	{0,0,0,0},
	},
	},
	["L"]={
	[0]={
	{0,0,1,0},
	{1,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,1,0,0},
	{0,1,0,0},
	{0,1,1,0},
	{0,0,0,0},
	},
	[2]={
	{0,0,0,0},
	{1,1,1,0},
	{1,0,0,0},
	{0,0,0,0},
	},
	[3]={
	{1,1,0,0},
	{0,1,0,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	},
	["Z"]={
	[0]={
	{1,1,0,0},
	{0,1,1,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,0,1,0},
	{0,1,1,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	[2]={
	{0,0,0,0},
	{1,1,0,0},
	{0,1,1,0},
	{0,0,0,0},
	},
	[3]={
	{0,1,0,0},
	{1,1,0,0},
	{1,0,0,0},
	{0,0,0,0},
	},
	},
	["S"]={
	[0]={
	{0,1,1,0},
	{1,1,0,0},
	{0,0,0,0},
	{0,0,0,0},
	},
	[1]={
	{0,1,0,0},
	{0,1,1,0},
	{0,0,1,0},
	{0,0,0,0},
	},
	[2]={
	{0,0,0,0},
	{0,1,1,0},
	{1,1,0,0},
	{0,0,0,0},
	},
	[3]={
	{1,0,0,0},
	{1,1,0,0},
	{0,1,0,0},
	{0,0,0,0},
	},
	},
	}
function collidetest(board,x,y)
	local clipping = false
	if x <= 0 or x >= 11 or (y <= 0 and (x <= 0 or x >= 11)) or y >= 41 then
		clipping = true
	else
		if y >= 1 then
			if board[y][x] ~= "E" then
				clipping = true
			end
		end
	end
	return clipping
end
local function piececollidetest(board,piecetyperr,rotation,x,y)
	clipping = false
	for pies2 = 1 ,4 do
		for pies1 = 1 ,4 do
			if piecetype[piecetyperr][rotation][pies2][pies1] == 1 then
				if collidetest(board,x+pies1-1,y+pies2-1) == true then
					clipping = true
				end
			end
		end
	end
	return clipping
end
local function tspintest(board,rotation,x,y)
	local tspin = "no"
	local tspina = collidetest(board,x,y)
	local tspinb = collidetest(board,x+2,y)
	local tspinc = collidetest(board,x,y+2)
	local tspind = collidetest(board,x+2,y+2)
	if rotation == 0 or rotation == 2 then
		if tspina and tspinb and (tspinc or tspind) then
			tspin = rotation == 0 and "full" or "mini"
		elseif tspinc and tspind and (tspina or tspinb) then
			tspin = rotation == 2 and "full" or "mini"
		end
	elseif rotation == 1 or rotation == 3 then
		if tspinb and tspind and (tspina or tspinc) then
			tspin = rotation == 1 and "full" or "mini"
		elseif tspina and tspinc and (tspinb or tspind) then
			tspin = rotation == 3 and "full" or "mini"
		end
	end
	return tspin
end
local function modmod(a,b)return a-math.floor(a/b)*b end
local function InitPosRot(player)
		player.piecex = 4
		player.piecey = 19
		player.piecerotation = 0
end
local function PreCCW(player)
	if not piececollidetest(player.board,player.piececurrent,3,4,19) then
	player.playsound.prerotate = true
	player.piecerotation = 3
	end
end
local function PreCW(player)
	if not piececollidetest(player.board,player.piececurrent,3,4,19) then
	player.playsound.prerotate = true
	player.piecerotation = 1
	end
end
local function CCW(player)
			local kicklol = player.piecerotation
			local kicksum = 0
			player.piecerotation = modmod(player.piecerotation-1,4)
			if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
			while piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) do
				kicksum = kicksum + 1
				if kicksum > 4 then
					player.piecerotation = modmod(player.piecerotation+1,4)
				else
					if player.piececurrent == "I" then
						player.piecex = player.piecex+ipiecekicks["CCW"][kicklol][kicksum][1]
						player.piecey = player.piecey-ipiecekicks["CCW"][kicklol][kicksum][2]
						if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
							player.piecex = player.piecex-ipiecekicks["CCW"][kicklol][kicksum][1]
							player.piecey = player.piecey+ipiecekicks["CCW"][kicklol][kicksum][2]
						end
					else
						player.piecex = player.piecex+piecekicks["CCW"][kicklol][kicksum][1]
						player.piecey = player.piecey-piecekicks["CCW"][kicklol][kicksum][2]
						if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
							player.piecex = player.piecex-piecekicks["CCW"][kicklol][kicksum][1]
							player.piecey = player.piecey+piecekicks["CCW"][kicklol][kicksum][2]
						end
					end
				end
			end
			end
			if kicksum <= 4 then
				player.playsound.rotateleft = true
				if player.piececurrent == "T" then
					player.tspin = tspintest(player.board,player.piecerotation,player.piecex,player.piecey)
					if kicksum == 4 and player.tspin == "mini" then
						player.tspin = "full"
					end
				end
				if player.locktime < 30 then
					player.locktime = 30
					player.rotreset = player.rotreset - 1
				end
			end
end
local function CW(player)
			local kicklol = player.piecerotation
			local kicksum = 0
			player.piecerotation = modmod(player.piecerotation+1,4)
			if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
			while piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) do
				kicksum = kicksum + 1
				if kicksum > 4 then
				player.piecerotation = modmod(player.piecerotation-1,4)
				else
					if player.piececurrent == "I" then
						player.piecex = player.piecex+ipiecekicks["CW"][kicklol][kicksum][1]
						player.piecey = player.piecey-ipiecekicks["CW"][kicklol][kicksum][2]
						if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
							player.piecex = player.piecex-ipiecekicks["CW"][kicklol][kicksum][1]
							player.piecey = player.piecey+ipiecekicks["CW"][kicklol][kicksum][2]
						end
					else
						player.piecex = player.piecex+piecekicks["CW"][kicklol][kicksum][1]
						player.piecey = player.piecey-piecekicks["CW"][kicklol][kicksum][2]
						if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
							player.piecex = player.piecex-piecekicks["CW"][kicklol][kicksum][1]
							player.piecey = player.piecey+piecekicks["CW"][kicklol][kicksum][2]
						end
					end
				end
			end
			end
			if kicksum <= 4 then
				player.playsound.rotateright = true
				if player.piececurrent == "T" then
					player.tspin = tspintest(player.board,player.piecerotation,player.piecex,player.piecey)
					if kicksum == 4 and player.tspin == "mini" then
						player.tspin = "full"
					end
				end
				if player.locktime < 30 then
					player.locktime = 30
					player.rotreset = player.rotreset - 1
				end
			end
end
return {
["InitPosRot"] = InitPosRot,
["PreCCW"] = PreCCW,
["PreCW"] = PreCW,
["CCW"] = CCW,
["CW"] = CW,
}