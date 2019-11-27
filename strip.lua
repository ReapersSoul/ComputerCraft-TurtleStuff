if not os.loadAPI("TApi.lua")then
	return
end

function getFuel()
TApi.HomeAll()
TApi.Up()
TApi.TurnLeft()
turtle.suck()
TApi.Down()
TApi.TurnRight()
end

function Deposit()
	TApi.HomeAll()
	TApi.TurnLeft()
	for s=1,16 do
		turtle.select(s)
		turtle.drop()
	end
	TApi.TurnRight()
end

local args ={...}
if #args == 0 then
print("Usage: strip <width> <hight>")
return
end

width = args[1]

hight = args[2]

while true do
	while TApi.GetX()~=width-2 do
		while TApi.GetZ()~=hight-1 do
			if(turtle.getFuelLevel()==0)then
				if not TApi.SelectItem("minecraft:coal") then
					TApi.SavePosRot()
					getFuel()
					Deposit()
					if not TApi.SelectItem("minecraft:coal") then
						return
					end
					TApi.RestorePosRot()
				end
				turtle.refuel(1)
			end
			if TApi.InventoryFull() then
				TApi.SavePosRot()
				Deposit()
				TApi.RestorePosRot()
			end

			print(TApi.GetZ(),"<-Z hight->",hight)
			turtle.digUp()
			TApi.Up()
		end
		TApi.HomeZ()
		print ("digdir: ",TApi.DigDir("+x"))
		TApi.MoveDir("+x")
	end
	TApi.HomeX()
	TApi.Forward()
end
