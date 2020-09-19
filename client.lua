loadstring(exports.dgs:dgsImportFunction())()-- load functions
local screenW,screenH = dgsGetScreenSize()
window = dgsCreateWindow((screenW-700)/2,(screenH-700)/2,700,700,"Интерфейс пользователей",false,0xFFE0E0E0,28,nil,0xFF202020,nil,0xFF101010,5,true)
dgsWindowSetSizable(window,false)
dgsSetVisible(window,false)

font = dgsCreateFont("assets/font.ttf",8)

button1 = dgsCreateButton(13,114,216,32,"Добавить нового пользователя",false,window,0xFFE0E0E0,1,1,nil,nil,nil,0xFF181818,0xFF303030,0xFFA00000)
button2 = dgsCreateButton(10,592,340,32,"Применить изменение данных пользователя",false,window,0xFFE0E0E0,1,1,nil,nil,nil,0xFF181818,0xFF303030,0xFFA00000)
button3 = dgsCreateButton(10,632,680,32,"Удалить из базы пользователя",false,window,0xFFE0E0E0,1,1,nil,nil,nil,0xFF181818,0xFF303030,0xFFA00000)
button4 = dgsCreateButton(351,592,339,32,"Найти пользователя",false,window,0xFFE0E0E0,1,1,nil,nil,nil,0xFF181818,0xFF303030,0xFFA00000)
edit1 = dgsCreateEdit(13,25,216,24,"",false,window,0xFFE0E0E0,1,1,nil,0xFF202020)
edit2 = dgsCreateEdit(13,55,216,24,"",false,window,0xFFE0E0E0,1,1,nil,0xFF202020)
edit3 = dgsCreateEdit(13,85,216,24,"",false,window,0xFFE0E0E0,1,1,nil,0xFF202020)
edit4 = dgsCreateEdit(10,516,340,24,"",false,window,0xFFE0E0E0,1,1,nil,0xFF202020)
edit5 = dgsCreateEdit(10,540,340,24,"",false,window,0xFFE0E0E0,1,1,nil,0xFF202020)
edit6 = dgsCreateEdit(10,564,340,24,"",false,window,0xFFE0E0E0,1,1,nil,0xFF202020)
edit7 = dgsCreateEdit(350,516,340,24,"",false,window,0xFFE0E0E0,1,1,nil,0xFF202020)
edit8 = dgsCreateEdit(350,540,340,24,"",false,window,0xFFE0E0E0,1,1,nil,0xFF202020)
edit9 = dgsCreateEdit(350,564,340,24,"",false,window,0xFFE0E0E0,1,1,nil,0xFF202020)
grid1 = dgsCreateGridList(10,156,340,350,false,window,26,0xFF202020,0xFFE0E0E0,0xFF202020,0xFF202020,0xFF808080,0xFFA00000)
grid1column1 = dgsGridListAddColumn(grid1,"Имя",0.3)
grid1column2 = dgsGridListAddColumn(grid1,"Фамилия",0.3)
grid1column3 = dgsGridListAddColumn(grid1,"Адрес",0.3)
grid2 = dgsCreateGridList(351,156,339,350,false,window,26,0xFF202020,0xFFE0E0E0,0xFF202020,0xFF202020,0xFF808080,0xFFA00000)
grid2column1 = dgsGridListAddColumn(grid2,"Имя",0.3)
grid2column2 = dgsGridListAddColumn(grid2,"Фамилия",0.3)
grid2column3 = dgsGridListAddColumn(grid2,"Адрес",0.3)
text1 = dgsCreateLabel(351,128,339,24,"Поле поиска пользователя",false,window)

dgsLabelSetHorizontalAlign(text1,"center",false)
dgsLabelSetVerticalAlign(text1,"center")

dgsSetProperty(grid1,"rowHeght",35)
dgsSetProperty(grid2,"rowHeght",35)
dgsSetProperty(edit1,"placeHolder","Имя")
dgsSetProperty(edit2,"placeHolder","Фамилия")
dgsSetProperty(edit3,"placeHolder","Адрес проживания")
dgsSetProperty(edit4,"placeHolder","Имя")
dgsSetProperty(edit5,"placeHolder","Фамилия")
dgsSetProperty(edit6,"placeHolder","Адрес")
dgsSetProperty(edit7,"placeHolder","Имя")
dgsSetProperty(edit8,"placeHolder","Фамилия")
dgsSetProperty(edit9,"placeHolder","Адрес")
dgsSetProperty(window,"font",font)
dgsSetProperty(button1,"font",font)
dgsSetProperty(edit1,"font",font)
dgsSetProperty(edit2,"font",font)
dgsSetProperty(edit3,"font",font)
dgsSetProperty(grid1,"font",font)
dgsSetProperty(edit4,"font",font)
dgsSetProperty(edit5,"font",font)
dgsSetProperty(edit6,"font",font)
dgsSetProperty(button2,"font",font)
dgsSetProperty(button3,"font",font)
dgsSetProperty(grid2,"font",font)
dgsSetProperty(edit7,"font",font)
dgsSetProperty(edit8,"font",font)
dgsSetProperty(edit9,"font",font)
dgsSetProperty(text1,"font",font)
dgsSetProperty(button4,"font",font)

function showWindow()
	--if getElementData(lp(),"logedin") == true then
		if not dgsGetVisible(window) then
			dgsSetVisible(window,true)
			showCursor(true)
		else
			dgsSetVisible(window,false)
			showCursor(false)
		end
	--end
end
bindKey("L","down",showWindow)

function dgsGridListGetSelectedItemText(gridList,column)
    local item = dgsGridListGetSelectedItem(gridList)
    if item then
        return dgsGridListGetItemText(gridList,item,column or 1)
    end
    return false
end

function click(button,state)
	print('clickkkk')
	if source == button1 then
		local name1 = dgsGetText(edit1)
		local name2 = dgsGetText(edit2)
		local adres = dgsGetText(edit3)
		if name1 and name2 and adres and name1 ~= nil and name2 ~= nil and adres ~= nil and name1 ~= "" and name2 ~= "" and adres ~= "" then
			triggerServerEvent("addNewPlayer",lp(),lp(),name1,name2,adres)
			dB(source)
		end
	elseif source == button2 then
		local oldname1 = dgsGetText(edit4)
		local oldname2 = dgsGetText(edit5)
		local oldadres = dgsGetText(edit6)
		local name1 = dgsGridListGetSelectedItemText(grid2,grid2column1)
		local name2 = dgsGridListGetSelectedItemText(grid2,grid2column2)
		local adres = dgsGridListGetSelectedItemText(grid2,grid2column3)
		if name1 and name2 and adres and name1 ~= nil and name2 ~= nil and adres ~= nil and name1 ~= "" and name2 ~= "" and adres ~= "" then
			triggerServerEvent("editPlayer",lp(),lp(),oldname1,oldname2,oldadres,name1,name2,adres)
			dB(source)
		end
	elseif source == button3 then
		local name1 = dgsGridListGetSelectedItemText(grid2,grid2column1)
		local name2 = dgsGridListGetSelectedItemText(grid2,grid2column2)
		local adres = dgsGridListGetSelectedItemText(grid2,grid2column3)
		if name1 and name2 and adres and name1 ~= nil and name2 ~= nil and adres ~= nil and name1 ~= "" and name2 ~= "" and adres ~= "" then
			triggerServerEvent("deletePlayer",lp(),lp(),name1,name2,adres)
			dB(source)
			dgsGridListClear(grid2)
		end
	elseif source == button4 then
		local name1 = dgsGetText(edit7)
		local name2 = dgsGetText(edit8)
		local adres = dgsGetText(edit9)
		outputChatBox(name1.." "..name2.." "..adres)
		if name1 and name2 and adres and name1 ~= nil and name2 ~= nil and adres ~= nil and name1 ~= "" or name2 ~= "" or adres ~= "" then
			triggerServerEvent("searchPlayer",lp(),lp(),name1,name2,adres)
			dB(source)
		end
	end
end
addEventHandler("onDgsMouseClickUp", getRootElement(),click)

addEvent("updateGrid2List",true)
function updateGrid2List(data)
	
end
addEventHandler("updateGrid2List",root,updateGrid2List)

addEvent("updateClientList",true)
function updateClientList(data)
	dgsGridListClear(grid1)
	if data then
		for _,pl in pairs(data) do
			local row = dgsGridListAddRow(grid1)
			dgsGridListSetItemText(grid1,row,grid1column1,(pl.name1 or "error"),false,false)
			dgsGridListSetItemText(grid1,row,grid1column2,(pl.name2 or "error"),false,false)
			dgsGridListSetItemText(grid1,row,grid1column3,(pl.adres or "error"),false,false)
		end
	end
end
addEventHandler("updateClientList",root,updateClientList)

addEvent("returnSearchPlayer",true)
function returnSearchPlayer(data)
	dgsGridListClear(grid2)
	for _,pl in pairs(data) do
		local row = dgsGridListAddRow(grid2)
		dgsGridListSetItemText(grid2,row,grid2column1,(pl.name1 or "error"),false,false)
		dgsGridListSetItemText(grid2,row,grid2column2,(pl.name2 or "error"),false,false)
		dgsGridListSetItemText(grid2,row,grid2column3,(pl.adres or "error"),false,false)
	end
end
addEventHandler("returnSearchPlayer",root,returnSearchPlayer)

local second = 3
function dB(source)
	if source then
		dgsSetEnabled(source,false)
		setTimer(function()dgsSetEnabled(source,true)end,second*1000,1)
	end
end

function lp()
	return localPlayer
end
