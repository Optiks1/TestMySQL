addEventHandler("onResourceStart", resourceRoot,
function()
	db = dbConnect("mysql", "dbname=phpmyadmin;host=127.0.0.1;charset=utf8", "root", "")
	if not db then 
		print("SQL данные аккаунтов повреждены!")
	else
		print("SQL данные аккаунтов загружены")
		dbExec(db,'CREATE TABLE IF NOT EXISTS Players (name1 TEXT, name2 TEXT, adres TEXT)')
	end
	for _,pl in ipairs(getElementsByType("player"))do
			local account = getPlayerAccount(pl)
			if not isGuestAccount(account)then
				setTimer(function()
					updateClientListAll(pl)
				end,3000,1)
			end
		end
end)

function updateClientListAll(source)
	local data = dbPoll(dbQuery(db, "SELECT * FROM Players"),-1)
	if data and data ~= 0 and data ~= nil and data[1] ~= 0 and data[1] ~= nil and data[1]['name1'] ~= 0 then
		triggerClientEvent(source,"updateClientList",source,data)
	end
end

function updateClientList(source)
	local data = dbPoll(dbQuery(db, "SELECT * FROM Players"),-1)
	if data and data ~= 0 and data ~= nil and data[1] ~= 0 and data[1] ~= nil and data[1]['name1'] ~= 0 then
		triggerClientEvent(source,"updateClientList",source,data)
	end
end

addEvent("addNewPlayer",true)
function addNewPlayer(source,name1,name2,adres)
	dbExec(db,"INSERT INTO Players VALUES (?,?,?)",name1,name2,adres)
	updateClientList(source)
end
addEventHandler("addNewPlayer",getRootElement(),addNewPlayer)

addEvent("editPlayer",true)
function editPlayer(source,oldname1,oldname2,oldadres,name1,name2,adres)
	dbExec(db,"UPDATE Players SET name1 = ?, name2 = ?, adres = ? WHERE name1 = ? AND name2 = ? AND adres = ?",oldname1,oldname2,oldadres,name1,name2,adres)
	updateClientList(source)
end
addEventHandler("editPlayer",getRootElement(),editPlayer)

addEvent("deletePlayer",true)
function deletePlayer(source,name1,name2,adres)
	dbExec(db,"DELETE FROM Players WHERE name1 = ? AND name2 = ? AND adres = ?",name1,name2,adres)
	updateClientList(source)
end
addEventHandler("deletePlayer",getRootElement(),deletePlayer)

addEvent("searchPlayer",true)
function searchPlayer(source,name1,name2,adres)
	if name1 and name2 and adres and name1 ~= nil and name2 ~= nil and adres ~= nil and name1 ~= "" and name2 ~= "" and adres ~= "" then
		local data = dbPoll(dbQuery(db,"SELECT * FROM Players WHERE name1 = ? AND name2 = ? AND adres = ?",name1,name2,adres),-1)
		if data and data ~= 0 and data ~= nil and data[1] ~= 0 and data[1] ~= nil and data[1]['name1'] ~= 0 then
			triggerClientEvent(source,"returnSearchPlayer",source,data)
		end
	else
		if name1 and name1 ~= nil and name1 ~= "" then
			local data = dbPoll(dbQuery(db,"SELECT * FROM Players WHERE name1 = ?",name1),-1)
			if data and data ~= 0 and data ~= nil and data[1] ~= 0 and data[1] ~= nil and data[1]['name1'] ~= 0 then
				triggerClientEvent(source,"returnSearchPlayer",source,data)
			end
		elseif name2 and name2 ~= nil and name2 ~= "" then
			local data = dbPoll(dbQuery(db,"SELECT * FROM Players WHERE name2 = ?",name2),-1)
			if data and data ~= 0 and data ~= nil and data[1] ~= 0 and data[1] ~= nil and data[1]['name1'] ~= 0 then
				triggerClientEvent(source,"returnSearchPlayer",source,data)
			end
		elseif adres and adres ~= nil and adres ~= "" then
			local data = dbPoll(dbQuery(db,"SELECT * FROM Players WHERE adres = ?",adres),-1)
			if data and data ~= 0 and data ~= nil and data[1] ~= 0 and data[1] ~= nil and data[1]['name1'] ~= 0 then
				triggerClientEvent(source,"returnSearchPlayer",source,data)
			end
		end
	end
end
addEventHandler("searchPlayer",getRootElement(),searchPlayer)
