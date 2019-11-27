local args ={...}
if #args == 0 then
print("Usage: flatten <x> <y>")
return
end
local maxx = tonumber(args[1])
local maxy = tonumber(args[2])
local zcounter = 0
local turnRight =true

function inspectDown()
    print("called inspect")
     local suc, d = turtle.inspectDown()
     if suc then
         print(d.name)
         if d.name == "minecraft:dirt" then return true end
         if d.name == "minecraft:grass" then return true end
     else
        print("failed inspect")
     end
     return false
end

function selectItem(item)
    for s=1,16 do
        turtle.select(s)
        data =turtle.getItemDetail()
        if data~=nil then
        if data.name == item then
            print("found: ",item)
            return
        end
        else
        print("no item in slot: ",s)
        end
    end    
    print("could not find: ",item)
end

for i=1,maxx do
    for j=1,maxy do
        if not inspectDown() then
            turtle.digDown()
            selectItem("minecraft:dirt")
            turtle.placeDown()
    end
        
        if(turtle.getFuelLevel()==0)then
            selectItem("minecraft:coal")
            turtle.refuel(1)
        end
        
        while turtle.detectUp() do
            turtle.digUp()
            turtle.up()
            zcounter=zcounter+1
        end
        while (zcounter~=0)do
            turtle.down()
            zcounter=zcounter-1
        end
        if turtle.detect() then
        turtle.dig()
        end
        turtle.forward()
    end
    if turnRight then
    turtle.turnRight()
    turtle.dig()
    if not inspectDown() then
            turtle.digDown()
            selectItem("minecraft:dirt")
            turtle.placeDown()
    end
    while turtle.detectUp() do
            turtle.digUp()
            turtle.up()
            zcounter=zcounter+1
        end
        while (zcounter~=0)do
            turtle.down()
            zcounter=zcounter-1
        end
    turtle.forward()
    turtle.turnRight()
    else
    turtle.turnLeft()
    turtle.dig()
    if not inspectDown() then
            turtle.digDown()
            selectItem("minecraft:dirt")
            turtle.placeDown()
    end
    while turtle.detectUp() do
            turtle.digUp()
            turtle.up()
            zcounter=zcounter+1
        end
        while (zcounter~=0)do
            turtle.down()
            zcounter=zcounter-1
        end
    turtle.forward()
    turtle.turnLeft()
    end
    turnRight = not turnRight
end
