modem = peripheral.wrap("left")

function GetModem()
	return modem
end

local x,y,z,dir=0,0,0,0

local SavedPosRots={}

StringToDir = {}

StringToDir["+y"] = 0
StringToDir["+x"] = 1
StringToDir["-y"] = 2
StringToDir["-x"] = 3

DirToString = {}

DirToString[0] = "+y"
DirToString[1] = "+x"
DirToString[2] = "-y"
DirToString[3] = "-x"

function GetX()
	modem.transmit(3, 1,"Called: GetX")
	return x
end

function GetY()
	modem.transmit(3, 1,"Called: GetY")
	return y
end

function GetZ()
	modem.transmit(3, 1,"Called: GetZ")
	return z
end

function GetDir()
	modem.transmit(3, 1,"Called: GetDir")
	return DirToString[dir]
end

function Forward()
	modem.transmit(3, 1,"Called: Forward")
	if(dir==0)then
		y= y+1
	end
	if(dir==1)then
		x= x+1
	end
	if(dir==2)then
		y= y-1
	end
	if(dir==3)then
		x= x-1
	end
	modem.transmit(3, 1,"Forward: ",turtle.forward())
end

function Back()
	modem.transmit(3, 1,"Called: Back")
	if(dir==0)then
		y= y-1
	end
	if(dir==1)then
		x= x-1
	end
	if(dir==2)then
		y= y+1
	end
	if(dir==3)then
		x= x+1
	end
	turtle.back()
end

function Up()
	modem.transmit(3, 1,"Called: Up")
	modem.transmit(3, 1,turtle.up())
	z=z+1
end

function Down()
	modem.transmit(3, 1,"Called: Down")
	z=z-1
	turtle.down()
end

function TurnRight()
	modem.transmit(3, 1,"Called: TurnRight")
	if(dir==3) then
		dir=0
	else
		dir=dir+1
	end
	turtle.turnRight()
end

function TurnLeft()
	modem.transmit(3, 1,"Called: TurnLeft")
	if(dir==0) then
		dir=3
	else
		dir=dir-1
	end
	turtle.turnLeft()
end

function FaceDir(direction)
	modem.transmit(3, 1,"Called: FaceDir")
	if(StringToDir[direction]==dir)then
		return
	end
	if(StringToDir[direction]==0 and dir == 1) then
		TurnLeft()
	end
	if(StringToDir[direction]==0 and dir == 2) then
		TurnLeft()
		TurnLeft()
	end
	if(StringToDir[direction]==0 and dir == 3) then
		TurnRight()
	end
	if(StringToDir[direction]==1 and dir == 2) then
		TurnLeft()
	end
	if(StringToDir[direction]==1 and dir == 3) then
		TurnLeft()
		TurnLeft()
	end
	if(StringToDir[direction]==1 and dir == 0) then
		TurnRight()
	end
	if(StringToDir[direction]==2 and dir == 3) then
		TurnLeft()
	end
	if(StringToDir[direction]==2 and dir == 0) then
		TurnLeft()
		TurnLeft()
	end
	if(StringToDir[direction]==2 and dir == 1) then
		TurnRight()
	end
	if(StringToDir[direction]==3 and dir == 0) then
		TurnLeft()
	end
	if(StringToDir[direction]==3 and dir == 1) then
		TurnLeft()
		TurnLeft()
	end
	if(StringToDir[direction]==3 and dir == 2) then
		TurnRight()
	end




end

function MoveDir(direction)
	modem.transmit(3, 1,"Called: MoveDir")
	modem.transmit(3, 1,"MoveDir: dir before:",DirToString[dir])
	FaceDir(direction)
	modem.transmit(3, 1,"MoveDir: dir after:",DirToString[dir])
	Forward()
end

function DigDir(direction)
	modem.transmit(3, 1,"Called: DigDir")
	FaceDir(direction)
	turtle.dig()
	return "tried to dig"
end

function SelectItem(item)
	modem.transmit(3, 1,"Called: SelectItem")
    for s=1,16 do
        turtle.select(s)
        data =turtle.getItemDetail()
        if data~=nil then
        if data.name == item then
            modem.transmit(3, 1,"found: ",item)
            return true
        end
        else
        modem.transmit(3, 1,"no item in slot: ",s)
        end
    end
    modem.transmit(3, 1,"could not find: ",item)
	return false
end

function InspectDown(item)
	modem.transmit(3, 1,"Called: InspectDown")
     local suc, d = turtle.inspectDown()
     if suc then
         modem.transmit(3, 1,d.name)
         if d.name == item then return true end
     else
        modem.transmit(3, 1,"failed inspect")
     end
     return false
end

function InspectUp(item)
	modem.transmit(3, 1,"Called: InspectUp")
     local suc, d = turtle.inspectUp()
     if suc then
         modem.transmit(3, 1,d.name)
         if d.name == item then return true end
     else
        modem.transmit(3, 1,"failed inspect")
     end
     return false
end

function InspectForward(item)
	modem.transmit(3, 1,"Called: InspectForward")
     local suc, d = turtle.inspect()
     if suc then
         modem.transmit(3, 1,d.name)
         if d.name == item then return true end
     else
        modem.transmit(3, 1,"failed inspect")
     end
     return false
end

function InspectBack(item)
	modem.transmit(3, 1,"Called: InspectBack")
	turtle.turnRight()
	turtle.turnRight()
     local suc, d = turtle.inspect()
     if suc then
         modem.transmit(3, 1,d.name)
         if d.name == item then
			 turtle.turnLeft()
			 turtle.turnLeft()
		 return true
		 end
     else
        modem.transmit(3, 1,"failed inspect")
     end
	 turtle.turnLeft()
	 turtle.turnLeft()
     return false
end

function InspectRight(item)
	modem.transmit(3, 1,"Called: InspectRight")
	turtle.turnRight()
     local suc, d = turtle.inspect()
     if suc then
         modem.transmit(3, 1,d.name)
         if d.name == item then
			 turtle.turnLeft()
		 return true
		 end
     else
        modem.transmit(3, 1,"failed inspect")
     end
	 turtle.turnLeft()
     return false
end

function InspectLeft(item)
	modem.transmit(3, 1,"Called: InspectLeft")
	turtle.turnLeft()
     local suc, d = turtle.inspect()
     if suc then
         modem.transmit(3, 1,d.name)
         if d.name == item then
			 turtle.turnRight()
		 return true
		 end
     else
        modem.transmit(3, 1,"failed inspect")
     end
	 turtle.turnRight()
     return false
end

function InspectDir(item,direction)
	modem.transmit(3, 1,"Called: InspectDir")
	tmpdir=DirToString[dir]
	FaceDir(direction)
     local suc, d = turtle.inspect()
     if suc then
         modem.transmit(3, 1,d.name)
         if d.name == item then
		 FaceDir(tmpdir)
		 return true
		 end
     else
        modem.transmit(3, 1,"failed inspect")
     end
	 FaceDir(tmpdir)
     return false
end

function DetectDown()
	modem.transmit(3, 1,"Called: DetectDown")
	return turtle.detectDown()
end

function DetectUp()
	modem.transmit(3, 1,"Called: DetectUp")
	return turtle.detectUp()
end

function DetectForward()
	modem.transmit(3, 1,"Called: DetectForward")
	return turtle.detect()
end

function DetectBack()
	modem.transmit(3, 1,"Called: DetectBack")
	turtle.turnRight()
	turtle.turnRight()
	ret = turtle.detect()
	turtle.turnLeft()
	turtle.turnLeft()
    return ret
end

function DetectRight()
	modem.transmit(3, 1,"Called: DetectRight")
	turtle.turnRight()
	ret = turtle.detect()
	turtle.turnLeft()
    return ret
end

function DetectLeft()
	modem.transmit(3, 1,"Called: DetectLeft")
	turtle.turnLeft()
	ret = turtle.detect()
	turtle.turnRight()
    return ret
end

function DetectDir(direction)
	modem.transmit(3, 1,"Called: DetectDir")
	tmpdir =DirToString[dir]
	FaceDir(direction)
	tmpdet= turtle.detect()
	FaceDir(tmpdir)
	return tmpdet
end

function HomeX()
	modem.transmit(3, 1,"Called: HomeX")
	if x>0 then
		if(not DetectDir("-x")) then
			while x ~= 0 do
				MoveDir("-x")
			end
		end
	else
		if(not DetectDir("+x")) then
			while x~=0 do
				MoveDir("+x")
			end
		end
	end
end
function HomeY()
	modem.transmit(3, 1,"Called: HomeY")
	if y>0 then
		if(not DetectDir("-y")) then
			while y ~= 0 do
				MoveDir("-y")
			end
		end
	else
		if(not DetectDir("+y")) then
			while y~=0 do
				MoveDir("+y")
			end
		end
	end
end
function HomeZ()
	modem.transmit(3, 1,"Called: HomeZ")
	if z>0 then
		if(not DetectDown()) then
			while z ~= 0 do
				Down()
			end
		end
	else
		if(not DetectUp()) then
			while z~=0 do
				Up()
			end
		end
	end
end

function HomeAll()
	modem.transmit(3, 1,"Called: HomeAll")
	while x~=0 and y~=0 and z~=0 do
		HomeX()
		HomeY()
		HomeZ()
	end
	FaceDir("+y")
end

function GoX(dx)
	modem.transmit(3, 1,"Called: GoX")
	if x>dx then
		if(not DetectDir("-x")) then
			while x ~= dx do
				MoveDir("-x")
			end
		end
	else
		if(not DetectDir("+x")) then
			while x~=dx do
				MoveDir("+x")
			end
		end
	end
end

function GoY(dy)
	modem.transmit(3, 1,"Called: GoY")
	if y>dy then
		if(not DetectDir("-y")) then
			while y ~= dy do
				MoveDir("-y")
			end
		end
	else
		if(not DetectDir("+y")) then
			while y~=dy do
				MoveDir("+y")
			end
		end
	end
end

function GoZ(dz)
	modem.transmit(3, 1,"Called: GoZ")
	if z>dz then
		if(not DetectDown()) then
			while z ~= dz do
				Down()
			end
		end
	else
		if(not DetectUp()) then
			while z~=dz do
				Up()
			end
		end
	end
end

function GoTo(dx,dy,dz)
	modem.transmit(3, 1,"Called: GoTO")
		while x~=0 and y~=0 and z~=0 do
		GoX()
		GoY()
		GoZ()
	end
end

function SavePosRot(index)
	modem.transmit(3, 1,"Called: SavePosRot")
	SavedPosRots[index]={}
	SavedPosRots[index]["sx"]=x
	SavedPosRots[index]["sy"]=y
	SavedPosRots[index]["sz"]=z
	SavedPosRots[index]["sdir"]=dir
end

function RestorePosRot(index)
	modem.transmit(3, 1,"Called: RestorePosRot")
	modem.transmit(3, 1,SavedPosRots[index]["sx"])
	modem.transmit(3, 1,SavedPosRots[index]["sy"])
	modem.transmit(3, 1,SavedPosRots[index]["sz"])
	modem.transmit(3, 1,SavedPosRots[index]["sdir"])
	GoTo(SavedPosRots[index]["sx"],SavedPosRots[index]["sy"],SavedPosRots[index]["sz"])
	FaceDir(DirToString[SavedPosRots[index]["sdir"]])
end

function InventoryFull()
	modem.transmit(3, 1,"Called: InventoryFull")
	local NES=0
	for s=1,16 do
		turtle.select(s)
		if turtle.getItemDetail()~= nil then
			NES = NES+1
		end
	end
	if NES==16 then
		return true
	else
		return false
	end
end
