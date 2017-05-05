System.memclean()
screen:clear()
--biblioteki
dofile("gl.lua")
dofile("theme.dat")

S = System

mode=0
showmenu=0
--peremennie

gravity=1
jump=0
MAP={}
for i=1,48 do
table.insert(MAP,{})
for j=1,27 do
table.insert(MAP[i],{})
MAP[i][j]=0
end
end

for i=1,48 do
MAP[i][1]=1
end

for i=1,48 do
MAP[i][27]=1
end

for j=1,27 do
MAP[1][j]=1
end

for j=1,27 do
MAP[48][j]=1
end

function newmap()

for i=1,48 do
for j=1,27 do
MAP[i][j]=0
end
end


for i=1,48 do
MAP[i][1]=1
end

for i=1,48 do
MAP[i][27]=1
end

for j=1,27 do
MAP[1][j]=1
end

for j=1,27 do
MAP[48][j]=1
end
refresh()
end

font=Font.load("rVOL9c0s.ttf")
font:setPixelSizes(7,10)


state=0

selected={}
selected[1]=1
selected[2]=0
selected[3]=0

selected2={}
selected2[1]=1
selected2[2]=0
selected2[3]=0

selected3={}
selected3[1]=1
selected3[2]=0
selected3[3]=0
selected3[4]=0

selected4={}
selected4[1]=1
selected4[2]=0



--cveta
r1=100
g1=100
b1=100

r2=50
g2=50
b2=50

lvl=1

rc=Color.new(255,200,200)
gc=Color.new(200,255,200)
bc=Color.new(200,200,255)


color1=Color.new(r1,g1,b1)
color2=Color.new(r2,g2,b2)

color3=Color.new(255,255,255)
--kartinki

cursor=Image.createEmpty(3,3)
 cx=240
 cy=135

cursor2=Image.createEmpty(11,11)
cursor2:drawLine(1,1,1,11,Color.new(255,255,0))
cursor2:drawLine(1,1,11,1,Color.new(255,255,0))
cursor2:drawLine(1,11,11,11,Color.new(255,255,0))
cursor2:drawLine(11,1,11,11,Color.new(255,255,0))
 c2x=212
 c2y=90
cc=1

cursor:clear(Color.new(255,255,0))
stone=Image.load("themes/"..theme_to_load.."/wall.png")

border=Image.load("themes/"..theme_to_load.."/block.png")

spike=Image.load("themes/"..theme_to_load.."/spike.png")


exit=Image.load("themes/"..theme_to_load.."/exit.png")
 ex=1
 ey=1

key=Image.load("themes/"..theme_to_load.."/key.png")

 keysfound=0
 keysall=0

boy=Image.load("themes/"..theme_to_load.."/player.png")
 boy_x=11
 boy_y=251
 start_x=11
 start_y=251





ImMAP=Image.createEmpty(480,270)

themes = System.listDirectory("/themes")
theme_back=Image.load("img/theme_back.png")
theme_icon={}
vivod1=100
stheme=1

theme_cursor=gl.createCursor(color1)

for theme=3, #themes do
if System.doesFileExist("themes/"..themes[theme].name.."/icon.png")==1 and themes[theme].directory==true then
theme_icon[theme]=Image.load("themes/"..themes[theme].name.."/icon.png")
else
theme_icon[theme]=border
end
end

function refresh()
for i=1,48 do
for j=1,27 do
if MAP[i][j]==0 then
ImMAP:blit(i*10-10,j*10-10,stone)
end
if MAP[i][j]==1 then
ImMAP:blit(i*10-10,j*10-10,border)
end
if MAP[i][j]==2 then
ImMAP:blit(i*10-10,j*10-10,exit)
end
if MAP[i][j]==3 then
ImMAP:blit(i*10-10,j*10-10,spike)
end
if MAP[i][j]==4 then
ImMAP:blit(i*10-10,j*10-10,key)
end
end
end
end

t=0

--funzii

function screensave()
file=io.open("screenshot/scrnum.txt","r")
scrnumber=tonumber(file:read())
file:close()
screen:save("screenshot/scr"..scrnumber..".png")
scrnumber=scrnumber+1
file=io.open("screenshot/scrnum.txt","w")
file:write(scrnumber)
file:close()
end

function savemap()
filename=System.startOSK("maps/user/1.jump","Map directory")
if filename ~= "" then
file=io.open(filename,"w")
file:write("start_x="..boy_x.." start_y="..boy_y.."\n")
file:write("keysall="..keysall.." keysfound=0".."\n")
for i=1,48 do
for j=1,27 do
file:write("MAP["..i.."]["..j.."]="..MAP[i][j].."\n")
end
end
file:write("ex="..ex.." ey="..ey.."\n")
file:close()
end
end

function browse_themes()
screen:blit(0, 0, theme_back)
screen:blit(30, 142, theme_cursor)
for theme=3, #themes do
screen:blit(35, vivod1+theme*15, theme_icon[theme], yellow)
if themes[theme].directory==true then
screen:print(50, vivod1+theme*15, themes[theme].name, yellow)
end
end
if pad:down() and oldpad:down() ~= pad:down() then
if stheme<#themes-2 then
stheme=stheme+1
vivod1=vivod1-15
end
end
if pad:up() and oldpad:up() ~= pad:up() then
if stheme>1 then
stheme=stheme-1
vivod1=vivod1+15
end
end
if pad:cross() and oldpad:cross() ~= pad:cross() then

theme_to_load=themes[2+stheme].name
file=io.open("theme.dat", "w")
file:write("theme_to_load='"..theme_to_load.."'")
file:close()

System.message("Start game again", 0)
System.Quit()

end
if pad:circle() and oldpad:circle() ~= pad:circle() then
state=0
end
screen:print(1,1,theme_to_load)

end

function loadmap(filename)
if filename~="" then
dofile(filename)
boy_x=start_x
boy_y=start_y

refresh()
end
end


function mapsettings()
if k==1 then
back=Image.createEmpty(480,270)
back:clear(color2)
k=0
end
screen:blit(0,0,back)
screen:print(175,30,"Map settings:",color1)
screen:print(150,80,"Map title: ",color1)

screen:print(150,100,"Color scheme: ",color1)
 screen:blit(260,100,border)
 screen:print(300,100,r1,rc)
 screen:print(340,100,g1,gc)
 screen:print(380,100,b1,bc)

screen:print(150,120,"Player start coordinatess: ",color1)
 screen:print(155,140,"X: "..start_x,Color.new(255,255,255))
 screen:print(215,140,"Y: "..start_y,Color.new(255,255,255))


end

function nextmap()
lvl=lvl+1
loadmap("maps/off/"..lvl..".jump")
refresh()
end

refresh()

function menu()
if keysall>0 then
keysall=0
keyfound=0
end

if menuback==nil then
menuback=Image.load("screenshot/head.png")
end
screen:blit(0,0,menuback)
if selected[1]==1 then
screen:fontPrint(font,195,200,"Play",Color.new(255,255,0))
else
screen:fontPrint(font,195,200,"Play",Color.new(255,255,255))
end
if selected[2]==1 then
screen:fontPrint(font,195,215,"Map creator",Color.new(255,255,0))
else
screen:fontPrint(font,195,215,"Map creator",Color.new(255,255,255))
end
if selected[3]==1 then
screen:fontPrint(font,195,230,"Themes",Color.new(255,255,0))
else
screen:fontPrint(font,195,230,"Themes",Color.new(255,255,255))
end
if selected[4]==1 then
screen:fontPrint(font,195,245,"Exit",Color.new(255,255,0))
else
screen:fontPrint(font,195,245,"Exit",Color.new(255,255,255))
end



if pad:cross() and oldpad:cross() ~= pad:cross() then
if selected[1]==1 then
changemode=0
state=1
elseif selected[2]==1 then
changemode=1
state=2
elseif selected[3]==1 then
state=10
elseif selected[4]==1 then
System.Quit()
end
end

if pad:down() and oldpad:down() ~= pad:down() then
if selected[1]==1 then
selected[1]=0
selected[2]=1
elseif selected[2]==1 then
selected[2]=0
selected[3]=1
elseif selected[3]==1 then
selected[3]=0
selected[4]=1
elseif selected[4]==1 then
selected[4]=0
selected[1]=1
end
end
if pad:up() and oldpad:up() ~= pad:up() then
if selected[1]==1 then
selected[1]=0
selected[4]=1
elseif selected[2]==1 then
selected[2]=0
selected[1]=1
elseif selected[3]==1 then
selected[3]=0
selected[2]=1
elseif selected[4]==1 then
selected[4]=0
selected[3]=1
end
end
end

function menu2()
if menuback==nil then
menuback=Image.load("screenshot/scr2.png")
end
screen:blit(0,0,menuback)



 if selected2[1]==1 then
  screen:fontPrint(font,195,200,"Official levels",Color.new(255,255,0))
 else
  screen:fontPrint(font,195,200,"Official levels",Color.new(255,255,255))
 end

 if selected2[2]==1 then
  screen:fontPrint(font,195,215,"Custom levels",Color.new(255,255,0))
 else
  screen:fontPrint(font,195,215,"Custom levels",Color.new(255,255,255))
 end

if pad:down() and oldpad:down() ~= pad:down() then
if selected2[1]==1 then
selected2[1]=0
selected2[2]=1
elseif selected2[2]==1 then
selected2[2]=0
selected2[1]=1
end
end
if pad:up() and oldpad:up() ~= pad:up() then
if selected2[1]==1 then
selected2[1]=0
selected2[2]=1
elseif selected2[2]==1 then
selected2[2]=0
selected2[1]=1
end
end


if pad:cross() and oldpad:cross() ~= pad:cross() then
if selected2[1]==1 then
mapstoshow="off"
state=1.5
elseif selected2[2]==1 then
maptoload = System.startOSK("maps/user/1.jump","Open path")

if System.doesFileExist(maptoload)==1 then
loadmap(maptoload)
state=2
end
end
end
end

mapsimg=Image.load("mapsback.png")

function drawmaps()







end

function movecursor2()
if pad:left() and oldpad:left() ~= pad:left() and c2x>=227 then
cc=cc-1
c2x=c2x-15
end
if pad:right() and oldpad:right() ~= pad:right() and c2x<=257 then
cc=cc+1
c2x=c2x+15
end
if pad:down() and oldpad:down() ~= pad:down() and c2y<=105 then
cc=cc+5
c2y=c2y+15
end
if pad:up() and oldpad:up() ~= pad:up() and c2y>=105 then
cc=cc-5
c2y=c2y-15
end

if pad:cross() and oldpad:cross() ~= pad:cross() then
lvl=cc
loadmap("maps/off/"..lvl..".jump")
state=2
end

screen:blit(c2x,c2y,cursor2)
end

function ingamemenu(v)
if v==1 then
 if selected3[1]==1 then
  screen:fontPrint(font,195,200,"Resume game",Color.new(255,255,0))
 else
  screen:fontPrint(font,195,200,"Resume game",Color.new(255,255,255))
 end

 if selected3[2]==1 then
  screen:fontPrint(font,195,215,"Exit to menu",Color.new(255,255,0))
 else
  screen:fontPrint(font,195,215,"Exit to menu",Color.new(255,255,255))
 end

if pad:down() and oldpad:down() ~= pad:down() then
if selected3[1]==1 then
selected3[1]=0
selected3[2]=1
elseif selected3[2]==1 then
selected3[2]=0
selected3[1]=1
end
end
if pad:up() and oldpad:up() ~= pad:up() then
if selected2[1]==1 then
selected2[1]=0
selected2[2]=1
elseif selected2[2]==1 then
selected2[2]=0
selected2[1]=1
end
end

if pad:cross() and oldpad:cross() ~= pad:cross() then
if selected3[1]==1 then
showmenu=0
elseif selected3[2]==1 then
showmenu=0
state=0
end
end

elseif v==2 then
 if selected3[1]==1 then
  screen:fontPrint(font,195,200,"Resume game",Color.new(255,255,0))
 else
  screen:fontPrint(font,195,200,"Resume game",Color.new(255,255,255))
 end

 if selected3[2]==1 then
  screen:fontPrint(font,195,215,"Save map",Color.new(255,255,0))
 else
  screen:fontPrint(font,195,215,"Save map",Color.new(255,255,255))
 end

 if selected3[3]==1 then
  screen:fontPrint(font,195,230,"Load map",Color.new(255,255,0))
 else
  screen:fontPrint(font,195,230,"Load map",Color.new(255,255,255))
 end

 if selected3[4]==1 then
  screen:fontPrint(font,195,245,"Exit to menu",Color.new(255,255,0))
 else
  screen:fontPrint(font,195,245,"Exit to menu",Color.new(255,255,255))
 end



if pad:down() and oldpad:down() ~= pad:down() then
if selected3[1]==1 then
selected3[1]=0
selected3[2]=1
elseif selected3[2]==1 then
selected3[2]=0
selected3[3]=1
elseif selected3[3]==1 then
selected3[3]=0
selected3[4]=1
elseif selected3[4]==1 then
selected3[4]=0
selected3[1]=1
end
end
if pad:up() and oldpad:up() ~= pad:up() then
if selected3[1]==1 then
selected3[1]=0
selected3[4]=1
elseif selected3[2]==1 then
selected3[2]=0
selected3[1]=1
elseif selected3[3]==1 then
selected3[3]=0
selected3[2]=1
elseif selected3[4]==1 then
selected3[4]=0
selected3[3]=1
end
end

if pad:cross() and oldpad:cross() ~= pad:cross() then
if selected3[1]==1 then
showmenu=0
elseif selected3[2]==1 then
savemap()
elseif selected3[3]==1 then
name=System.startOSK("maps/user/1.jump","Load path")
loadmap(name)
elseif selected3[4]==1 then
state=0
changemode=0
showmenu=0
newmap()
end
end

end
end



o=nil
p=nil

while true do
oldpad=pad
pad=Controls.read()
screen:clear()


if state==0 then
menu()


elseif state==1 then
menu2()

elseif state==1.5 then

screen:blit(0,0,mapsimg)
movecursor2()

elseif state==10 then
browse_themes()


elseif state==2 then
--rendering

screen:blit(0,0,ImMAP)

boy_x2=math.ceil((boy_x)/10)
boy_y2=math.ceil((boy_y)/10)

if changemode==1 then
if p==nil then
newmap()
p=0
end
if cy>50 and mode==0 then
screen:print(1,1,"SELECT to enter change mode",Color.new(255,255,0))
screen:print(1,16,"Keys: "..keysall,Color.new(255,255,0))
screen:print(280,1,"Player coords: "..boy_x..","..boy_y,Color.new(255,255,0))
screen:print(280,16,"Player coords(/10): "..boy_x2..","..boy_y2,Color.new(255,255,0))
end
if cy>50 and mode==1 then
screen:print(1,1,"SELECT to game mode",Color.new(255,255,0))
screen:print(280,1,"Cursor coords: "..cx..", "..cy,Color.new(255,255,0))
screen:print(280,16,"Player coords: "..boy_x..", "..boy_y,Color.new(255,255,0))
screen:print(1,16,"CROSS to place block/delete block",Color.new(255,255,0))
screen:print(1,31,"SQUARE to place spikes",Color.new(255,255,0))
screen:print(1,46,"R to place exit, TRIANGLE to place key",Color.new(255,255,0))
end
screen:print(340,260,"L to reset map",Color.new(255,255,0))
screen:print(1,260,"START to open menu",Color.new(255,255,0))


end




if mode==0 then
if showmenu==0 then
if pad:left() then
if MAP[math.ceil((boy_x-2)/10)][math.ceil((boy_y)/10)]~=1 and
   MAP[math.ceil((boy_x-2)/10)][math.ceil((boy_y+9)/10)]~=1 then
boy_x=boy_x-2
elseif 
   MAP[math.ceil((boy_x-1)/10)][math.ceil((boy_y)/10)]~=1 and
   MAP[math.ceil((boy_x-1)/10)][math.ceil((boy_y+9)/10)]~=1 then
boy_x=boy_x-1
end
end

if pad:right() then
if MAP[math.ceil((boy_x+11)/10)][math.ceil((boy_y)/10)]~=1 and
   MAP[math.ceil((boy_x+11)/10)][math.ceil((boy_y+9)/10)]~=1 then
boy_x=boy_x+2
elseif 
   MAP[math.ceil((boy_x+10)/10)][math.ceil((boy_y)/10)]~=1 and
   MAP[math.ceil((boy_x+10)/10)][math.ceil((boy_y+9)/10)]~=1 then
boy_x=boy_x+1
end
end
end

if MAP[math.ceil((boy_x)/10)][math.ceil((boy_y+11)/10)]~=1 and
   MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y+11)/10)]~=1 then

if t>-10 then
t=t-1
end
else
t=0
jump=0
end


if MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y)/10)]==1 or
   MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y+9)/10)]==1 then
t=0
end


if changemode==0 and keysfound==keysall then
if MAP[math.ceil((boy_x)/10)][math.ceil((boy_y)/10)]==2 then
nextmap()
end
if MAP[math.ceil((boy_x)/10)][math.ceil((boy_y+9)/10)]==2 then
nextmap()
end
if MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y)/10)]==2 then
nextmap()
end
if MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y+9)/10)]==2 then
nextmap()
end
end








if MAP[math.ceil((boy_x)/10)][math.ceil((boy_y)/10)]==3 then
boy_x=start_x
boy_y=start_y
end
if MAP[math.ceil((boy_x)/10)][math.ceil((boy_y+9)/10)]==3 then
boy_x=start_x
boy_y=start_y
end
if MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y)/10)]==3 then
boy_x=start_x
boy_y=start_y
end
if MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y+9)/10)]==3 then
boy_x=start_x
boy_y=start_y
end






if changemode==0 then
if MAP[math.ceil((boy_x)/10)][math.ceil((boy_y)/10)]==4 then
keysfound=keysfound+1
MAP[math.ceil((boy_x)/10)][math.ceil((boy_y)/10)]=0
refresh()
end
if MAP[math.ceil((boy_x)/10)][math.ceil((boy_y+9)/10)]==4 then
keysfound=keysfound+1
MAP[math.ceil((boy_x)/10)][math.ceil((boy_y+9)/10)]=0
refresh()
end
if MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y)/10)]==4 then
keysfound=keysfound+1
MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y)/10)]=0
refresh()
end
if MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y+9)/10)]==4 then
keysfound=keysfound+1
MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y+9)/10)]=0
refresh()
end
end


else




if showmenu==0 then
if pad:left() then
cx=cx-2
end

if pad:right() then
cx=cx+2
end

if pad:up() then
cy=cy-2
end

if pad:down() then
cy=cy+2
end

end
end

if mode==1 and showmenu==0 then
if pad:cross() and oldpad:cross() ~= pad:cross() then
if MAP[math.ceil(cx/10)][math.ceil(cy/10)]==1 then
MAP[math.ceil(cx/10)][math.ceil(cy/10)]=0
refresh()
elseif MAP[math.ceil(cx/10)][math.ceil(cy/10)]==4 then
keysall=keysall-1
MAP[math.ceil(cx/10)][math.ceil(cy/10)]=1
refresh()
else
MAP[math.ceil(cx/10)][math.ceil(cy/10)]=1
refresh()
end
end

if pad:r() and oldpad:r() ~= pad:r() then
if MAP[ex][ey]~=2 then
if MAP[math.ceil(cx/10)][math.ceil(cy/10)]==4 then
keysall=keysall-1
end
MAP[math.ceil(cx/10)][math.ceil(cy/10)]=2
ex=math.ceil(cx/10)
ey=math.ceil(cy/10)
refresh()
else
if MAP[math.ceil(cx/10)][math.ceil(cy/10)]==4 then
keysall=keysall-1
end
MAP[ex][ey]=0
MAP[math.ceil(cx/10)][math.ceil(cy/10)]=2
ex=math.ceil(cx/10)
ey=math.ceil(cy/10)
refresh()
end
end


else


if pad:cross() and jump==0 and showmenu==0 then
if MAP[math.ceil((boy_x+5)/10)][math.ceil((boy_y-1)/10)]~=1 then
t=10
jump=1
end
end
end


boy_y=boy_y-t

if boy_y>272 then
boy_x=start_x
boy_y=start_y
end

while MAP[math.ceil((boy_x)/10)][math.ceil((boy_y)/10)]==1 or
      MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y)/10)]==1 do
boy_y=boy_y+1
end

while MAP[math.ceil((boy_x)/10)][math.ceil((boy_y+9)/10)]==1 or
      MAP[math.ceil((boy_x+9)/10)][math.ceil((boy_y+9)/10)]==1 do
boy_y=boy_y-1
end






screen:blit(boy_x-1,boy_y-1,boy)





if mode==1 then
screen:blit(cx,cy,cursor)
end

--screen:print(30,30,t)

if pad:select() and oldpad:select() ~= pad:select() and changemode==1 then
if mode==1 then
mode=0
else
mode=1
end
end

if pad:triangle() and oldpad:triangle() ~= pad:triangle() and changemode==1 then
if MAP[math.ceil(cx/10)][math.ceil(cy/10)]==4 then
MAP[math.ceil(cx/10)][math.ceil(cy/10)]=4
refresh()
else
keysall=keysall+1
MAP[math.ceil(cx/10)][math.ceil(cy/10)]=4
refresh()
end
end

if pad:l() and oldpad:l() ~= pad:l() and changemode==1 then
newmap()
end

if pad:square() and oldpad:square() ~= pad:square() and changemode==1 then
if MAP[math.ceil(cx/10)][math.ceil(cy/10)]==4 then
keysall=keysall-1
MAP[math.ceil(cx/10)][math.ceil(cy/10)]=3
refresh()
else
MAP[math.ceil(cx/10)][math.ceil(cy/10)]=3
refresh()
--mapsettings()
end
end

if pad:circle() and oldpad:circle() ~= pad:circle() then
screensave()
end
end


if pad:start() and oldpad:start() ~= pad:start() then
if state==2 then
if showmenu==1  then
 showmenu=0 
else
 showmenu=1 
end
--break
end
end

if showmenu==1 then
if changemode==0 then
ingamemenu(1)
else
ingamemenu(2)
end
end

if changemode==0 and state==2 and keysall>0 then
screen:fontPrint(font,1,11,"Keys needed: "..(keysall-keysfound),Color.new(255,255,0))
end
if state==2 then
--screen:print(30,30,jump)
end
screen:flip()
end
