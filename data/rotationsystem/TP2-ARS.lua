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
local pieceARSoffset={
	["I"]={
	[0]={0,0},
	[1]={0,0},
	[2]={0,1},
	[3]={1,0},
	},
	["O"]={
	[0]={0,0},
	[1]={0,0},
	[2]={0,0},
	[3]={0,0},
	},
	["T"]={
	[0]={0,-1},
	[1]={0,0},
	[2]={0,0},
	[3]={0,0},
	},
	["J"]={
	[0]={0,-1},
	[1]={0,0},
	[2]={0,0},
	[3]={0,0},
	},
	["L"]={
	[0]={0,-1},
	[1]={0,0},
	[2]={0,0},
	[3]={0,0},
	},
	["Z"]={
	[0]={0,-1},
	[1]={0,0},
	[2]={0,0},
	[3]={1,0},
	},
	["S"]={
	[0]={0,-1},
	[1]={-1,0},
	[2]={0,0},
	[3]={0,0},
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
		player.piecey = 18
		player.piecerotation = 2
end
local function PreCCW(player)
	if not piececollidetest(player.board,player.piececurrent,3,4,19) then
	player.playsound.prerotate = true
	player.piecerotation = 1
	end
end
local function PreCW(player)
	if not piececollidetest(player.board,player.piececurrent,3,4,19) then
	player.playsound.prerotate = true
	player.piecerotation = 3
	end
end
local function ARSCCW(player)
	player.piecex = player.piecex-pieceARSoffset[player.piececurrent][player.piecerotation][1]
	player.piecey = player.piecey+pieceARSoffset[player.piececurrent][player.piecerotation][2]
	player.piecerotation = modmod(player.piecerotation-1,4)
	player.piecex = player.piecex+pieceARSoffset[player.piececurrent][player.piecerotation][1]
	player.piecey = player.piecey-pieceARSoffset[player.piececurrent][player.piecerotation][2]
end
local function ARSCW(player)
	player.piecex = player.piecex-pieceARSoffset[player.piececurrent][player.piecerotation][1]
	player.piecey = player.piecey+pieceARSoffset[player.piececurrent][player.piecerotation][2]
	player.piecerotation = modmod(player.piecerotation+1,4)
	player.piecex = player.piecex+pieceARSoffset[player.piececurrent][player.piecerotation][1]
	player.piecey = player.piecey-pieceARSoffset[player.piececurrent][player.piecerotation][2]
end
local function CCW(player)
			local rotationfail = false
			local touch = 0
			ARSCCW(player)
			if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
				if player.piececurrent == "I" then
					player.piecex = player.piecex + 1
					if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
						player.piecex = player.piecex - 2
						if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
							player.piecex = player.piecex + 3
							if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
								player.piecex = player.piecex - 2
								rotationfail = true
							end
						end
					end
				elseif player.piececurrent == "O" then
					rotationfail = false
				else
					local touched = false
					for testicies = 2,0,-1 do
						for buff = 2,0,-1 do
							if collidetest(player.board,buff,testicies) then touch = (testicies*3)+(buff+1) end
						end
					end
					if modmod(touch-1,3) == 0 then
						player.piecex = player.piecex + 1
						if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
							player.piecex = player.piecex - 2
							if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
								player.piecex = player.piecex + 1
								rotationfail = true
							end
						end
					elseif modmod(touch-1,3) == 1 then
						rotationfail = true
					elseif modmod(touch-1,3) == 2 then
						player.piecex = player.piecex - 1
						if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
							player.piecex = player.piecex + 2
							if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
								player.piecex = player.piecex - 1
								rotationfail = true
							end
						end
					end
				end
			end
			if not rotationfail then
				player.playsound.rotateleft = true
				if player.piececurrent == "T" then
					player.tspin = tspintest(player.board,player.piecerotation,player.piecex,player.piecey)
					if kicksum == 4 and player.tspin == "mini" then
						player.tspin = "full"
					end
				end
			else
			ARSCW(player)
			end
end
local function CW(player)
			local rotationfail = false
			local touch = 0
			ARSCW(player)
			if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
				if player.piececurrent == "I" then
					player.piecex = player.piecex + 1
					if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
						player.piecex = player.piecex - 2
						if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
							player.piecex = player.piecex + 3
							if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
								player.piecex = player.piecex - 2
								rotationfail = true
							end
						end
					end
				elseif player.piececurrent == "O" then
					rotationfail = false
				else
					local touched = false
					for testicies = 2,0,-1 do
						for buff = 2,0,-1 do
							if collidetest(player.board,buff,testicies) then touch = (testicies*3)+(buff+1) end
						end
					end
					if modmod(touch-1,3) == 0 then
						player.piecex = player.piecex + 1
						if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
							player.piecex = player.piecex - 2
							if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
								player.piecex = player.piecex + 1
								rotationfail = true
							end
						end
					elseif modmod(touch-1,3) == 1 then
						rotationfail = true
					elseif modmod(touch-1,3) == 2 then
						player.piecex = player.piecex - 1
						if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
							player.piecex = player.piecex + 2
							if piececollidetest(player.board,player.piececurrent,player.piecerotation,player.piecex,player.piecey) then
								player.piecex = player.piecex - 1
								rotationfail = true
							end
						end
					end
				end
			end
			if not rotationfail then
				player.playsound.rotateright = true
				if player.piececurrent == "T" then
					player.tspin = tspintest(player.board,player.piecerotation,player.piecex,player.piecey)
					if kicksum == 4 and player.tspin == "mini" then
						player.tspin = "full"
					end
				end
			else
			ARSCCW(player)
			end
end
return {
["InitPosRot"] = InitPosRot,
["PreCCW"] = PreCCW,
["PreCW"] = PreCW,
["CCW"] = CCW,
["CW"] = CW,
}