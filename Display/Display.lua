
-- ##########################################################################################################################################################
-- #                                                                   Display Color App                                                                    #
-- #                                                        Lua app für JETI Sender mit Farbdisplay                                                         #
-- ##########################################################################################################################################################

-- ##########################################################################################################################################################
-- #                                                                                                                                                        #
-- #                                                                       MIT License                                                                      #
-- #                                                                                                                                                        #
-- #                                                                                                                                                        #
-- #                                                          Copyright (c) 2018-2021 Thorsten Tiedge                                                       #
-- #                                                               Email: thorn_jeti@yahoo.com                                                              #
-- # ------------------------------------------------------------------------------------------------------------------------------------------------------ #
-- # Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),     #
-- # I to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,   #
-- # and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:             #
-- # The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.                         #
-- # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    #
-- # FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,                      #
-- # DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE        #
-- # USE OR OTHER DEALINGS IN THE SOFTWARE.                                                                                                                 #
-- # ------------------------------------------------------------------------------------------------------------------------------------------------------ #
-- #                                                      Sinngemäße Übersetzung (nicht offiziell)                                                          #
-- # Jedem, der eine Kopie dieser Software und der zugehörigen Dokumentationsdateien (die "Software") erhält, wird hiermit kostenlos die Erlaubnis erteilt, #
-- # ohne Einschränkung mit der Software zu handeln, einschließlich und ohne Einschränkung der Rechte zur Nutzung, zum Kopieren, ändern, Zusammenführen,    #
-- # Veröffentlichen, Verteilen, Unterlizenzieren und/oder Verkaufen von Kopien der Software, und Personen, denen die Software zur Verfügung gestellt wird, #
-- # dies unter den folgenden Bedingungen zu gestatten:                                                                                                     #
-- # Der obige Urheberrechtshinweis und dieser Genehmigungshinweis müssen in allen Kopien oder wesentlichen Teilen der Software enthalten sein.             #
-- # DIE SOFTWARE WIRD OHNE MÄNGELGEWÄHR UND OHNE JEGLICHE AUSDRÜCKLICHE ODER STILLSCHWEIGENDE GEWÄHRLEISTUNG, EINSCHLIESSLICH, ABER NICHT BESCHRÄNKT AUF   #
-- # DIE GEWÄHRLEISTUNG DER MARKTGÄNGIGKEIT, DER EIGNUNG FÜR EINEN BESTIMMTEN ZWECK UND DER NICHTVERLETZUNG VON RECHTEN DRITTER, ZUR VERFÜGUNG GESTELLT.    #
-- # DIE AUTOREN ODER URHEBERRECHTSINHABER SIND IN KEINEM FALL HAFTBAR FÜR ANSPRÜCHE, SCHÄDEN ODER ANDERE VERPFLICHTUNGEN, OB IN EINER VERTRAGS- ODER       #
-- # HAFTUNGSKLAGE, EINER UNERLAUBTEN HANDLUNG ODER ANDERWEITIG, DIE SICH AUS, AUS ODER IN VERBINDUNG MIT DER SOFTWARE ODER DER NUTZUNG ODER ANDEREN        #
-- # GESCHÄFTEN MIT DER SOFTWARE ERGEBEN.                                                                                                                   #
-- #                                                                                                                                                        #
-- ##########################################################################################################################################################

-- ##########################################################################################################################################################
-- ##########################################################################################################################################################
-- ##                                                                                                                                                      ##
-- ##                                                                 !!!!!!!! ACHTUNG !!!!!!!!                                                            ##
-- ## JETI weist ausdrücklich darauf hin, Lua-Anwendungen nicht zur Steuerung von Modellfunktionen zu verwenden, welche einen Absturz verursachen können,  ##
-- ## wenn sich die Anwendung nicht richtig verhält oder nicht mehr ausgeführt wird.                                                                       ##
-- ## ---------------------------------------------------------------------------------------------------------------------------------------------------- ##
-- ##                                                   Hier der Originaltext aus der JETI DCDS_Lua_API_1.5:                                               ##
-- ## WARNING                                                                                                                                              ##
-- ## Do not use Lua applications for controlling any model function that could cause a crash if the application misbehaves or stops executing.            ##
-- ## ---------------------------------------------------------------------------------------------------------------------------------------------------- ##
-- ## Bitte beachten sie obenstehende Warnhinweise!                                                                                                        ##
-- ##                                                                                                                                                      ##
-- ##########################################################################################################################################################
-- ##########################################################################################################################################################


collectgarbage()

--[[one
-- nach unbeabsichtigten globalen Variablen suchen
setmetatable(_G, {
	__newindex = function(array, key, value)
		print(string.format("Changed _G: %s = %s", tostring(key), tostring(value)));
		rawset(array, key, value);
	end
});
--]]

-------------------------------------------------------------------------------
local trans, formID, model, spirit, spiritForm, fuelForm, vibrateForm, shortForm, fileImage, fileLogo, fileBattery, filesSave, filesLoad,
			listIds1, listIds2, listParams1, listParams2, listLabels1, listLabels2, indexSensor1, indexSensor2, indexSensor3, indexSensor4, indexSensor5, indexSensor6, indexSensor7, indexSensor8, sensors, sensorsMax, mitohne,
			tiles, methods, methodsMax, params, values, defaults, limits, positions, counts, filesImage,
		  alert, batteryAlert, engine, ass, flaps, clutch, ignitio, gear, switchTiles, image, logo, battery, indexLoad, timeB4, timeB5, eTime, fTime, cTime, akkudAnswer, akkudForm, colorForm, nicknameForm, alphabetForm, vibratesForm, againForm, riseForm, 
		 	eLastTime, fLastTime, cLastTime, fHrs, eMin, fMin, cMin, eSec, fSec, cSec, spacers, tileEngine, tileFlight, tileCounter, tileSpeed,
	    speedValues, flightsTotal, flightsToday, flightDone, flightTime, flightDate, flightLast, options, servos, ids, names, indexLogo, indexImage, indexBattery,
		  mtag, name, background, Pmax, Pmin, sorted, indices, capaOld, colors, heights
local capa1, capa2, capa3, capa4, capa11, capa12, capa13, capaSum, remaining1, remaining2, remaining3, remaining4, lastAn1, lastAn2, lastAn3, lastAn4, lastAlert, arate, prate, arates, prates = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
local mtagMax, paramsMax, positionsMax, positionMax, heightMax, battMax, timeAlert, val, minval, maxval= 6, 6, 9, 6, 158, 20, 3000, 0, 100, 0
local sw, se, kw, ka, pd, rx  = {}, {}, {}, {}, {}, {count=12, alert=10}
local fileLoad, fileSave = "",""   
local version, appversion, unitSpeed, unitSpeed2, unitCurrent, unitFuel, unitent, unitDistance, unitDistance2, unitmbar, folder, extensionFile, extensionsImage = "1.03", "1.03", "km/h", "m/s", "Ah", "mL", "m", "m", "m", "bar", "Apps/Display/", ".txt", {".png", ".jpg"}
--------------------------------------------------------------------------------
-- Read translations
local function setLanguage()
	local name      = "strings"
	local extension = ".jsn"
	local locale    = "-"..system.getLocale()
	local file      = io.readall(folder..name..locale..extension)

	if (not file) then
		file = io.readall(folder..name..extension)
	end

	trans = json.decode(file)

-------------------------------------------------------------------------------------------------------

	---------------------------------------------------------------------------------------------
	-- nach fehlenden Eintr�gen in jsn-Datei suchen
	--[[
	print("pruefe strings...")

	local charsName      = #name
	local charsExtension = #extension
	local emulator       = select(2, system.getDeviceType())
	local array          = {}
	local index          = 0

	if (emulator == 0) then
		folder = "/"..folder:sub(1, -2)
	end

	for entryName, entryType in dir(folder) do
		if (entryType == "file") then
			local entryLocale = entryName:match(name.."%-*([^%.]*)"..extension)

			if (entryLocale) then
				

				local entryFile  = io.readall(folder..entryName)
				local entryTrans = json.decode(entryFile)

				index              = index + 1
				array[entryLocale] = entryTrans
			end
		end
	end

	local text   = "%s aber nicht %s: %s"
	local lang1  = "de"
	local array1 = array[lang1]

	for lang2, array2 in pairs(array) do
		if (lang1 ~= lang2) then
			

			for key in pairs(array1) do
				if (not array2[key]) then
					print(string.format(text, lang1, lang2, key))
				end
			end

			for key in pairs(array2) do
				if (not array1[key]) then
					print(string.format(text, lang2, lang1, key))
				end
			end
		end
	end

	print("fertig")
	--]]
end	
--------------------------------------------------------------------------------
local function setColors()
	local name      = "colors"
	local extension = ".jsn"
	local file      = io.readall(folder..name..extension)

	colors = json.decode(file)
	--print (colors.color01)
end
---------------------------------------------------------------------
local function changeColor (color) 
  local red   = tonumber(string.sub(color,1,3))
	local green = tonumber(string.sub(color,4,6))
	local blue  = tonumber(string.sub(color,7,9))
	
	lcd.setColor(red,green,blue)
end  
-------------------------------------------------------------------

local function setColor()
	local r, g, b = lcd.getBgColor()

	if ((r + g + b) / 3 < 128) then
		r, g, b = 255, 255, 255
	else
		r, g, b = 0, 0, 0
	end

	lcd.setColor(r, g, b)
end
--------------------------------------------------------------------------------
-- hier stehen die Standard-Min-/Max-Werte
local function setDefaults()
	defaults = {}

	for i=2, sensorsMax do
		defaults[-i] = 0
		defaults[ i] = 0
	end

	defaults[-2]  = 99
	defaults[-8]  = 999
	defaults[-17] = 4.2
	defaults[-20] = 999
	defaults[-27] = 99
	defaults[-28] = 99
	defaults[-36] = 999
	defaults[-37] = 999
	defaults[-38] = 999
	defaults[-45] = 999
	defaults[-46] = 999
	defaults[-47] = 999
	defaults[-48] = 999
	defaults[-49] = 999	
	defaults[-51] = 99
	
end
--------------------------------------------------------------------------------
local function setLimits(limit) 
	if (limit) then
		limits = {}

		if (tonumber(limit)) then
			limits[-limit] = defaults[-limit]
			limits[ limit] = defaults[ limit]
		else
			for i=2, sensorsMax do
				limits[-i] = defaults[-i]
				limits[ i] = defaults[ i]
			end

			kw.limit = 0
		end
	else
		rx.limits = {}

		for i=1, rx.count do
			rx.limits[i] = i <= 6 and 77 or i <= 9 and 100 or 0
		end
	end
end
--------------------------------------------------------------------------------
local function setSensors()
	listIds1, listIds2, listParams1, listParams2, listLabels1, listLabels2 = {0}, {0}, {0}, {0}, {"..."}, {"..."}
	local index1, index2 = 1, 1

	for _,sensor in ipairs(system.getSensors()) do
		index1              = index1 + 1
		listIds1   [index1] = sensor.id
		listParams1[index1] = sensor.param
		listLabels1[index1] = sensor.label

		if (sensor.param == 0) then
			index2              = index2 + 1
			listIds2   [index2] = sensor.id
			listParams2[index2] = sensor.param
			listLabels2[index2] = sensor.label
		end
	end
end
---------------------------------------------------------------------------------
local function setFlights()
	local time = system.getDateTime()
	local date = string.format("%d-%d-%d", time.year, time.mon, time.day)

	if (date ~= flightDate) then
		flightDate   = date
		flightsToday = 0
		system.pSave("flightDate",   flightDate  )
		system.pSave("flightsToday", flightsToday)
	end
end
--------------------------------------------------------------------------------
local function setFiles()
	local index      = 1
	local current    = 1
	local files      = {trans.empty}
	local folder     = folder
	local extension  = extensionFile
	local chars      = #extension
	local emulator   = select(2, system.getDeviceType())

	if (emulator == 0) then
		folder = "/"..folder:sub(1, -2)
	end

	for name, type in dir(folder) do
		if (type == "file" and name:sub(-chars):lower() == extension) then
			name         = name:sub(1, -chars-1)
			index        = index + 1
			files[index] = name

			if (name == fileLoad) then
				current = index
			end
		end
	end

	filesLoad = files
	indexLoad = current
end
--------------------------------------------------------------------------------
local function setImages()
	local index      = 1
	local image      = 1
	local logo       = 1
	local battery    = 1
	local files      = {trans.empty}
	local folder     = folder
	local extension1 = extensionsImage[1]
	local extension2 = extensionsImage[2]
	local chars1     = #extension1
	local chars2     = #extension2
	local emulator   = select(2, system.getDeviceType())

	if (emulator == 0) then
		folder = "/"..folder:sub(1, -2) 
	end

	for name, type in dir(folder) do
		if (type == "file") then
			if (name:sub(-chars1):lower() == extension1) then
				name = name:sub(1, -chars1-1)
			elseif (name:sub(-chars2):lower() == extension2) then
				name = name:sub(1, -chars2-1)
			else
				name = nil
			end

			if (name and name ~= files[index-1]) then
				index        = index + 1
				files[index] = name

				if (name == fileImage) then
					image = index
				end

				if (name == fileLogo) then
					logo = index
				end

				if (name == fileBattery) then
					battery = index
				end
			end
		end
	end

	filesImage    = files
	indexImage    = image
	indexLogo     = logo
	indexBattery  = battery
end
--------------------------------------------------------------------------------
local function loadImage(file)
	for _,extension in ipairs(extensionsImage) do
		local image = lcd.loadImage(folder..file..extension)
		if (image) then
			return image
		end
	end

	return false
end
--------------------------------------------------------------------------------
local function getRSSI(value)
	local result
	if     (value > 34) then result = 9
	elseif (value > 27) then result = 8
	elseif (value > 22) then result = 7
	elseif (value > 18) then result = 6
	elseif (value > 14) then result = 5
	elseif (value > 10) then result = 4
	elseif (value >  6) then result = 3
	elseif (value >  3) then result = 2
	elseif (value >  0) then result = 1
	else                     result = 0
	end
	return result
end
--------------------------------------------------------------------------------
local function partition(array1, array2, min, max)
	local pivot = array2[max]:lower()
	local i     = min

	for j=min, max do
		if (array2[j]:lower() < pivot) then
			array1[i], array1[j] = array1[j], array1[i]
			array2[i], array2[j] = array2[j], array2[i]
			i = i + 1
		end
	end

	array1[i], array1[max] = array1[max], array1[i]
	array2[i], array2[max] = array2[max], array2[i]

	return i
end
--------------------------------------------------------------------------------
local function quicksort(array1, array2, min, max)
	if (min < max) then
		local p = partition(array1, array2, min, max)
		quicksort(array1, array2, min, p - 1)
		quicksort(array1, array2, p + 1, max)
	end
end
--------------------------------------------------------------------------------
local function drawBackground()
	if (background == nil) then
		background = loadImage("background")
	end

	if (background) then
		local width  = 320
		local height = 240
		lcd.drawImage((width - math.min(width, background.width)) / 2, (height - math.min(height, background.height)) / 2, background)
	end
end
--------------------------------------------------------------------------------
-- d = Digit(0-9),  Position xy, Gr��e g (1 - 3)
local function drawDigit(x, y, digit, right, size, white)
	if (not se.files or not se.widths) then
		se.files = {
			["0"] = "0";
			["1"] = "1";
			["2"] = "2";
			["3"] = "3";
			["4"] = "4";
			["5"] = "5";
			["6"] = "6";
			["7"] = "7";
			["8"] = "8";
			["9"] = "9";
			["."] = "point";
			[":"] = "colon";
			["-"] = "minus";
		}

		se.widths = {
			["0"] = 38;
			["1"] = 29;
			["2"] = 37;
			["3"] = 36;
			["4"] = 39;
			["5"] = 39;
			["6"] = 38;
			["7"] = 35;
			["8"] = 38;
			["9"] = 38;
			["."] = 15;
			[":"] = 15;
			["-"] = 20;
		}
		
		se.factors = {
			0.8;
			1;
			1.2;
			1.4;
		}
	end
	
	local color = white and "White" or "Black"
	local file  = string.format("Numbers/%s/%s/%s", size, color, se.files[digit])
	local width = se.widths[digit] * se.factors[size]
	local name  = "image_"..file
	
		
	if (not se[name]) then
		se[name] = loadImage(file)
	end
	
	if (se[name]) then
		lcd.drawImage(right and x - width or x, y, se[name])
	end	
	
	return width
end

--------------------------------------------------------------------------------
-- Zahlenausgabe mit beliebig vielen Stellen
-- xy-Koordinaten, z=Zahl,komma stellen, links oder rechtsb�ndig, size=Gr��e(ordner)
local function drawNumber(x, y, number, digits, right, size)	
	--number = 320
  --digits = 1
  --right  = true
	--size   = 1
  --white  = true

	local text    = string.format("%."..digits.."f", number)
	local length  = string.len(text)
	local start   = right and length or 1
	local stop    = right and 1 or length
	local step    = right and -1 or 1
	local digit, width

	for i=start, stop, step do
	
		digit = string.sub(text, i, i)
		width = drawDigit(x, y, digit, right, size)
		x     = x + width * step
	end
end
--------------------------------------------------------------------------------
local function drawFrame(x, y, w, h, c) 
	lcd.drawRectangle(x, y, w, h, c)
	setColor()
end
	--------------------------------------------------------------------------
local function drawAlert(x, y) 
	if (alert) then		
		local text, font, width		
		local step = 3000
		local time = system.getTimeCounter() % (step * 2)
		
		if (time < step) then
			lcd.setColor(255, 0, 0)
					
		 if (se.warning2 == nil) then
	  	se.warning2 = loadImage("warning2")
	   end
	
	   if (se.warning2) then
		  lcd.drawImage(x, y, se.warning2)
	   end

		lcd.setColor(255, 255, 255)

		 font  = FONT_BIG
		 text  = trans.throttle
		 width = lcd.getTextWidth(font, text)
		 lcd.drawText(x + 160 - width / 2, y + 76, text, font)
		
		 text  = trans.stick
		 width = lcd.getTextWidth(font, text)
		 lcd.drawText(x + 160 - width / 2, y + 96, text, font)
		
		 text  = trans.position
		 width = lcd.getTextWidth(font, text)
		 lcd.drawText(x + 160 - width / 2, y + 116, text, font)
		
		 if (se.warning == nil) then
			se.warning = loadImage("warning")
		 end

		 if (se.warning) then
			lcd.drawImage(x + 160 - se.warning.width / 2, y + 50 - se.warning.height / 2, se.warning)
		 end
		
	  else
	
	   if (se.warning1 == nil) then
	  	se.warning1 = loadImage("warning1")
	   end
	
	   if (se.warning1) then
		  lcd.drawImage(x, y, se.warning1)
	   end
    end
	end
end
---------------------------------------------------------------------------------
local function drawBatteryAlert(x, y) 
	if (batteryAlert and batteryAlert > 0) then	
	local text, font, width		
	
  if (se.akkuAlert == nil) then
	 	se.akkuAlert = loadImage("akkuAlert")
	end
	
	if (se.akkuAlert) then
		lcd.drawImage(x, y, se.akkuAlert)
	end
   
	lcd.setColor(255, 255, 255)
		
	font  = FONT_MAXI
	text  = trans.Ak
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 160 - width / 2, y + 37, text, font)
		
	text  = trans.is
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 160 - width / 2, y + 67, text, font)
	lcd.setColor( 0, 0, 0)
		
	font  = FONT_NORMAL
	text  = string.format("(%.2fV", values[2])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 150 - width, y + 104, text, font)

  lcd.drawText(x + 154, y + 103, "<", FONT_BIG)
		
	font  = FONT_NORMAL
	text  = string.format("%.1fV)", se.vorflugvolt / 10)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 210 - width, y + 104, text, font)

  setColor()
 end
end
---------------------------------------------------------------------------------
function ka.drawPercent(x, y, capa, remaining, alarmValue, alarmValues) 
	if (capa == 0) then
		return 0
	end
	
	
	changeColor(colors.color03)
	lcd.drawFilledRectangle(x + 1, y + 0, 53, 39)
	lcd.setColor(0, 0, 0)
	
	
	if (remaining > 0 and remaining <= alarmValue) then
		changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 1, y + 0, 53, 39)
		lcd.setColor(0, 0, 0)
	elseif (remaining > 0 and remaining <= alarmValues) then
		changeColor(colors.color04)
		lcd.drawFilledRectangle(x + 1, y + 0, 53, 39)
		lcd.setColor(0, 0, 0)
	end
   lcd.setColor(0, 0, 0)
	local alarm, blink, full, font, text, width

	alarm = remaining <= alarmValue
  blink = system.getTime() % 2 == 0

	if (not alarm or blink) then
	  full   = remaining >= 99.5
	  font   = full and FONT_BOLD or FONT_MAXI
		text   = string.format("%.0f", remaining)
		width  = lcd.getTextWidth(font, text)
		
    setColor()
		lcd.drawRectangle(x + 1, y + 0, 53, 40)

		if (alarm and blink) then
			lcd.setColor(0, 0, 0)
		end

		lcd.drawText(x + 22 - width/2, y + (full and 12 or  1), text, font)
		lcd.drawText(x + 22 + width/2, y + (full and 12 or 16), "%", FONT_NORMAL)

		setColor()
		--drawFrame(x + 1, y + 0, 53, 40)
	end

end
--------------------------------------------------------------------------------
function ka.drawBatteryPercent(x, y)
	local remaining, capa

	if (Calca_dispFuel == nil or Calca_capacity == nil) then
		remaining = remaining1
		capa      = capa1
	else
		remaining = Calca_dispFuel
		capa      = Calca_capacity
	end
	setColor()

	return ka.drawPercent(x, y, capa, remaining, se.alarmValue1, se.alarmValue11)
end
--------------------------------------------------------------------------------
function ka.drawLevelPercent(x, y)
	local remaining, capa

	if (Calca_dispGas == nil or Calca_selTank	== nil) then
		remaining = remaining2
		capa      = capa2
	else
		remaining = Calca_dispGas
		capa      = Calca_selTank
	end
	setColor()
  
	return ka.drawPercent(x, y, capa, remaining, se.alarmValue2, se.alarmValue22)
end
--------------------------------------------------------------------------------
function ka.drawPercents(x, y, capa, remaining, alarmValue, alarmValues) 
	if (capa == 0) then
		return 0
	end
	
	changeColor(colors.color03)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 54)
	lcd.setColor(0, 0, 0)
	
	
	if (remaining > 0 and remaining <= alarmValue) then
		changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 2, y + 1,128, 54)
		lcd.setColor(0, 0, 0)
	elseif (remaining > 0 and remaining <= alarmValues) then
		changeColor(colors.color04)
		lcd.drawFilledRectangle(x + 2, y + 1,128, 54)
		lcd.setColor(0, 0, 0)
	end
	lcd.setColor(0, 0, 0)

	local alarm = remaining <= alarmValue
	local blink = system.getTime() % 2 == 0 

	if (not alarm or blink) then
		if (alarm and blink) then
		  changeColor(colors.color05)
		end
		
    lcd.setColor(0, 0, 0)
		drawNumber(x + 118, y + 3, remaining, 0, true, 2)
		lcd.drawText(x + 113, y + 33, "%", FONT_BIG)

		setColor()
	end	
end
-------------------------------------------------------------------------------------
function ka.drawBatteryPercents(x, y)
	return ka.drawPercents(x, y, capa1, remaining1, se.alarmValue1, se.alarmValue11)
end
-------------------------------------------------------------------------------------
function ka.drawLevelPercents(x, y)
	return ka.drawPercents(x, y, capa2, remaining2, se.alarmValue2, se.alarmValue22)
end
--------------------------------------------------------------------------------
function ka.drawPercentss(x, y)
	return ka.drawPercentsss(x, y, capa1, remaining1, se.alarmValue1, se.alarmValue11)
end
-------------------------------------------------------------------------------

function ka.drawBattery2Percents(x, y) 
	return ka.drawPercents2(x, y, capa1, remaining1, se.alarmValue1, se.alarmValue11, capa2, remaining2, se.alarmValue2, se.alarmValue22)
end

-----------------------------------------------------------------------------------

-- Battery
function ka.drawBattery(x, y)
	local remaining, capa

	if (Calca_dispFuel == nil or Calca_capacity == nil) then
		remaining = remaining1
		capa      = capa1
	else
		remaining = Calca_dispFuel
		capa      = Calca_capacity
	end

	if (capa == 0) then
		return 0
	end
	
	
	changeColor(colors.color20)
	lcd.drawFilledRectangle(x + 1, y + 11, 52, 101)
   
	local chgH, chgY

	chgH = math.floor(remaining * 0.99)  
	chgY = 111 - chgH

	if (remaining <= se.alarmValue1) then
	  changeColor(colors.color05)
	elseif (remaining <= se.alarmValue11) then
	  changeColor(colors.color04)
	else
		changeColor(colors.color03)
	end

	lcd.drawFilledRectangle(x + 2, y + chgY, 50, chgH)
	
	if (remaining > se.alarmValue11) then
		chgH = math.floor(se.alarmValue11 * 1.02)
		chgY = 111 - chgH

		changeColor(colors.color04)
		lcd.drawFilledRectangle(x + 2, y + chgY, 50, chgH)
	end

	if (remaining > se.alarmValue1) then
		chgH = math.floor(se.alarmValue1 * 1.02)
		chgY = 111 - chgH

		changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 2, y + chgY, 50, chgH)
	end

	setColor()

	if (battery == nil) then
		battery = loadImage(fileBattery)
	end

	if (battery) then
		lcd.drawImage(x + 1, y + 3, battery)
	else
		lcd.drawRectangle(x + 1, y + 11, 52, 101)
		lcd.drawFilledRectangle(x + 15, y + 5, 24, 7)
	end

	
	local text, font, width

	font  = FONT_NORMAL
	text  = string.format("%d", capa)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 27 - width/2, y + 39, text, font)

	text  = "mAh"
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 27 - width/2, y + 53, text, font)

end
--------------------------------------------------------------------------------
function ka.drawLevel(x, y)
	local remaining, capa

	if (Calca_dispGas == nil or Calca_selTank == nil) then
		remaining = remaining2
		capa      = capa2
	else
		remaining = Calca_dispGas
		capa      = Calca_selTank
	end

	if (capa == 0) then
		return 0
	end
	
  
	if (battery == nil) then           
		battery = loadImage(fileBattery)
	end

	if (battery) then
		local chgH, chgY
		
  changeColor(colors.color20)
	lcd.drawFilledRectangle(x + 1, y + 43, 52, 82)

		chgH = math.floor(remaining * 0.80)
		chgY = 124 - chgH

		if (remaining <= se.alarmValue2) then
			changeColor(colors.color05)
			lcd.drawFilledRectangle(x + 2, y + chgY, 50, chgH)
		elseif (remaining <= se.alarmValue22) then
			changeColor(colors.color04)
			lcd.drawFilledRectangle(x + 2, y + chgY, 50, chgH)
		else
			lcd.setColor(0, 185, 0)
			changeColor(colors.color03)
			lcd.drawFilledRectangle(x + 2, y + chgY, 50, chgH)
		end

		setColor()		
		lcd.drawImage(x + 1, y + 3, battery)
		
		local alarm, blink, full, font, text, width

		alarm = remaining <= se.alarmValue2
		blink = system.getTime() % 2 == 0 

		if (not alarm or blink) then
			full   = remaining >= 99.5
			font   = full and FONT_BOLD or FONT_MAXI
			text   = string.format("%.0f", remaining)
			width  = lcd.getTextWidth(font, text)
			lcd.setColor(0, 0, 0)
			
			if (alarm and blink) then
				changeColor(colors.color05)
			 else
				lcd.setColor(0, 0, 0)
			end 
			
			
			lcd.drawText(x + 24 - width/2, y + (full and 17 or 6), text, font)
			lcd.drawText(x + 23 + width/2, y + (full and 23 or 26), "%", FONT_MINI)
			setColor()
		end
	else
		if (remaining <= se.alarmValue2) then
			changeColor(colors.color05)
		elseif (remaining <= se.alarmValue22) then
			changeColor(colors.color04)
   	else
			changeColor(colors.color03)
		end

		local full = math.floor(remaining / 20)
		local part = (remaining - full * 20) / 20  

		
		for i=0, full-1 do
			lcd.drawFilledRectangle(x + 1, y + 93-i*23, 24, 20)
		end

		local chY = math.floor(93 - full*23 + (1-part)*20 + 0.5)
		lcd.drawFilledRectangle(x + 1, y + chY, 24, 20*part)

		setColor()
		lcd.drawRectangle(x + 1, y + 1, 24, 20)
		lcd.drawRectangle(x + 1, y + 24, 24, 20)
		lcd.drawRectangle(x + 1, y + 47, 24, 20)
		lcd.drawRectangle(x + 1, y + 70, 24, 20)
		lcd.drawRectangle(x + 1, y + 93, 24, 20)

		lcd.drawText(x + 35, y + 1, trans.fuelF, FONT_NORMAL)
		lcd.drawText(x + 35, y + 94, trans.fuelE, FONT_NORMAL)

		lcd.setColor(0, 0, 205)
		lcd.drawFilledRectangle(x + 37, y + 56, 6, 9)
		setColor()

		lcd.drawRectangle(x + 36, y + 51, 8, 15)
		lcd.drawRectangle(x + 37, y + 51, 6, 14)
		lcd.drawLine(x + 37, y + 50, x + 42, y + 50)
		lcd.drawLine(x + 38, y + 55, x + 41, y + 55)
		lcd.drawLine(x + 38, y + 56, x + 41, y + 56)
		lcd.drawLine(x + 34, y + 65, x + 35, y + 64)
		lcd.drawLine(x + 45, y + 65, x + 44, y + 64)
		lcd.drawLine(x + 45, y + 59, x + 45, y + 62)
		lcd.drawLine(x + 47, y + 54, x + 47, y + 62)
		lcd.drawLine(x + 45, y + 52, x + 46, y + 53)
		lcd.drawLine(x + 45, y + 55, x + 46, y + 56)
		lcd.drawPoint(x + 34, y + 65)
		lcd.drawPoint(x + 35, y + 65)
		lcd.drawPoint(x + 44, y + 65)
		lcd.drawPoint(x + 45, y + 65)
		lcd.drawPoint(x + 45, y + 54)
		lcd.drawPoint(x + 44, y + 58)
		lcd.drawPoint(x + 46, y + 63)
	end
	
end
--------------------------------------------------------------------------------
function ka.drawCurrentall(x, y, label, values, limits) -- Strom , max Strom
	local font, text, width

	font  = FONT_MAXI
	text  = string.format("%.1f", values)
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 83 - width, y + 3, text, font)
	lcd.drawText(x + 83, y + 19, "A", FONT_NORMAL)

	font  = FONT_MINI
	text  = label
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MINI
	text  = string.format("%.1f A", limits)
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 102, y + 13, trans.m, font)
	lcd.drawText(x + 128 - width, y + 22, text, font)

end
-------------------------------------------------------------------------------
function ka.drawCurrent(x, y) 
	return ka.drawCurrentall(x, y, trans.current, values[3], limits[3])
end
-------------------------------------------------------------------------------
function ka.drawCurrent1(x, y) 
	return ka.drawCurrentall(x, y, trans.current1, values[31], limits[31])
end
-------------------------------------------------------------------------------
function ka.drawCurrent2(x, y) 
	return ka.drawCurrentall(x, y, trans.current2, values[32], limits[32])
end
--------------------------------------------------------------------------------
function ka.drawCurrent3(x, y)
	return ka.drawCurrentall(x, y, trans.current3, values[50], limits[50])
end
-------------------------------------------------------------------------------
function ka.drawSpannungall(x, y, label, values, limits, limitss)  -- Batterie-Werte
	local font, text, width
	
  font  = FONT_MINI
	text  = label
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 37)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%.2f", values)
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 84 - width, y + 4, text, font)
	lcd.drawText(x + 85, y + 19, "V", FONT_NORMAL)

	font   = FONT_MINI
	text   = string.format("%.1f", limits)
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 83, y + 9, trans.mm.." ", font)
	lcd.drawText(x + 122 - width, y + 17, text, font)
	lcd.drawText(x + 122, y + 17, "V", font)

	font   = FONT_MINI
	text   = string.format("%.1f", limitss)
	width  = lcd.getTextWidth(font, text)


	lcd.drawText(x + 122 - width, y + 25, text, font)
	lcd.drawText(x + 122, y + 26, "V", font)

end
-------------------------------------------------------------------------------
function ka.drawAkkuVtg(x, y) 
	return ka.drawSpannungall(x, y, trans.akkuvtg, values[2], limits[2] , limits[-2])
end
-----------------------------------------------------------------------------
function ka.drawAkku1(x, y)  
	return ka.drawSpannungall(x, y, trans.akkuvtg1, values[27], limits[27] , limits[-27])
end	
--------------------------------------------------------------------------------
function ka.drawAkku2(x, y)    
	return ka.drawSpannungall(x, y, trans.akkuvtg2, values[28], limits[28] , limits[-28])
end	
---------------------------------------------------------------------------------
function ka.drawAkku3(x, y)
	return ka.drawSpannungall(x, y, trans.akkuvtg3, values[51], limits[51] , limits[-51])
end		
--------------------------------------------------------------------------------
function ka.drawRx(x, y, label, mini, antenna1, antenna2, percent, voltage, antennaLimit1, antennaLimit2, percentLimit) -------------- Empf�ngerspannung
 	if (mini) then
		local font, text, width
		
		font = FONT_MINI   
		changeColor(colors.color07)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 22)
		lcd.setColor(0, 0, 0)

		if (voltage < 3.8) then  
		  changeColor(colors.color05)
			lcd.drawFilledRectangle(x + 2, y + 1, 128, 22)
			lcd.setColor(0, 0, 0)
		end

		lcd.drawText(x + 10, y + 1, label, font)

		lcd.drawText(x + 4, y + 9, trans.receiver..":", font)
		lcd.drawText(x + 59, y + 5, "V", FONT_NORMAL)
		lcd.drawText(x + 22, y + 3, string.format("%.2f", voltage), FONT_BIG)

		text  = string.format("%d", percent)
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 75, y + 1, "Q:", font)
		lcd.drawText(x + 103 - width, y + 1, text, font)
		lcd.drawText(x + 104, y + 1, "/", font)

		text  = string.format("%d", percentLimit)
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 125 - width, y + 1, text, font)

		text  = string.format("%d", getRSSI(antenna1))
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 70, y + 11, "A1:", font)
		lcd.drawText(x + 91, y + 11, "/", font)
		lcd.drawText(x + 91 - width, y + 11, text, font)

		text  = string.format("%d", getRSSI(antennaLimit1))
		width = lcd.getTextWidth(font, text)

		if (antennaLimit1 <= rx.alert) then
		  changeColor(colors.color13)
		end

		lcd.drawText(x + 100 - width, y + 11, text, FONT_MINI)
		lcd.setColor(0 ,0 , 0)
		--setColor()

		text  = string.format("%d", getRSSI(antenna2))
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 100, y + 11, "A2:", font)
		lcd.drawText(x + 120, y + 11, "/", font)
		lcd.drawText(x + 121 - width, y + 11, text, font)

		text  = string.format("%d", getRSSI(antennaLimit2))
		width = lcd.getTextWidth(font, text)

		if (antennaLimit2 <= rx.alert) then
		  changeColor(colors.color13)
		end

		lcd.drawText(x + 129 - width, y + 11, text, FONT_MINI)
		lcd.setColor(0 ,0 , 0)

	else
		local font, text, width

		font  = FONT_MINI

 
		changeColor(colors.color07)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 31)
		lcd.setColor(0 ,0 , 0)


		if (voltage < 3.8) then
			changeColor(colors.color05)
			lcd.drawFilledRectangle(x + 2, y + 1, 128, 31)
			lcd.setColor( 0, 0, 0)
		end

	
    lcd.drawText(x + 2, y + 19, trans.receiver..":", FONT_MINI)
		lcd.drawText(x + 82, y + 13, "V", FONT_NORMAL)
		lcd.drawText(x + 17, y - 2, string.format("%.2f", voltage), FONT_MAXI)


		text  = string.format("%d", percent)
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 79, y + 1, "Q:", FONT_MINI)
		lcd.drawText(x + 107 - width, y + 1, text, FONT_MINI)
		lcd.drawText(x + 108, y + 1, "/", FONT_MINI)

		text  = string.format("%d", percentLimit)
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 129 - width, y + 1, text, FONT_MINI)

		text  = string.format("%d", getRSSI(antenna1))
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 95, y + 11, "A1:", FONT_MINI)
		lcd.drawText(x + 118, y + 11, "/", FONT_MINI)
		lcd.drawText(x + 118 - width, y + 11, text, FONT_MINI)

		text  = string.format("%d", getRSSI(antennaLimit1))
		width = lcd.getTextWidth(font, text)

		if (antennaLimit1 <= rx.alert) then
		  changeColor(colors.color13)
		end

		lcd.drawText(x + 128 - width, y + 11, text, FONT_MINI)
		lcd.setColor(0 ,0 , 0)

		text  = string.format("%d", getRSSI(antenna2))
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 95, y + 20, "A2:", FONT_MINI)
		lcd.drawText(x + 118, y + 20, "/", FONT_MINI)
		lcd.drawText(x + 118 - width, y + 20, text, FONT_MINI)

		text  = string.format("%d", getRSSI(antennaLimit2))
		width = lcd.getTextWidth(font, text)

		if (antennaLimit2 <= rx.alert) then
		    changeColor(colors.color13) 
		end

		lcd.drawText(x + 128 - width, y + 20, text, FONT_MINI)
		lcd.setColor(0 ,0 , 0)

		
	end
end
--------------------------------------------------------------------------------
function ka.drawRxMaxi1(x, y) -- Empf�ngerspannung 1
	return ka.drawRx(x, y, "P", false, rx.values[1], rx.values[2], rx.values[7], rx.values[10], rx.limits[1], rx.limits[2], rx.limits[7])
end
--------------------------------------------------------------------------------
function ka.drawRxMini1(x, y)  -- Empf�ngerspannung 1
	return ka.drawRx(x, y, "P", true, rx.values[1], rx.values[2], rx.values[7], rx.values[10], rx.limits[1], rx.limits[2], rx.limits[7])
end
--------------------------------------------------------------------------------
function ka.drawRxMaxi2(x, y) -- Empf�ngerspannung 2
	return ka.drawRx(x, y, "S", false, rx.values[3], rx.values[4], rx.values[8], rx.values[11], rx.limits[3], rx.limits[4], rx.limits[8])
end
--------------------------------------------------------------------------------
function ka.drawRxMini2(x, y)  -- Empf�ngerspannung 2
	return ka.drawRx(x, y, "S", true, rx.values[3], rx.values[4], rx.values[8], rx.values[11], rx.limits[3], rx.limits[4], rx.limits[8])
end
--------------------------------------------------------------------------------
function ka.drawRxMaxi3(x, y) -- Empf�ngerspannung 3
	return ka.drawRx(x, y, "B", false, rx.values[5], rx.values[6], rx.values[9], rx.values[12], rx.limits[5], rx.limits[6], rx.limits[9])
end
--------------------------------------------------------------------------------
function ka.drawRxMini3(x, y)  -- Empf�ngerspannung 3
	return ka.drawRx(x, y, "B", true, rx.values[5], rx.values[6], rx.values[9], rx.values[12], rx.limits[5], rx.limits[6], rx.limits[9])
end
------------------------------------------------------------------------------------
function ka.drawHeight(x, y) -- H�he 
	local font, text, width
	
	changeColor(colors.color14)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 27)
	lcd.setColor(0, 0, 0)

	if (se.bluehight > 0 and values[6] >= se.bluehight) then
	  changeColor(colors.color05)
	
		lcd.drawFilledRectangle(x + 18, y + 1, 18, 27)
	  lcd.setColor(0, 0, 0)
	  lcd.drawText(x + 22, y - 6, "!", FONT_MAXI)
  end

	font  = FONT_MAXI
	text  = string.format("%.0f", values[6])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 2, y + 9, trans.hei..":", FONT_NORMAL)

	lcd.drawText(x + 90 - width, y - 6, text, font)
	lcd.drawText(x + 90, y + 15, "m", FONT_MINI)

	font  = FONT_MINI
	text  = string.format("%d",limits [6])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 106, y + 0, "max", font)
	lcd.drawText(x + 127 - width, y + 9, text, font)
	lcd.drawText(x + 117, y + 16, "m", font)

end
--------------------------------------------------------------------------------
function ka.drawHeights(x, y)  -- absoluteH�he
	local font, text, width
	
	changeColor(colors.color14)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 27)
	lcd.setColor(0, 0, 0)

  font  = FONT_MAXI
	text  = string.format("%.0f", values [33])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 2, y + 10, trans.hei..":", FONT_NORMAL)
	lcd.drawText(x + 3, y - 1, trans.heia..":", FONT_NORMAL)
	lcd.drawText(x + 90 - width, y - 6, text, font)
	lcd.drawText(x + 90, y + 15, "m", FONT_MINI)

	font  = FONT_MINI
	text  = string.format("%d", limits [33])
	width = lcd.getTextWidth(font, text)
	
	lcd.drawText(x + 106, y + 0, "max", font)
	lcd.drawText(x + 127 - width, y + 9, text, font)
	lcd.drawText(x + 117, y + 16, "m", font)
end
--------------------------------------------------------------------------------
 function ka.drawTempall(x, y, label, values, limits, limitss)
	local font, text, width

	text  = label
  font  = FONT_MINI
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color09)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

  lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%.1f", values)
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 81 - width, y + 3, text, font)

  font  = FONT_MINI
	text  = string.format("%d", limits)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 88, y + 17, "C", FONT_BIG)
  lcd.drawCircle(x + 85, y + 23, 3)
	lcd.drawCircle(x + 85, y + 23, 2)

  lcd.drawText(x + 83, y + 9, trans.mm, font)
	lcd.drawText(x + 117 - width, y + 17, text, font)
	lcd.drawText(x + 123, y + 17, "C", font)
	lcd.drawCircle(x + 120, y + 22, 2)

	font  = FONT_MINI
	text  = string.format("%d", limitss)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 117 - width, y + 25, text, font)
	lcd.drawText(x + 123, y + 25, "C", font)
  lcd.drawCircle(x + 120, y + 30, 2)

	--drawFrame(x + 1, y + 1, 130, 36, 5)
	
end

---------------------------------------------------------------------   
function ka.drawTemp(x, y) -- Temperatur1 
	return ka.drawTempall(x, y, trans.temp, values[8], limits[8] , limits[-8])
end
-----------------------------------------------------------------------------
function ka.drawTemp2(x, y)  -- Temperatur2  
	return ka.drawTempall(x, y, trans.temp2, values[20], limits[20] , limits[-20])
end	
--------------------------------------------------------------------------------
function ka.drawTemp3(x, y)  -- Temperatur3  
	return ka.drawTempall(x, y, trans.temp3, values[36], limits[36] , limits[-36])
end	
---------------------------------------------------------------------------------
function ka.drawTemp4(x, y)  -- Temperatur4 
	return ka.drawTempall(x, y, trans.temp4, values[37], limits[37] , limits[-37])
end	
------------------------------------------------------------------------------
function ka.drawTemp5(x, y)  -- Temperatur5 
	return ka.drawTempall(x, y, trans.temp5, values[38], limits[38] , limits[-38])
end	
----------------------------------------------------------------------------------
function ka.drawTemp6(x, y)  -- Temperatur6 
	return ka.drawTempall(x, y, trans.temp6, values[45], limits[45] , limits[-45])
end	
----------------------------------------------------------------------------------
function ka.drawTemp7(x, y) -- Temperatur7
	return ka.drawTempall(x, y, trans.temp7, values[46], limits[46] , limits[-46])
end
-----------------------------------------------------------------------------
function ka.drawTemp8(x, y)  -- Temperatur8  
	return ka.drawTempall(x, y, trans.temp8, values[47], limits[47] , limits[-47])
end	
--------------------------------------------------------------------------------
function ka.drawTemp9(x, y)  -- Temperatur9  
	return ka.drawTempall(x, y, trans.temp9, values[48], limits[48] , limits[-48])
end	
---------------------------------------------------------------------------------
function ka.drawTemp10(x, y)  -- Temperatur10
	return ka.drawTempall(x, y, trans.temp10, values[49], limits[49] , limits[-49])
end	
------------------------------------------------------------------------------
function ka.drawVario(x, y) -- Vario
	local font, text, width

	font  = FONT_MAXI
	text  = string.format("%.1f", values[7])
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color08)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 27)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 3, y + 9, trans.varios, FONT_NORMAL)
	lcd.drawText(x + 40, y + 9, ":", FONT_NORMAL)
	lcd.drawText(x + 102, y + 16, "m/s", FONT_MINI)
	lcd.drawText(x + 102 - width, y - 6, text, font)

	font  = FONT_MINI
	text  = string.format("%.1f", limits[7])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 106, y - 0, "max", font)
	lcd.drawText(x + 128 - width, y + 8, text, font)

	
end
------------------------------------------------------------------------
function ka.drawRPM(x, y) -- RPM
  local font, text, width
	local small = values[9] >= 100000
	
	
	changeColor(colors.color06)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 27)
	
	lcd.setColor(0, 0, 0)

	font  = small and FONT_BOLD or FONT_MAXI
	text  = string.format("%.0f", values[9])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 100 - width + (small and -20 or 0), y - 6 + (small and 13 or 0), text, font)

	font  = FONT_MINI
	text  = string.format("%.0f", limits[9])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 107, y +3, "max", font)
	lcd.drawText(x + 130 - width, y + 12, text, font)
	lcd.drawText(x + 3, y +0, "R", font)
	lcd.drawText(x + 3, y +8, "P", font)
	lcd.drawText(x + 3, y +16, "M", font)

end
--------------------------------------------------------------------------------
function ka.drawWatt(x, y) -- Watt
	local font, text, width
   
	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 27)
	
	lcd.setColor(0, 0, 0)
	
	font  = FONT_MAXI
	text  = string.format("%.0f", values[10])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 4, y + 9, trans.watt..":", FONT_NORMAL)
	lcd.drawText(x + 98 - width, y - 6, text, font)

	font   = FONT_NORMAL
	text   = string.format("%.0f", limits[10])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 105, y + 1, trans.m.." ", FONT_MINI)
	lcd.drawText(x + 128 - width, y + 10, text, font)
 
end
--------------------------------------------------------------------------------
function ka.drawAkku(x, y) -- Akku Kapazit�t klein
	local font, text, width

	font  = FONT_MINI    
	text  = trans.akku
	width = lcd.getTextWidth(font, text)

	 
  changeColor(colors.color03) 
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	lcd.setColor( 0, 0, 0)
	
  if (remaining1 > 0 and remaining1 <= se.alarmValue1) then 
		changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
		lcd.setColor( 0, 0, 0)
	elseif (remaining1 > 0 and remaining1 <= se.alarmValue11) then 
	
		changeColor(colors.color04)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
		lcd.setColor( 0, 0, 0)
	end

  lcd.drawText(x + 66 - width/2, y - 1, text, font)
  lcd.drawText(x + 90, y + 24, "mAh", font)

	font  = FONT_MAXI
	text  = string.format("%.0f", values[4])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 90 - width, y + 3, text, font)

end
--------------------------------------------------------------------------------
function ka.drawAkkuBig(x, y)  -- Akku Kapazit�t mittelgro�
	local font, text, width

	font  = FONT_MINI
	text  = trans.akkub
	width = lcd.getTextWidth(font, text)
	
	
	changeColor(colors.color03)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 54)
	lcd.setColor( 0, 0, 0)

	if (remaining1 > 0 and remaining1 <= se.alarmValue1) then
		changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 54)
		lcd.setColor( 0, 0, 0)
	elseif (remaining1 > 0 and remaining1 <= se.alarmValue11) then 
		changeColor(colors.color04)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 54)
		lcd.setColor( 0, 0, 0)
	end

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	drawNumber(x + 130, y + 13, values[4], 0, true, 1)
end
--------------------------------------------------------------------------------
function ka.drawTime(x, y) -- Time  
	local font, text, width
	
  font  = FONT_MINI
	text  = trans.etime
	width = lcd.getTextWidth(font, text)


	changeColor(colors.color16)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	lcd.setColor(0, 0, 0)


	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%02d:%02d", eMin, eSec)
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 65 - width/2, y + 3, text, font)
	lcd.setColor(0, 0, 0)

end
--------------------------------------------------------------------------------
function ka.drawTimes(x, y)  -- Time 
	local font, text, width
	local hours = fHrs > 0
	 
	changeColor(colors.color16)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	lcd.setColor(0, 0, 0)

	font   = FONT_MINI
	if (hours) then
		text = trans.fh
	else
		text = trans.ftime
	end
  width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = hours and string.format("%02d:%02d:%02d", fHrs, fMin, fSec) or string.format("%02d:%02d", fMin, fSec)
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 65 - width/2, y + 3, text, font)

	lcd.setColor(0, 0, 0)
	
end
--------------------------------------------------------------------------------------
function ka.drawCountdown(x, y)   --   Time
	local time = cMin*60 + cSec
	local font, text, width
	
	changeColor(colors.color16)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)

	if (cTime and math.ceil(cTime) < 0) then
		time = -time
	end
  lcd.setColor(0, 0, 0)
	font  = FONT_MINI
	text  = trans.countdown
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)
  
	font  = FONT_MAXI
	text  = string.format("%02d:%02d", cMin, cSec)
	width = lcd.getTextWidth(font, text)

	if (time <= 60) then
		changeColor(colors.color05)
	elseif (time <= 0.5 * (60*se.countdownMin + se.countdownSec)) then
		if (se.color) then
			lcd.setColor(0, 0, 0)
		else
			lcd.setColor(lcd.getFgColor())
		end
	else
		if (se.color) then
			lcd.setColor(lcd.getFgColor())
		else
			lcd.setColor(0, 0, 0)
		end
	end

	lcd.drawText(x + 65 - width/2, y + 3, text, font)

	if (time < 0) then
		lcd.drawText(x + 11, y + 0, "-", font)
	end


end
-----------------------------------------------------------------------------------
function ka.drawMuli(x, y) -- Mui
	local font, text, width

	font  = FONT_MINI
	text  = trans.muli
	width = lcd.getTextWidth(font, text)
	
	

	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 81)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 -width/2, y + 0, text, font)

	font  = FONT_BIG
	text  = string.format("1) %.2f", values[11])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 60 - width, y + 7, text, font)

	text  = string.format("2) %.2f", values[12])
	lcd.drawText(x + 60 - width, y + 25, text, font)

	text  = string.format("3) %.2f", values[13])
	lcd.drawText(x + 60 - width, y + 43, text, font)

	text  = string.format("4) %.2f", values[14])
	lcd.drawText(x + 125- width, y + 7, text, font)

	text  = string.format("5) %.2f", values[15])
	lcd.drawText(x + 125 - width, y + 25, text, font)

	text  = string.format("6) %.2f", values[16])
	lcd.drawText(x + 125 - width, y + 43, text, font)

	text  = string.format("%.2f", values[17])
	lcd.drawText(x + 146 - width, y + 61, text, font)

	font  = FONT_MINI
	lcd.drawText(x + 2, y + 68, trans.schw, font)
end
-------------------------------------------------------------------------------------
function ka.drawMuis(x, y) -- Mui
	local font, text, width

	font  = FONT_MINI
	text  = trans.schw
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	lcd.drawText(x + 9, y + 23, "min", font)

	font  = FONT_MAXI
	text  = string.format("%.2f", limits[-17])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 66 - width/2, y + 3, text, font)

	font  = FONT_MAXi

	lcd.drawText(x + 100, y + 19, "V", font)

	
end
------------------------------------------------------------------------------------
function ka.drawSpeed(x, y)  -- Gps 
	local font, text, width
	local unit = unitSpeed == unitSpeed2 and "km/h" or unitSpeed

	font  = FONT_MINI
	text  = trans.speed
	width = lcd.getTextWidth(font, text)
	

	changeColor(colors.color14)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 45)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	lcd.drawText(x + 73, y + 25, unit, font)

	font  = FONT_MAXI
	text  = string.format("%.0f", values[18])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 70 - width, y + 3, text, font)

	font  = FONT_MINI
	text  = string.format("%.0f", limits[18])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 106, y + 13, "max", font)
	lcd.drawText(x + 126 - width, y + 23, text, font)

	font  = FONT_MINI
	text  = string.format("%.0f", values[19])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 30, y + 33, trans.sat, font)
	lcd.drawText(x + 78, y + 33, ":", font)
	lcd.drawText(x + 81, y + 33, text, font)

return 46
end
------------------------------------------------------------------------------------
function ka.drawSpeetri(x, y)
 local font, text, width, value, r, d

	font  = FONT_MINI
	text  = trans.speedTrigger
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color12)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 85)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_NORMAL

	for i=0, 9 do
		value = speedValues[i + 1]

		if (value) then
			r     = 26 + 62*math.floor(i/5)
			d     = 10 + 14*(i%5)

			text  = string.format("%d)", i + 1)
			width = lcd.getTextWidth(font, text)

			lcd.drawText(x + r - width, y + d, text, font)

			text  = string.format("%d", value)
			width = lcd.getTextWidth(font, text)

			lcd.drawText(x + r + 28 - width, y + d, text, font)
		end
	end
end
----------------------------------------------------------------------------------
function ka.drawFuel(x, y) -- Tank   
	local font, text, width
 
	font  = FONT_MINI
	text  = trans.fuel
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color03)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 37)
	lcd.setColor(0, 0, 0)
	
	if (remaining2 > 0 and remaining2 <= se.alarmValue2) then
		changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 37)
		lcd.setColor( 0, 0, 0)
	elseif (remaining2 > 0 and remaining2 <= se.alarmValue22) then
	  changeColor(colors.color04)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 37)
		lcd.setColor( 0, 0, 0)
	end

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%.0f", values[21])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 98 - width, y + 4, text, font)
	lcd.drawText(x + 100, y + 20, unitFuel, FONT_Mini)

	

end
-----------------------------------------------------------------------------
function ka.drawFuelBig(x, y)  -- Tank gro� 
	local font, text, width

	font  = FONT_MINI
	text  = trans.fuelss
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color03)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 54)
	lcd.setColor(0, 0, 0)
	
  if (remaining2 > 0 and remaining2 <= se.alarmValue2) then
		changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 54)
		lcd.setColor( 0, 0, 0)
	elseif (remaining2 > 0 and remaining2 <= se.alarmValue22) then
	  changeColor(colors.color04)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 54)
		lcd.setColor( 0, 0, 0)
	end
	
	
	lcd.drawText(x + 66 - width/2, y - 1, text, font)

--	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	drawNumber(x + 130, y + 13, values[21], 0, true, 1)

end
---------------------------------------------------------------------------------
function ka.drawPump(x, y) -- Batterie-Werte Pump
	local font, text, width

	font  = FONT_MINI
	text  = trans.pump
	width = lcd.getTextWidth(font, text)
	

	changeColor(colors.color06)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%.2f", values[22])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 98 - width, y + 3, text, font)
	lcd.drawText(x + 100, y + 19, "V", FONT_NORMAL)

end
-----------------------------------------------------------------------------------
function ka.drawEcu(x, y)  -- Batterie-Werte Eco
	local font, text, width
	

	font  = FONT_MINI
	text  = trans.ecu
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color06)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%.2f", values[23])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 98 - width, y + 3, text, font)
	lcd.drawText(x + 100, y + 19, "V", FONT_NORMAL)

	
end
--------------------------------------------------------------------------------------
function ka.drawG(x, y)  -- G-Kr�fte
	local font, text, width

	font  = FONT_BIG
	text  = string.format("%.2f", values[24])
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color12)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 19)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 84 - width, y + 0, text, font)

	font  = FONT_MINI

	lcd.drawText(x + 3, y + 7, trans.g, font)
	lcd.drawText(x + 40, y + 6, ":", font)
	lcd.drawText(x + 85, y + 3, "G", FONT_NORMAL)

	font  = FONT_MINI
	text  = string.format("%.2f", limits[24])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 104, y + 0, "max:", font)
	lcd.drawText(x + 122 - width, y + 8, text, font)
	lcd.drawText(x + 122, y + 8, "G", font)

end
------------------------------------------------------------------
function ka.drawVibes(x, y) -- Vibration
	local font, text, width

	font  = FONT_MINI
	text  = trans.vibes
	width = lcd.getTextWidth(font, text)
	

	changeColor(colors.color12)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%.0f", values[25])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 58 - width/2, y + 3, text, font)

	font  = FONT_MINI
	text  = string.format("%.0f", limits[25])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 100, y + 13, trans.m, font)
	lcd.drawText(x + 117 - width, y + 22, text, font)

	

end
------------------------------------------------------------------
function ka.drawThro(x, y) -- Gaswert in %
	local font, text, width

	font  = FONT_MINI
	text  = trans.thro
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color06)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%.0f", values[26])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 68 - width, y + 3, text, font)
	lcd.drawText(x + 69, y + 20, "%", FONT_BOLD)

	font  = FONT_MINI
	text  = string.format("%.0f", limits[26])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 100, y + 12, trans.m, font)
	lcd.drawText(x + 113 - width, y + 22, text, font)
	lcd.drawText(x + 113, y + 22, "%", font)

end
---------------------------------------------------------------------
function ka.drawModel(x, y) -- Modell Name 
	local limit = 15
	local font  = FONT_BOLD
	local text  = #model > limit and model:sub(1, limit) or model
	local width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color11)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 23)

	lcd.setColor(0, 0, 0)
	lcd.drawText(x + 67 - width/2, y + 3, text, font)
	

end
----------------------------------------------------------------

function ka.drawEngine(x, y)   --Motor an aus
	local text, font, width

	if (engine and engine > 0) then
		text = trans.engineOn
		changeColor(colors.color01)
	else
		text = trans.engineOff
		changeColor(colors.color02)
	end

	local font  = FONT_BIG
	local width = lcd.getTextWidth(font, text)

	lcd.drawFilledRectangle(x + 2, y + 1, 128, 18)

	lcd.setColor(255, 255, 255)
	lcd.drawText(x + 64 - width/2, y - 2, text, font)

end
------------------------------------------------------------------------------------------
function ka.drawEngines(x, y)   --Motor an aus
	local text, font, width

	if (engine and engine > 0) then
		text = trans.engineOn
		changeColor(colors.color01)
	else
		text = trans.engineOff
		changeColor(colors.color02)
	end

	local font  = FONT_NORMAL
	local width = lcd.getTextWidth(font, text)

	lcd.drawFilledRectangle(x + 2, y + 1, 128, 14)

	lcd.setColor(255, 255, 255)
	lcd.drawText(x + 64 - width/2, y - 2, text, font)

end
-------------------------------------------------------------------------------
function ka.drawAkku1s(x, y) -- Akku1
	local font, text, width

	font  = FONT_MINI
	text  = trans.akku1
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	lcd.drawText(x + 90, y + 24 , "mAh", font)

	font  = FONT_MAXI
	text  = string.format("%.0f", values[29])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 90 - width, y + 3, text, font)

end

-----------------------------------------------------------------------------------
function ka.drawAkku2s(x, y) -- Akku2
	local font, text, width

	font  = FONT_MINI
	text  = trans.akku2
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	lcd.drawText(x + 90, y + 24, "mAh", font)

	font  = FONT_MAXI
	text  = string.format("%.0f", values[30])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 90 - width, y + 3, text, font)

end
------------------------------------------------------------------------------------
function ka.drawStrecke(x, y) -- Strecke
	local font, text, width
	local unit = unitDistance == unitDistance2 and "km" or unitDistance
	local smal = values[5] >= 100

	font  = FONT_MINI
	text  = trans.strecke
	width = lcd.getTextWidth(font, text)
	
  changeColor(colors.color14)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)


	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	lcd.drawText(x + 108, y + 25, unit, font)

	font  = FONT_MAXI
	text  = smal and string.format("%.2f", values[5]) or string.format("%.3f", values[5])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 106 - width, y + 3, text, font)

end

---------------------------------------------------------------------------------
function ka.drawStats(x, y)
	local font, text, width
	
	
	changeColor(colors.color11)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 18)
	
	lcd.setColor(0, 0, 0)


	font  = FONT_BOLD
	text  = string.format("%s %d : %d", trans.flights, flightsToday, flightsTotal)
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 65 - width/2, y - 0, text, font)
end
---------------------------------------------------------------------------------

function ka.drawTEmp (x, y)
	local font, text, width
	
	changeColor(colors.color09)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 60)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 2, y +  4, trans.TEmp1, FONT_MINI)
	lcd.drawText(x + 2, y + 15, trans.TEmp2, FONT_MINI)
	lcd.drawText(x + 2, y + 26, trans.TEmp3, FONT_MINI)
	lcd.drawText(x + 2, y + 37, trans.TEmp4, FONT_MINI)
	lcd.drawText(x + 2, y + 49, trans.TEmp5, FONT_MINI)

	--normaler Wert
	font  = FONT_BOLD
	text  = string.format("%.0f\u{B0}C", values[8])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y - 1, text, font)

	font  = FONT_BOLD
	text  = string.format("%.0f\u{B0}C", values[20])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y + 11, text, font)

	text  = string.format("%.0f\u{B0}C", values[36])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y + 22, text, font)

	text  = string.format("%.0f\u{B0}C", values[37])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y + 33, text, font)

	text  = string.format("%.0f\u{B0}C", values[38])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y + 44, text, font)
	--Max Wert
	font  = FONT_MINI
	text  = string.format("%dc", limits[8])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 5, text, font)

	text  = string.format("%dc", limits[20])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 16, text, font)

	text  = string.format("%dc", limits[36])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 27, text, font)

	text  = string.format("%dc", limits[37])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 38, text, font)

	text  = string.format("%dc", limits[38])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 49, text, font)

end
--------------------------------------------------------------------------------
function ka.drawTEmps (x, y)
	local font, text, width
	
	changeColor(colors.color09)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 50)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 2, y +  4, trans.TEmp1, FONT_MINI)
	lcd.drawText(x + 2, y + 15, trans.TEmp2, FONT_MINI)
	lcd.drawText(x + 2, y + 26, trans.TEmp3, FONT_MINI)
	lcd.drawText(x + 2, y + 37, trans.TEmp4, FONT_MINI)

	--normaler Wert
	font  = FONT_BOLD
	text  = string.format("%.0f\u{B0}C", values[8])
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 106 - width, y - 1, text, font)

	font  = FONT_BOLD
	text  = string.format("%.0f\u{B0}C", values[20])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y + 11, text, font)

	text  = string.format("%.0f\u{B0}C", values[36])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y + 22, text, font)

	text  = string.format("%.0f\u{B0}C", values[37])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y + 33, text, font)

	--Max Wert
	font  = FONT_MINI
	text  = string.format("%dc", limits[8])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 5, text, font)

	text  = string.format("%dc", limits[20])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 16, text, font)

	text  = string.format("%dc", limits[36])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 27, text, font)

	text  = string.format("%dc", limits[37])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 38, text, font)

end

--------------------------------------------------------------------------------
function ka.drawTEmps3 (x, y)  
	local font, text, width
	
	changeColor(colors.color09)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 39)
	
	lcd.setColor(0, 0, 0)


  lcd.drawText(x + 2, y +  4, trans.TEmp1, FONT_MINI)
	lcd.drawText(x + 2, y + 15, trans.TEmp2, FONT_MINI)
	lcd.drawText(x + 2, y + 26, trans.TEmp3, FONT_MINI)

  --normaler Wert
	font  = FONT_BOLD
	text  = string.format("%.0f\u{B0}C", values[8])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y - 1, text, font)

	font  = FONT_BOLD
	text  = string.format("%.0f\u{B0}C", values[20])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y + 11, text, font)

	text  = string.format("%.0f\u{B0}C", values[36])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y + 22, text, font)

	--Max Wert
	font  = FONT_MINI
	text  = string.format("%dc", limits[8])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 5, text, font)

	text  = string.format("%dc", limits[20])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 16, text, font)

	text  = string.format("%dc", limits[36])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 27, text, font)


end
----------------------------------------------------------------------
function ka.drawTEmps2 (x, y)
	local font, text, width
	

	changeColor(colors.color09)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 28)
	
	lcd.setColor(0, 0, 0)


  lcd.drawText(x + 2, y +  4, trans.TEmp1, FONT_MINI)
	lcd.drawText(x + 2, y + 15, trans.TEmp2, FONT_MINI)

	--normaler Wert
	font  = FONT_BOLD
	text  = string.format("%.0f\u{B0}C", values[8])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y - 1, text, font)

	font  = FONT_BOLD
	text  = string.format("%.0f\u{B0}C", values[20])
	width = lcd.getTextWidth(font, text)
 lcd.drawText(x + 106 - width, y + 11, text, font)


	--Max Wert
	font  = FONT_MINI
	text  = string.format("%dc", limits[8])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 5, text, font)

	text  = string.format("%dc", limits[20])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 130 - width, y + 16, text, font)
	
end
-----------------------------------------------------------------------
function ka.drawEntfernung(x, y)
	local font, text, width

	font  = FONT_MINI
	text  = trans.Ent
	width = lcd.getTextWidth(font, text)

	changeColor(colors.color14)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)


	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	lcd.drawText(x + 75, y + 25, unitent, font)

	font  = FONT_MAXI
	text  = string.format("%.0f", values[39])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 75 - width, y + 3, text, font)

	font  = FONT_MINI
	text  = string.format("%.0f", limits[39])
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 118 - width, y + 17, text, font)
	lcd.drawText(x + 118, y + 17, unitent, font)
	lcd.drawText(x + 106, y + 8, trans.m, font)
	

end
---------------------------------------------------------------------------------
function ka.drawImage(x, y)
	if (image == nil) then
		image = loadImage(fileImage)
	end

	if (image) then
		local width  = 124
		local height = 56
		lcd.drawImage(x + 2 + (width - math.min(width, image.width)) / 2, y + 1 + (height - math.min(height, image.height)) / 2, image)
	end
	setColor()
	drawFrame(x + 2, y + 0, 128, 62)
end
--------------------------------------------------------------------------------------
function ka.drawLogo(x, y)
	if (logo == nil) then
		logo = loadImage(fileLogo)
	end

	if (not logo) then
		return 0
	end

	local width  = 52
	local height = 153
	lcd.drawImage(x + 1 + (width - math.min(width, logo.width)) / 2, y + 1 + (height - math.min(height, logo.height)) / 2, logo)
	
end
--------------------------------------------------------------------------------
function ka.drawAssi(x, y)
	local text = ""

	if (ass) then
		if (ass < 0) then
			text = trans.a
		elseif (ass > 0) then
			text = trans.c
		else
			text = trans.b
		end
	end
	
	changeColor(colors.color15)

	lcd.drawFilledRectangle(x + 2, y + 1, 128, 23)
	lcd.setColor(0, 0, 0)


	local font  = FONT_BIG
	local width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 64 - width/2, y + 1, text, font)
end
----------------------------------------------------------------
--[[
Status      -          - mtag[1]
Akku ID     - tagID    - mtag[1]
Kapazit�t   - tagCapa  - mtag[2]
Zyklenzahl  - tagCount - mtag[3]
Zellenzahl  - tagCells - mtag[4]
Entladerate - tagcrate - mtag[5]
--]]
function ka.drawMTAG(x, y) -- mtag
	local font, text, width
	
	changeColor(colors.color12)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 40)
	
	if (mtag[1] > 0) then
	  changeColor(colors.color07)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 40)
		setColor()
	end
	
	lcd.setColor(0, 0, 0)


	font  = FONT_MINI
	text  = trans.mtagLabel
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	font  = FONT_NORMAL
	lcd.drawText(x + 3, y + 10, trans.mtagId..":", font)
	lcd.drawText(x + 46, y + 10, trans.mtagCycles..":", font)
	lcd.drawText(x + 3, y + 24, trans.mtagcrate..":", font)
	lcd.drawText(x + 46, y + 24, trans.mtagCells..":", font)

	text  = string.format("%d", mtag[1])
	lcd.drawText(x + 21, y + 10, text, font)

	text  = string.format("%d", mtag[3])
	lcd.drawText(x + 96, y + 10, text, font)

	text  = string.format("%d", mtag[5])
	lcd.drawText(x + 21, y + 24, text, font)

	text  = string.format("%d", mtag[4])
	lcd.drawText(x + 96, y + 24, text, font)
end
----------------------------------------------------------------
function ka.drawCRate(x, y) -- Crate
	local font, text, width

	font  = FONT_MINI
	text  = trans.crate
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%.0f", prate)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 113 - width, y + 3, text, font)
	lcd.drawText(x + 113, y + 19, "%", FONT_NORMAL)

	font  = FONT_MAXI
	text  = string.format("%.0f", arate)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 47 - width, y + 3, text, font)
	lcd.drawText(x + 47, y + 19, "C", FONT_NORMAL)

end
-----------------------------------------------------------------
function ka.drawName(x, y) -- MTAG
  local font, text, width

	font  = FONT_MINI
	text  = trans.name
	width = lcd.getTextWidth(font, text)
	
	 
	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 25)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_NORMAL
	text  = name or trans.empty
	width = lcd.getTextWidth(font, text)

	if (width > 124) then
		font  = FONT_MINI
		width = lcd.getTextWidth(font, text)
	end

	lcd.drawText(x + 66 - width/2, y + 8, text, font)
end
------------------------------------------------------------------
function ka.drawKw(x, y) -- KW  Sensor 2x3 = WAtt
  local font, text, width

	font  = FONT_MAXI
	text  = string.format("%.2f", kw.value)
	width = lcd.getTextWidth(font, text)
	
	 
	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 28)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 100 - width, y - 6, text, font)

	font  = FONT_MINI
	text  = string.format("%.2f", kw.limit)
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 107, y +3, "max", font)
	lcd.drawText(x + 130 - width, y + 12, text, font)
	lcd.drawText(x + 3, y +4, "k", font)
	lcd.drawText(x + 3, y +12, "W", font)
	
end
------------------------------------------------------------------
function ka.drawLei(x, y) -- Gaswert in %
	local font, text, width

	font  = FONT_MINI
	text  = trans.lei
	width = lcd.getTextWidth(font, text)
	
	 
	changeColor(colors.color12)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%.0f", values[34])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 68 - width, y + 3, text, font)
	lcd.drawText(x + 69, y + 20, "%", FONT_BOLD)

	font  = FONT_MINI
	text  = string.format("%.0f", limits[34])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 100, y + 12, trans.m, font)
	lcd.drawText(x + 113 - width, y + 22, text, font)
	lcd.drawText(x + 113, y + 22, "%", font)

end

-----------------------------------------------------------------
function ka.drawAssall(x, y, label, label1, label2, label3) 
  local font, text, width
	local value = values[35]

	if (value == 1) then
		text = label1
	elseif (value == 2) then
		text = label2
	elseif (value == 3) then
		text = label3
	else
		text = label
  end

	changeColor(colors.color15)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 19)
	
	lcd.setColor(0, 0, 0)

  font  = FONT_BIG
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 64 - width/2, y - 1, text, font)
end
--------------------------------------------------------------
function ka.drawAss(x, y) 
	return ka.drawAssall (x, y, trans.A0, trans.A1, trans.A2, trans.A3)
end
--------------------------------------------------------------
function ka.drawAss1(x, y) 
	return ka.drawAssall (x, y, trans.As0, trans.As1, trans.As2, trans.As3)
end
--------------------------------------------------------------
function ka.drawAss2(x, y) 
	return ka.drawAssall (x, y,trans.Ass0, trans.Ass1, trans.Ass2, trans.Ass3)
end
---------------------------------------------------------------
function ka.drawPercentsss(x, y, capa, remaining, alarmValue1, alarmValue2)
	if (Calca_dispFuel ~= nil and Calca_capacity ~= nil) then
		remaining = Calca_dispFuel
		capa      = Calca_capacity                                                    
	end

  if (capa == 0) then
		return 0
	end
	
	changeColor(colors.color20)
	lcd.drawFilledRectangle(x + 1, y + 11, 52, 143)

	local chgH, chgY

	chgH = math.floor(remaining * 1.41)
	chgY = 153 - chgH

	if (remaining <= alarmValue1) then
		changeColor(colors.color05)
	elseif (remaining <= alarmValue2) then	
		changeColor(colors.color04)
	else		
		changeColor(colors.color03)
	end

	lcd.drawFilledRectangle(x + 2, y + chgY, 50, chgH)
	
	if (remaining > alarmValue2) then
		chgH = math.floor(alarmValue2 * 1.41)
		chgY = 153 - chgH	
		changeColor(colors.color04)
		lcd.drawFilledRectangle(x + 2, y + chgY, 50, chgH)
	end

	if (remaining > alarmValue1) then
		chgH = math.floor(alarmValue1 * 1.41)
		chgY = 153 - chgH	
		changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 2, y + chgY, 50, chgH)
	end

	setColor()

	if (battery == nil) then
		battery = loadImage(fileBattery)
	end

	if (battery) then
		lcd.drawImage(x + 1, y + 3, battery)
	else
		lcd.drawRectangle(x + 1, y + 11, 52, 143)
		lcd.drawFilledRectangle(x + 15, y + 5, 24, 7)
	end

	local alarm, blink, full, font, text, width

	alarm = remaining <= alarmValue1
  blink = system.getTime() % 2 == 0 

	if (not alarm or blink) then
	  full   = remaining >= 99.5
		font   = full and FONT_BOLD or FONT_MAXI
	  text   = string.format("%.0f", remaining)
	  width  = lcd.getTextWidth(font, text)

		if (alarm and blink) then
		  changeColor(colors.color05)
			
		end

		lcd.drawText(x + 22 - width/2, y + (full and 46 or 31), text, font)
		lcd.drawText(x + 21 + width/2, y + (full and 46 or 46), "%", FONT_NORMAL)
		setColor()
	end


	font  = FONT_NORMAL
	text  = string.format("%d", capa)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 27 - width/2, y + 114, text, font)

	text  = "mAh"
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 27 - width/2, y + 128, text, font)

end

-----------------------------------------------------------------

function ka.drawTurbine(x, y) 
  if  (Global_TurbineState== nil) then
		return 0
	end

	local font, text, width
	changeColor(colors.color06)
	 
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 19)
	
	lcd.setColor(0, 0, 0)

	font   = FONT_BOLD
	text   = (Global_TurbineState)
	width  = lcd.getTextWidth(font, text)

	lcd.drawText(x + 64 - width/2, y + 1, text, font)

end
---------------------------------------------------------------
function ka.drawCRateo(x, y) -- Crate
 local font, text, width

	font  = FONT_MINI
	text  = trans.crate
	width = lcd.getTextWidth(font, text)
	
	 
	changeColor(colors.color07)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = FONT_MAXI
	text  = string.format("%.0f", prates)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 113 - width, y + 3, text, font)
	lcd.drawText(x + 113, y + 19, "%", FONT_NORMAL)

	font  = FONT_MAXI
	text  = string.format("%.0f", arates)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 47 - width, y + 3, text, font)
	lcd.drawText(x + 47, y + 19, "C", FONT_NORMAL)

end
----------------------------------------------------------------
---[[
function ka.drawhightbig(x, y)  --H�henanzeige Gro� 3/4 Breite
	local font, text, width 

	
	changeColor(colors.color14)
	lcd.drawFilledRectangle(x + 2, y + 1, 179, 79)
	lcd.setColor(0, 0, 0)
		
 if (se.bluehight > 0 and values[6] >= se.bluehight) then 
   changeColor(colors.color05)
	 
	 lcd.drawFilledRectangle(x + 160, y + 1 , 21, 79)
	 lcd.setColor(0, 0, 0)
	 lcd.drawText(x +166, y + 17, "!", FONT_MAXI)
 end

	lcd.drawText(x + 160, y + 56, "m", FONT_BIG)
	drawNumber(x + 163, y + 2, values[6], 0, true, 4)
	
	
end
--]]
-----------------------------------------------------------
--[[
function ka.drawhightbig(x, y)  --H�henanzeige Gro� ganze Breite
	local font, text, width
  se.bluehight = 400
	values[6] = 830
	changeColor(colors.color14)
	lcd.drawFilledRectangle(2, y + 0, 314, 79)
	lcd.setColor(0, 0, 0)
		
 if (se.bluehight > 0 and values[6] >= se.bluehight) then 
   changeColor(colors.color05)
	 lcd.drawFilledRectangle(2, y + 0 , 20, 79)
	 lcd.setColor(0, 0, 0)
	 lcd.drawText(7, y + 20, "!", FONT_MAXI)
 end

	lcd.drawText(266, y + 56, "m", FONT_BIG)
	drawNumber(270, y + 2, values[6], 0, true, 4)
	
	return 80
end
--]]
---------------------------------------------------------------
function ka.drawkapatbig(x, y) 
	local font, text, width
	
	changeColor(colors.color03)
	lcd.drawFilledRectangle(2, y + 0, 314, 79)
	lcd.setColor(0, 0, 0)

	if (remaining1 > 0 and remaining1 <= se.alarmValue1) then
		
		changeColor(colors.color05)
		lcd.drawFilledRectangle(1, y + 0, 316, 79)
		lcd.setColor(0, 0, 0)
	elseif (remaining1 > 0 and remaining1 <= se.alarmValue11) then
		changeColor(colors.color04)
		
		lcd.drawFilledRectangle(1, y + 0, 316, 79)
		lcd.setColor(0, 0, 0)
	end

  lcd.drawText(265, y + 56, "mAh", FONT_BIG) 
	drawNumber(270, y + 2, values[4], 0, true, 4)
	

end

---------------------------------------------------------------
function ka.drawcbao (x, y)
  local chgb,  font, text, width
	if (capa3 == 0) then
		return 0
	end

  changeColor(colors.color10)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)
	chgb = math.floor(remaining3 * 1.23)

	if (remaining3 <= se.alarmValue3) then
		changeColor(colors.color05)
		
	else
	  changeColor(colors.color03)		
	end
	lcd.drawFilledRectangle(x + 4, y + 5,chgb,7)

	chgb = math.floor(remaining4 * 1.23)

	if (remaining3 <= se.alarmValue3) then
		changeColor(colors.color05)	
	else
		changeColor(colors.color03)		
	end
	lcd.drawFilledRectangle(x + 4, y + 15,chgb,7)

	lcd.setColor(0, 0, 0)
  lcd.drawText(x + 40, y + 20, "%", font)
	lcd.drawText(x + 100, y + 20, "%", font)

	font  = FONT_BOLD
	text  = string.format("%.0f", remaining3)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 40 - width, y + 20, text, font)
	
	font  = FONT_BOLD
	text  = string.format("%.0f", remaining4)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 100 - width, y + 20, text, font)

	lcd.drawRectangle(x +4, y + 4, 124, 9)
	lcd.drawRectangle(x +4, y + 14, 124, 9)

end
---------------------------------------------------------------------------------
function ka.drawcb(x, y)
	local font, text, width

	font  = FONT_MINI
	text  = trans.cb
	width = lcd.getTextWidth(font, text)
	
	 
	changeColor(colors.color10)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 48)
	
	lcd.setColor(0, 0, 0)


	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	--Kapa 1
	font  = FONT_MINI
	lcd.drawText(x + 100, y + 12, "mAh", font)
	lcd.drawText(x + 38, y + 12, "mAh", font)
	lcd.drawText(x + 117, y + 23, "V", font)
	lcd.drawText(x + 55, y + 23, "V", font)
	lcd.drawText(x + 55, y + 36, "A", font)
	lcd.drawText(x + 117, y + 36, "A", font)

	font  = FONT_BOLD
	text  = string.format("%.0f", values[29])
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 37 - width, y + 7, text, font)
	--Kapa2
  font  = FONT_BOLD
	text  = string.format("%.0f", values[30])
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 99 - width, y + 7, text, font)

	--------------------------------------------------------
	font  = FONT_BOLD	-- Volt
	text  = string.format("%.2f", values[27])
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 54 - width, y + 19, text, font)
	text  = string.format("%.2f", values[28])
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 116 - width, y + 19, text, font)
	-------------------------------------------------------
	font  = FONT_BOLD
	text  = string.format("%.2f", values[31])
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 54 - width, y + 31, text, font)
	text  = string.format("%.2f", values[32])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 116 - width, y + 31, text, font)
	
end

--------------------------------------------------------------------------------
function ka.drawcbaa(x, y) 
if (Global_cell1_Perc == nil or Global_cell2_Perc == nil or Global_alarmVal == nil) then
		return 0
	end
 local chgb,  font, text, width
 
   
  changeColor(colors.color10)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)


	chgb = math.floor(Global_cell1_Perc * 1.23)

	if (Global_cell1_Perc <= Global_alarmVal) then
		
	 changeColor(colors.color05)
	else
	 changeColor(colors.color03)
	
	end
	lcd.drawFilledRectangle(x + 4, y + 5,chgb,7)

	chgb = math.floor(Global_cell2_Perc * 1.23)

	if (Global_cell2_Perc <= Global_alarmVal) then
		
	 changeColor(colors.color05)
	else
	
	 changeColor(colors.color03)
	end
	lcd.drawFilledRectangle(x + 4, y + 15,chgb,7)

	lcd.setColor(0, 0, 0)
  lcd.drawText(x + 40, y + 20, "%", font)
	lcd.drawText(x + 100, y + 20, "%", font)

	font  = FONT_BOLD
	text  = string.format("%.0f", Global_cell1_Perc)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 40 - width, y + 20, text, font)
	
	font  = FONT_BOLD
	text  = string.format("%.0f", Global_cell2_Perc)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 100 - width, y + 20, text, font)

	lcd.drawRectangle(x +4, y + 4, 124, 9)
	lcd.drawRectangle(x +4, y + 14, 124, 9)

	
	end

-------------------------------------------------------------------------------
function ka.drawcba(x, y) 
	if (Global_cell1_mAh == nil or Global_cell2_mAh == nil or Global_cell1_V == nil or Global_cell2_V == nil or
	Global_cell1_A == nil or Global_cell2_A == nil or Global_cell1_Perc == nil or Global_cell2_Perc == nil or Global_cellCnt == nil) then
		return 0
	end
	local font, text, width
	
	 
	changeColor(colors.color10)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 58)
	
	lcd.setColor(0, 0, 0)

	font  = FONT_MINI
	text  = trans.cb
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)


	font  = FONT_MINI
	lcd.drawText(x + 53, y + 12, "%", font)
	lcd.drawText(x + 115, y + 12, "%", font)
	lcd.drawText(x + 100, y + 23, "mAh", font)
	lcd.drawText(x + 38, y + 23, "mAh", font)
	lcd.drawText(x + 117, y + 36, "V", font)
	lcd.drawText(x + 55, y + 36, "V", font)
	lcd.drawText(x + 55, y + 46, "A", font)
	lcd.drawText(x + 117, y + 46, "A", font)


	--Prozent1
	font  = FONT_BOLD
	text  = string.format("%.0f", Global_cell1_Perc)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 52 - width, y + 7, text, font)
	--Prozent1
	font  = FONT_BOLD
	text  = string.format("%.0f", Global_cell2_Perc)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 114 - width, y + 7, text, font)
	------------------------------------------------
	--Kapa 1
	font  = FONT_BOLD
	text  = string.format("%.0f", Global_cell1_mAh)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 37 - width, y + 19, text, font)
	--Kapa2
  font  = FONT_BOLD
	text  = string.format("%.0f", Global_cell2_mAh)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 99 - width, y + 19, text, font)
	--------------------------------------------------------

	if (Global_voltageDisplay == 1) then
		font  = FONT_BOLD
		text  = string.format("%.2f",Global_cell2_V)
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 116 - width,y + 31,text,font)
	else
		font  = FONT_BOLD
		text  = string.format("%.2f",Global_cell2_V*Global_cellCnt)
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 116 - width,y + 31,text,font)
	end

	if (Global_voltageDisplay == 1) then
		font  = FONT_BOLD
		text  = string.format("%.2f",Global_cell1_V)
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 54 - width,y + 31,text,font)
	else
		font  = FONT_BOLD
		text  = string.format("%.2f",Global_cell1_V*Global_cellCnt)
		width = lcd.getTextWidth(font, text)

		lcd.drawText(x + 54 - width,y + 31,text,font)
	end

	-------------------------------------------------------
	font  = FONT_BOLD
	text  = string.format("%.2f", Global_cell1_A)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 54 - width, y + 42, text, font)
	text  = string.format("%.2f", Global_cell2_A)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 116 - width, y + 42, text, font)
	-------------------------------------------------------
end
--------------------------------------------------------------------------------
function ka.drawMbar(x, y)
 local font, text, width, small
  small = values[40] >= 10000

	font  = FONT_MINI
	text  = trans.MBAR
	width = lcd.getTextWidth(font, text)
	
	 
	changeColor(colors.color12)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

	font  = small and FONT_BOLD or FONT_MAXI
	text  = string.format("%.1f", values[40])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 100 - width + (small and -20 or 0), y +3 + (small and 13 or 0), text, font)
	lcd.drawText(x + 99, y + 19, unitmbar, FONT_NORMAL)


	end
---------------------------------------------------------------
	function ka.vspeak1(x, y)  
		 
	changeColor(colors.color06)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 19)
	
	lcd.setColor(0, 0, 0)

  if  (Global_Status1Text== nil) then
		return 0
	end

	local font, text, width

	font   = FONT_BOLD
	text   = (Global_Status1Text)
	width  = lcd.getTextWidth(font, text)

	lcd.drawText(x + 64 - width/2, y + 1, text, font)

end
---------------------------------------------------------------
		function ka.vspeak2(x, y)  
  if  (Global_Status2Text== nil) then
		return 0
	end

	local font, text, width
	
	changeColor(colors.color06)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 19)
	
	lcd.setColor(0, 0, 0)

	font   = FONT_BOLD
	text   = (Global_Status2Text)
	width  = lcd.getTextWidth(font, text)

	lcd.drawText(x + 64 - width/2, y + 1, text, font)

 
end

---------------------------------------------------------------
function ka.drawAkkud(x, y) -- Akku gespeichert
	local font, text, width

	font  = FONT_MINI
	text  = trans.akku
	width = lcd.getTextWidth(font, text)
	
	 
	changeColor(colors.color03)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)
	
	if (remaining1 > 0 and remaining1 <= se.alarmValue1) then
		changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
		lcd.setColor(0, 0, 0)
	elseif (remaining1 > 0 and remaining1 <= se.alarmValue11) then
	  changeColor(colors.color04)
		
		lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
		lcd.setColor(0, 0, 0)
	end

  lcd.drawText(x + 66 - width/2, y - 1, text, font)
  lcd.drawText(x + 90, y + 24, "mAh", font)

	font  = FONT_MAXI
	text  = string.format("%.0f", capaSum)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 90 - width, y + 3, text, font)

end
--------------------------------------------------------------
function ka.drawSpeed3(x, y) -- Gps
	local font, text, width
	local unit = unitSpeed == unitSpeed2 and "km/h" or unitSpeed

	font  = FONT_MINI
	text  = trans.speed3a
	width = lcd.getTextWidth(font, text)
	
	 
	changeColor(colors.color14)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	lcd.drawText(x + 73, y + 24, unit, font)

	font  = FONT_MAXI
	text  = string.format("%.0f", values[41])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 70 - width, y + 3, text, font)

	font  = FONT_MINI
	text  = string.format("%.0f", limits[41])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 106, y + 13, "max", font)
	lcd.drawText(x + 126 - width, y + 23, text, font)
end
---------------------------------------------------------------
function ka.drawPercents2 (x, y, capa1, remaining1, alarmValue1, alarmValue11, capa2, remaining2, alarmValue2, alarmValue22) --zwei Akkus Robert six
	if (capa1 == 0 and capa2 == 0) then
		return 0
	end
	
	changeColor(colors.color20)
	lcd.drawFilledRectangle(x + 1, y + 11, 52, 143)

	local chgH, chgY

	setColor()
  lcd.drawLine(x+26, y+12, x+26, y+153)

	chgH = math.floor(remaining1 * 1.41)
	chgY = 153 - chgH

	if (remaining1 <= alarmValue1) then
    changeColor(colors.color05)
		
	elseif (remaining1 <= alarmValue11) then
	  changeColor(colors.color04)
	else
	  changeColor(colors.color03)
	end

	lcd.drawFilledRectangle(x + 2, y + chgY, 24, chgH)  

	if (remaining1 > alarmValue11) then
		chgH = math.floor(alarmValue11 * 1.41)
		chgY = 153 - chgH
		
    changeColor(colors.color04)

		lcd.drawFilledRectangle(x + 2, y + chgY, 24, chgH)
	end
	
	if (remaining1 > alarmValue1) then
		chgH = math.floor(alarmValue1 * 1.41)
		chgY = 153 - chgH
		
    changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 2, y + chgY, 24, chgH)
	end

	setColor()

  chgH = math.floor(remaining2 * 1.41)
	chgY = 153 - chgH

	if (remaining2 <= alarmValue2) then
	  changeColor(colors.color05)
	elseif (remaining2 <= alarmValue22) then
	  changeColor(colors.color04)
	else
	  changeColor(colors.color03)
	end

	lcd.drawFilledRectangle(x + 27, y + chgY, 25, chgH)

	if (remaining2 > alarmValue22) then
		chgH = math.floor(alarmValue22 * 1.41)
		chgY = 153 - chgH

    changeColor(colors.color04)
		lcd.drawFilledRectangle(x + 27, y + chgY, 25, chgH)
	end
	
	if (remaining2 > alarmValue2) then
		chgH = math.floor(alarmValue2 * 1.41)
		chgY = 153 - chgH

    changeColor(colors.color05)
		lcd.drawFilledRectangle(x + 27, y + chgY, 25, chgH)
	end

	setColor()

	if (battery == nil) then
		battery = loadImage(fileBattery)
	end

	if (battery) then
		lcd.drawImage(x + 1, y + 3, battery)
	else
		lcd.drawRectangle(x + 1, y + 11, 52, 143)
		lcd.drawFilledRectangle(x + 7, y + 5, 13, 7)
		lcd.drawFilledRectangle(x + 33, y + 5, 13, 7)
	end

	local alarm, blink, font, text, width

	alarm = remaining1 <= alarmValue1
	blink = system.getTime() % 2 == 0

	if (not alarm or blink) then
	  font = FONT_BOLD
		
		text  = string.format("%.0f", remaining1)
		width = lcd.getTextWidth(font, text)

		if (alarm and blink) then
			changeColor(colors.color05)
		end
    lcd.drawText(x + 14 - width/2, y + 25, text, font)
		lcd.drawText(x + 8, y + 39, "%", font)
		setColor()
	end

	alarm = remaining2 <= alarmValue2
	blink = system.getTime() % 2 == 0 

	if (not alarm or blink) then
		full  = remaining2 >= 99.5
		font  = FONT_BOLD
		text  = string.format("%.0f", remaining2)
		width = lcd.getTextWidth(font, text)

		if (alarm and blink) then
			changeColor(colors.color05)
		end
    lcd.drawText(x + 39 - width/2, y + 25, text, font)
		lcd.drawText(x + 34, y + 39, "%", font)

		setColor()
	end


	font  = FONT_MINI

	text  = string.format("%d", capa1)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 14 - width/2, y + 127, text, font)

	text  = "mAh"
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 14 - width/2, y + 139, text, font)

	text  = string.format("%d", capa2)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 40 - width/2, y + 127, text, font)

	text  = "mAh"
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 40 - width/2, y + 139, text, font)

end

-------------------------------------------------------------------------------------------------------------
function ka.drawRPM2(x, y) -- RPM2   
  local font, text, width
	local small = values[42] >= 100000
	

	changeColor(colors.color06)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 27)
	
	lcd.setColor(0, 0, 0)

	font  = small and FONT_BOLD or FONT_MAXI
	text  = string.format("%.0f", values[42])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 100 - width + (small and -20 or 0), y - 6 + (small and 13 or 0), text, font)

	font  = FONT_MINI
	text  = string.format("%.0f", limits[42])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 107, y +3, "max", font)
	lcd.drawText(x + 130 - width, y + 12, text, font)
	lcd.drawText(x + 3, y +0, "R", font)
	lcd.drawText(x + 3, y +8, "P", font)
	lcd.drawText(x + 3, y +16, "M", font)

	
end
 ------------------------------------------------------------
  function ka.drawKordinaten(x, y) -- Gps Kordinaten
	
	local font, text, width

	font  = FONT_MINI
	text  = trans.kordinatena
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color14)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 43)
	
	lcd.setColor(0, 0, 0) 

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

  font  = FONT_NORMAL
  lcd.drawText(x + 1, y + 10, "B:", font)
	lcd.drawText(x + 1, y + 26, "L:", font)

	local nesw   = {"N", "E", "S", "W"}
	local latDeg = (se.gpsLatVal >> 16) & 0xFF
	local lonDeg = (se.gpsLonVal >> 16) & 0xFF
	local latMin = (se.gpsLatVal & 0xFFFF) * 0.001
	local lonMin = (se.gpsLonVal & 0xFFFF) * 0.001
	
  font  = FONT_BIG
	text  = string.format("%3d\u{B0}%2.3f'", latDeg, latMin)
	width = lcd.getTextWidth(font, text)
	
	lcd.drawText(x + 112 - width, y + 8, text, font)
	lcd.drawText(x + 112, y + 8, nesw[se.gpsLatDec+1], font)
	
	text  = string.format("%3d\u{B0}%2.3f'", lonDeg, lonMin)
	width = lcd.getTextWidth(font, text)
	
	lcd.drawText(x + 112 - width, y + 24, text, font)
	lcd.drawText(x + 112, y + 24, nesw[se.gpsLonDec+1], font)
	
end
---------------------------------------------------------------------
function ka.drawIgnition(x, y)   
	local text, font, width 
	
  font  = FONT_BOLD  
	text  = trans.noPicture
	width = lcd.getTextWidth(font, text)	
	
	changeColor(colors.color19)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 38)
  lcd.setColor(0, 0, 0)

	if (ignitio and ignitio > 0) then
   	if (se.IgnitioUP == nil) then  
		  se.IgnitioUP =  loadImage("zuendung_aus") 
	  end	
	  if (se.IgnitioUP) then 
      lcd.drawImage(x + 2, y + 1, se.IgnitioUP)
		else
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end				
	else
		if (se.IgnitioDown == nil) then  
		   se.IgnitioDown =  loadImage("zuendung_ein") 
	  end	
	  if (se.IgnitioDown) then  
      lcd.drawImage(x + 2, y + 1, se.IgnitioDown)
		else	
		
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end	
  end
	
	font  = FONT_MINI
	text  = trans.ignitio
	width = lcd.getTextWidth(font, text)
	
  lcd.setColor(0, 0, 0)
	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	setColor()
end
-----------------------------------------------------------------------------------------------------------------
function ka.drawIgnition1(x, y)   
	local text, font, width 
	
  font  = FONT_BOLD  
	text  = trans.noPicture
	width = lcd.getTextWidth(font, text)	
	
	changeColor(colors.color19)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 38)
  lcd.setColor(0, 0, 0)

	if (ignitio and ignitio > 0) then
   	if (se.IgnitioUP1 == nil) then  
		  se.IgnitioUP1 =  loadImage("rauch_aus") 
	  end	
	  if (se.IgnitioUP1) then 
      lcd.drawImage(x + 2, y + 1, se.IgnitioUP1)
		else
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end				
	else
		if (se.IgnitioDown1 == nil) then  
		   se.IgnitioDown1 =  loadImage("rauch_ein") 
	  end	
	  if (se.IgnitioDown1) then  
      lcd.drawImage(x + 2, y + 1, se.IgnitioDown1)
		else	
		
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end	
  end
	
	font  = FONT_MINI
	text  = trans.smoke
	width = lcd.getTextWidth(font, text)
	
  lcd.setColor(0, 0, 0)
	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	setColor()
end
----------------------------------------------------------------------------------
function ka.drawIgnition2(x, y)   
	local text, font, width 
	
  font  = FONT_BOLD  
	text  = trans.noPicture
	width = lcd.getTextWidth(font, text)	
	
	changeColor(colors.color19)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 38)
  lcd.setColor(0, 0, 0)

	if (ignitio and ignitio > 0) then
   	if (se.IgnitioUP2 == nil) then  
		  se.IgnitioUP2 =  loadImage("impeller_aus") 
	  end	
	  if (se.IgnitioUP2) then 
      lcd.drawImage(x + 2, y + 1, se.IgnitioUP2)
		else
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end				
	else
		if (se.IgnitioDown2 == nil) then  
		   se.IgnitioDown2 =  loadImage("impeller_ein") 
	  end	
	  if (se.IgnitioDown2) then  
      lcd.drawImage(x + 2, y + 1, se.IgnitioDown2)
		else	
		
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end	
  end
	
	font  = FONT_MINI
	text  = trans.impeller
	width = lcd.getTextWidth(font, text)
	
  lcd.setColor(0, 0, 0)
	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	setColor()
end
---------------------------------------------------------------------
function ka.drawTowingClutch(x, y)   
	local text, font, width 
	
  font  = FONT_BOLD   
	text  = trans.noPicture
	width = lcd.getTextWidth(font, text)	
	
	changeColor(colors.color19)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 38)
  lcd.setColor(0, 0, 0)

	if (clutch and clutch > 0) then
   	if (se.TowingClutchUP == nil) then  
		  se.TowingClutchUP =  loadImage("KupplungFrei") 
	  end	
	  if (se.TowingClutchUP) then 
      lcd.drawImage(x + 2, y + 1, se.TowingClutchUP)
		else
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end				
	else
		if (se.TowingClutchDOWN == nil) then  
		   se.TowingClutchDOWN =  loadImage("KupplungEin") 
	  end	
	  if (se.TowingClutchDOWN) then  
      lcd.drawImage(x + 2, y +1, se.TowingClutchDOWN)
		else	
		
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end	
  end
	
	font  = FONT_MINI
	text  = trans.towingClutch
	width = lcd.getTextWidth(font, text)
	
  lcd.setColor(0, 0, 0)
	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	setColor()
	
end
---------------------------------------------------------------------
function ka.drawGear(x, y)  
	local text, font, width 
	
  font  = FONT_BOLD    
	text  = trans.noPicture
	width = lcd.getTextWidth(font, text)

  changeColor(colors.color18)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 38)
	lcd.setColor(0, 0, 0)

	if (gear and gear > 0) then
   	if (se.GearUP == nil) then  
		  se.GearUP =  loadImage("Fahrwerk_UP") 
	  end	
	  if (se.GearUP) then 
      lcd.drawImage(x + 2, y + 1, se.GearUP)
		else
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end				
	else
		if (se.GearDOWN == nil) then  
		   se.GearDOWN =  loadImage("Fahrwerk_DOWN") 
	  end	
	  if (se.GearDOWN) then  
      lcd.drawImage(x + 2, y + 1, se.GearDOWN)
		else	
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end	
  end
	
	font  = FONT_MINI
	text  = trans.gear
	width = lcd.getTextWidth(font, text)
	
  lcd.setColor(0, 0, 0)
	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	setColor()
end
---------------------------------------------------------------------------------
function ka.drawGear1(x, y)  
	local text, font, width 
	
  font  = FONT_BOLD    
	text  = trans.noPicture
	width = lcd.getTextWidth(font, text)

  changeColor(colors.color18)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 38)
	lcd.setColor(0, 0, 0)

	if (gear and gear > 0) then
   	if (se.GearUP1 == nil) then  
		  se.GearUP1 =  loadImage("Fahrwerk_UP1") 
	  end	
	  if (se.GearUP1) then 
      lcd.drawImage(x + 2, y + 1, se.GearUP1)
		else
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end				
	else
		if (se.GearDOWN1 == nil) then  
		   se.GearDOWN1 =  loadImage("Fahrwerk_DOWN1") 
	  end	
	  if (se.GearDOWN1) then  
      lcd.drawImage(x + 2, y + 1, se.GearDOWN1)
		else	
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end	
  end
	
	font  = FONT_MINI
	text  = trans.gear
	width = lcd.getTextWidth(font, text)
	
  lcd.setColor(0, 0, 0)
	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	setColor()
end
----------------------------------------------------------------------------------
function ka.drawGear2(x, y)  
	local text, font, width 
	
  font  = FONT_BOLD    
	text  = trans.noPicture
	width = lcd.getTextWidth(font, text)

  changeColor(colors.color18)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 38)
	lcd.setColor(0, 0, 0)

	if (gear and gear > 0) then
   	if (se.GearUP2 == nil) then  
		  se.GearUP2 =  loadImage("Fahrwerk_UP2") 
	  end	
	  if (se.GearUP2) then 
      lcd.drawImage(x + 2, y + 1, se.GearUP2)
		else
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end				
	else
		if (se.GearDOWN2 == nil) then  
		   se.GearDOWN2 =  loadImage("Fahrwerk_DOWN2") 
	  end	
	  if (se.GearDOWN2) then  
      lcd.drawImage(x + 2, y + 1, se.GearDOWN2)
		else	
      lcd.drawText(x + 66 - width/2, y + 12, text, font)
	  end	
  end
	
	font  = FONT_MINI
	text  = trans.gear
	width = lcd.getTextWidth(font, text)
	
  lcd.setColor(0, 0, 0)
	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	setColor()
end
----------------------------------------------------------------------------------------------------
function ka.drawFlaps(x, y)   
	local text, font, width
	
	font  = FONT_BOLD    
	text  = trans.noPicture
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color17)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 38)
	lcd.setColor(0, 0, 0)
	
	if (flaps and flaps < -0.333) then  
	  if (se.FlapsUP == nil) then  
		  se.FlapsUP =  loadImage("Flaps_UP") 
	  end	
	  if (se.FlapsUP) then  	
			lcd.drawImage(x + 2, y + 1, se.FlapsUP)  
		else
      lcd.drawText(x + 66 - width/2, y + 13, text, font)
		end				 
	elseif (flaps and flaps > 0.333) then
		if (se.FlapsDOWN == nil) then  
		  se.FlapsDOWN =  loadImage("Flaps_DOWN") 
	  end	
		if (se.FlapsDOWN) then  
      lcd.drawImage(x + 2, y + 1, se.FlapsDOWN)	
		else
      lcd.drawText(x + 66 - width/2, y + 13, text, font)
		end		 
	else
		if (se.FlapsMID == nil) then  
		  se.FlapsMID =  loadImage("Flaps_MID") 
		end	
		if (se.FlapsMID) then  
			lcd.drawImage(x + 2, y + 1, se.FlapsMID)
		else
      lcd.drawText(x + 66 - width/2, y + 13, text, font)
		end
	end
	
	font  = FONT_MINI
	text  = trans.flaps
	width = lcd.getTextWidth(font, text)
	
  lcd.setColor(0, 0, 0)
	lcd.drawText(x + 66 - width/2, y - 1, text, font)
  setColor()
end
----------------------------------------------------------------
function ka.drawFlaps1(x, y)   
	local text, font, width

	changeColor(colors.color17)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 38)
	lcd.setColor(0, 0, 0)
 
  font  = FONT_BOLD  
	text  = trans.noPicture
	width = lcd.getTextWidth(font, text)
	
	if (flaps and flaps < -0.333) then  
	  if (se.FlapsUP1 == nil) then  
		  se.FlapsUP1 =  loadImage("Flaps_UP1") 
	  end	
	  if (se.FlapsUP1) then  	
			lcd.drawImage(x + 2, y + 1, se.FlapsUP1)  
		else
      lcd.drawText(x + 66 - width/2, y + 13, text, font)
		end				 
	elseif (flaps and flaps > 0.333) then
		if (se.FlapsDOWN1 == nil) then  
		  se.FlapsDOWN1 =  loadImage("Flaps_DOWN1") 
	  end	
		if (se.FlapsDOWN1) then  
      lcd.drawImage(x + 2, y + 1, se.FlapsDOWN1)	
		else
      lcd.drawText(x + 66 - width/2, y + 13, text, font)
		end		 
	else
		if (se.FlapsMID1 == nil) then  
		  se.FlapsMID1 =  loadImage("Flaps_MID1") 
		end	
		if (se.FlapsMID1) then  
			lcd.drawImage(x + 2, y + 1, se.FlapsMID1)
		else
      lcd.drawText(x + 66 - width/2, y + 13, text, font)
		end
	end
	
	font  = FONT_MINI
	text  = trans.flaps
	width = lcd.getTextWidth(font, text)
	
  lcd.setColor(0, 0, 0)
	lcd.drawText(x + 66 - width/2, y - 1, text, font)
  setColor()
end
-----------------------------------------------------------------------------
function ka.drawServo(x, y)
	local text, font, width	

  font  = FONT_MINI   
	text  = trans.servos
	width = lcd.getTextWidth(font, text)
	
	changeColor(colors.color12)
	lcd.drawFilledRectangle(x + 2, y + 1, 128, 36)
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	                
  font  = FONT_MAXI
  text  = string.format("%.0f%%",  100 * val)
	width = lcd.getTextWidth(font, text)
  lcd.drawText(x + 98 - width, y + 3, text, font)	

  font  = FONT_MINI 
	text  = string.format("%.0f%%",  100 * maxval)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 128 - width, y + 12, text, font)
	
	font  = FONT_MINI 
	text  =  string.format("%.0f%%",  100 * minval)
	width = lcd.getTextWidth(font, text)
	lcd.drawText(x + 128 - width, y + 25, text, font)
	
 	
end
-----------------------------------------------------------------

function ka.drawHeightBig (x, y) -- H�he
	local font, text, width
	
	changeColor(colors.color14)
  lcd.drawFilledRectangle(x + 2, y + 1, 128, 54)
	lcd.setColor(0, 0, 0)

if (se.bluehight > 0 and values[6] >= se.bluehight) then
	  changeColor(colors.color05)
	
		lcd.drawFilledRectangle(x + 2, y + 1, 10, 54)
	  lcd.setColor(0, 0, 0)
	  lcd.drawText(x + 2, y + 5, "!", FONT_MAXI)
  end
	

	lcd.drawText(x + 104, y + 37, "m", FONT_BOLD)

	font  = FONT_MINI
	text  = string.format("%dm",limits [6])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 103, y + 9, "max:", font)
	lcd.drawText(x + 129 - width, y + 20, text, font)
	
	drawNumber(x + 103, y + 13, values[6], 0, true, 1)
	
  font  = FONT_MINI   
	text  = trans.height
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)

  setColor()
	
end
------------------------------------------------------------------

function ka.drawCurrentBig (x, y) 
	local font, text, width
	
		
	changeColor(colors.color07)
  lcd.drawFilledRectangle(x + 2, y + 1, 128, 54)
	lcd.setColor(0, 0, 0)

	lcd.drawText(x + 97, y + 37, "A", FONT_BOLD)

	font  = FONT_MINI
	text  = string.format("%.1fA",limits [3])
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 101, y + 9, "max:", font)
	lcd.drawText(x + 129 - width, y + 20, text, font)
	
	
	drawNumber(x + 97, y + 13, values[3], 0, true, 1)
	
  font  = FONT_MINI   
	text  = trans.current
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)
	setColor()

	
end

----------------------------------------------------------------

function ka.drawAkkuVtgBig (x, y) 
	local font, text, width
	
	changeColor(colors.color07)
  lcd.drawFilledRectangle(x + 2, y + 1, 128, 54)
	lcd.setColor(0, 0, 0)


	font  = FONT_MINI
	text  = string.format("%.1f",limits [2])
	width = lcd.getTextWidth(font, text)

	--lcd.drawText(x + 83, y + 12, "max/min", font)
	lcd.drawText(x + 104, y + 12, "max:", font)
	lcd.drawText(x + 129 - width, y + 22, text, font)
	--lcd.drawText(x + 122, y + 23, "V", font)
	
	font   = FONT_MINI
	text   = string.format("%.1f", limits[-2])
	width  = lcd.getTextWidth(font, text)
	
  lcd.drawText(x + 106, y + 30, "min:", font)	
	lcd.drawText(x + 129 - width, y + 40, text, font)
	
	drawNumber(x + 109, y + 13, values[2], 1, true, 1)
	
  font  = FONT_MINI   
	text  = trans.akkuvtg
	width = lcd.getTextWidth(font, text)

	lcd.drawText(x + 66 - width/2, y - 1, text, font)
  setColor()
	
end

----------------------------------------------------------------
function ka.drawTiles(index, startX)
	local list   = positions[ index]
	local startY = spacers  [-index] 
	local spaceY = spacers  [ index]
	local value, method, space

	for i=1, positionMax do
		value = list[i]
		
		--[[ Wichtig zur kontrolle
		if (not tile) then
			tile = 0
			lastTile = 0
		end
		
		if (index == 3 and i == 1) then
			local time = system.getTime()
			
			if (time - lastTile >= 1) then  --3 geschwindigkeit
				lastTile = time
				tile     = tile % methodsMax + 1
				
				print(tiles and tiles[tile] or tile)
			end
			
			value = tile
		end
    --]]

		if (value > 1) then
			method = methods[value]
			method(startX, startY)
			
			startY = startY + heights[value] 

			if (heights[value] > 0) then
				startY = startY + spaceY
			end

			if (startY > heightMax) then
				break
			end
		end
	end
	
	drawAlert(0, 0)
	drawBatteryAlert(0, 0) 
end
--------------------------------------------------------------------------------
-- Telemetriefenster 1
function ka.drawPage1(width, height)
	setColor()
	drawBackground()

  if (switchTiles == 1) then
	 ka.drawTiles(1,   0) -- left
	 ka.drawTiles(2, 186) -- right
	 ka.drawTiles(3, 132) -- middle
	elseif (switchTiles == -1) then
	 ka.drawTiles(7,   0) -- left
	 ka.drawTiles(8, 186) -- right
	 ka.drawTiles(9, 132) -- middle
  elseif (switchTiles == 0) then
	 ka.drawTiles(4,   0) -- left                       
	 ka.drawTiles(5, 186) -- right
	 ka.drawTiles(6, 132) -- middle
  else
	 ka.drawTiles(1,   0) -- left
	 ka.drawTiles(2, 186) -- right
	 ka.drawTiles(3, 132) -- middle
	end 
end
--------------------------------------------------------------------------------
-- Telemetriefenster 2
function ka.drawPage2(width, height)
	setColor()
	drawBackground()

	ka.drawTiles(4,   0) -- left
	ka.drawTiles(5, 186) -- right
	ka.drawTiles(6, 132) -- middle
end
--------------------------------------------------------------------------------
local function isSwitch(value)
	if (value) then
		local info = system.getSwitchInfo(value)
		return info and info.assigned
	end
end
--------------------------------------------------------------------------------
local function initForm1(formID)
	local setTitle, addSpacer, addRow, addLabel    = form.setTitle, form.addSpacer, form.addRow, form.addLabel
	local addIntbox, addSelectbox, addInputbox     = form.addIntbox, form.addSelectbox, form.addInputbox
	local addCheckbox, addAudioFilebox, addTextbox = form.addCheckbox, form.addAudioFilebox, form.addTextbox

	setFiles()
	setImages()

	setTitle(trans.title1)

	addRow(2)
	addLabel({label=trans.spirit, width=275})
	spiritForm = addCheckbox(spirit, function(value)
		spirit = not value
		system.pSave("spirit", spirit and 1 or 0)

		indexSensor1 = 1
		system.pSave("sensor1", indexSensor1)

		form.setValue(spiritForm, spirit)
		form.reinit(1)
	end)

	addRow(2)
	addLabel({label=trans.sensor1, width=230})
	addSelectbox(spirit and listLabels1 or listLabels2, indexSensor1, true, function(value)
		indexSensor1 = value
		system.pSave("sensor1", indexSensor1)
	end)

	addRow(2)
	addLabel({label=trans.sensor2, width=230})
	addSelectbox(listLabels2, indexSensor2, true, function(value)
		indexSensor2 = value
		system.pSave("sensor2", indexSensor2)
	end)

  addRow(2)
	addLabel({label=trans.sensor4, width=230})
	addSelectbox(listLabels2, indexSensor4, true, function(value)
		indexSensor4 = value
		system.pSave("sensor4", indexSensor4)
	end)

	addRow(2)
	addLabel({label=trans.sensor6, width=250})
	addSelectbox(listLabels2, indexSensor6, true, function(value)
		indexSensor6 = value
		system.pSave("sensor6", indexSensor6)
	end)

	addRow(2)
	addLabel({label=trans.sensor7, width=230})
	addSelectbox(listLabels2, indexSensor7, true, function(value)
		indexSensor7 = value
		system.pSave("sensor7", indexSensor7)
	end)

	
	 addRow(2)
	 addLabel({label=trans.sensor8, width=230})
	 addSelectbox(listLabels2, indexSensor8, true, function(value)
		 indexSensor8 = value
		 system.pSave("sensor8", indexSensor8)
	 end)


	addRow(2)
	addLabel({label=trans.sensor3,width=200})
	addSelectbox(listLabels2, indexSensor3, true, function(value)
		indexSensor3 = value
		system.pSave("sensor3", indexSensor3)
	end)

	addRow(2)
	addLabel({label=trans.batteries , width=250})
	addIntbox(se.batteries , 0, battMax, 0, 0, 1, function(value)
			if (value > se.batteries ) then
				for i=se.batteries +1, value do
					names[i] = ""
					ids  [i] = 0

					system.pSave("names."..i, names[i])
					system.pSave("ids."  ..i, ids  [i])
				end
			else
				for i=value+1, se.batteries  do
					names[i] = nil
					ids  [i] = nil

					system.pSave("names."..i, names[i])
					system.pSave("ids."  ..i, ids  [i])
				end
			end

			se.batteries = value
			system.pSave("batteries", se.batteries)
		end)

	-------------------------
	addSpacer(318, 4)
	-------------------------

	addRow(2)
	addLabel({label=trans.option, width=200})
	addSelectbox(options, se.option, true, function(value)
		se.option = value
		form.reinit(1)
	end)
	
	if (se.option == 2) then 
	
		
		addLabel({label=trans.labelBat, font=FONT_BOLD}) 
		
		addRow(2)                                --elekto
		addLabel({label=trans.an1Sw})
		addInputbox(sw.an1Sw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.an1Sw = value
			system.pSave("an1Sw", sw.an1Sw)
		end)
		
		addRow(3)
		addLabel({label=trans.capa11, width=198})           --elektro
		addIntbox(capa11, 0, 32767, 0, 0, 10, function(value)
			capa11 = value
			system.pSave("capa11", capa11)
		end, {width=60})
		addIntbox(se.crate, 0, 300, 0, 0, 5, function(value)
			se.crate = value
			system.pSave("crate", se.crate)
		end)                                            --elektro
			--
		addRow(3)                                          --elektro
		addLabel({label=trans.alarmValue1, width=198})
		addIntbox(se.alarmValue1, 0, 100, 0, 0, 1, function(value)
			se.alarmValue1 = value
			system.pSave("alarmValue1", se.alarmValue1)
		end, {width=60})
		addIntbox(se.alarmValue11, 0, 100, 0, 0, 1, function(value)
			se.alarmValue11 = value
			system.pSave("alarmValue11", se.alarmValue11)
		end)
	
		addRow(2)                                         
		addLabel({label=trans.akkuds, width=275})
		akkudForm = addCheckbox(se.akkud, function(value)    --elekto
			se.akkud = not value
			system.pSave("akkud", se.akkud and 1 or 0)
			form.setValue(akkudForm, se.akkud)
		end)

	
		form.addRow(2)                                         --elektro
		addLabel({label=trans.voiceFile1, width=230})
		addAudioFilebox(se.alarmVoice1, function(value)
			se.alarmVoice1 = value
			system.pSave("alarmVoice1", se.alarmVoice1)
		end)

		addRow(2)
		addLabel({label=trans.again, width=275})
		againForm = addCheckbox(se.again, function(value)
			se.again = not value
			system.pSave("again", se.again and 1 or 0)
			form.setValue(againForm, se.again)
		end)

	
		addLabel({label=trans.labelCapaSw})       					--elekto

		addRow(2)
		addLabel({label=trans.capaSw, width=230})            --elekto
		addInputbox(sw.capaSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.capaSw = value
			system.pSave("capaSw", sw.capaSw)
		end)

		addRow(2)
		addLabel({label=trans.capa12, width=230})               --elekto
		addIntbox(capa12, 0, 32767, 0, 0, 10, function(value)
			capa12 = value
			system.pSave("capa12", capa12)
		end)

		addRow(2)                                                 --elekto
		addLabel({label=trans.capa13, width=230})
		addIntbox(capa13, 0, 32767, 0, 0, 10, function(value)
			capa13 = value
			system.pSave("capa13", capa13)
		end)
		
  elseif (se.option == 3) then
	

		addLabel({label=trans.labelgus, font=FONT_BOLD})
	
		addRow(2)                                --verbrenner
		addLabel({label=trans.an2Sw})
		addInputbox(sw.an2Sw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.an2Sw = value
			system.pSave("an2Sw", sw.an2Sw)
		end)

		addRow(2)
		addLabel({label=trans.fuelup, width=275})                     --verbrenner
		fuelForm = addCheckbox(se.fuel, function(value)
			se.fuel = not value
			system.pSave("fuel", se.fuel and 1 or 0)
			form.setValue(fuelForm, se.fuel)
		end)

		addRow(2)                                                --verbrenner
		addLabel({label=trans.capa2, width=230})
		addIntbox(capa2, 0, 9000, 0, 0, 10, function(value)
			capa2 = value
			system.pSave("capa2", capa2)
		end)

		addRow(3)                                                  --verbrenner
		addLabel({label=trans.alarmValue2, width=155})
		addIntbox(se.alarmValue2, 0, 100, 0, 0, 1, function(value)
			se.alarmValue2 = value
			system.pSave("alarmValue2", se.alarmValue2)
		end)
		addIntbox(se.alarmValue22, 0, 100, 0, 0, 1, function(value)
			se.alarmValue22 = value
			system.pSave("alarmValue22", se.alarmValue22)
		end)


		form.addRow(2)                                          --verbrenner
		addLabel({label=trans.voiceFile2})
		addAudioFilebox(se.alarmVoice2, function(value)
			se.alarmVoice2 = value
			system.pSave("alarmVoice2", se.alarmVoice2)
		end)
		
  elseif (se.option == 4) then	
		

		addLabel({label=trans.cbb, font=FONT_BOLD})

		addRow(2)
		addLabel({label=trans.capaA1, width=230})               --Cb
		addIntbox(capa3, 0, 50000, 0, 0, 10, function(value)
			capa3 = value
			system.pSave("capa3", capa3)
		end)

		addRow(2)                                                 --Cb
		addLabel({label=trans.capaB2, width=230})
		addIntbox(capa4, 0, 50000, 0, 0, 10, function(value)
			capa4 = value
			system.pSave("capa4", capa4)
		end)

		addRow(2)                                                  --Cb
		addLabel({label=trans.alarmValue3, width=250})
		addIntbox(se.alarmValue3, 0, 100, 0, 0, 1, function(value)
			se.alarmValue3 = value
			system.pSave("alarmValue3", se.alarmValue3)
		end)

		form.addRow(2)                                          --Cb
		addLabel({label=trans.voiceFile1})
		addAudioFilebox(se.alarmVoice3, function(value)
			se.alarmVoice3 = value
			system.pSave("alarmVoice3", se.alarmVoice3)
		end)
		
		
	elseif (se.option == 5) then
	
	 
		addLabel({label=trans.expertmenu, font=FONT_BOLD})
		

		addLabel({label=trans.expertmenu1, font=FONT_BOLD})
		
		-------------------------
	  addSpacer(318, 4)
   	-------------------------
		
	
		addLabel({label=trans.vorflug, font=FONT_BOLD}) 
		
		addRow(2)                                          --experten
		addLabel({label=trans.vorflugvolt, width=198})
		addIntbox(se.vorflugvolt, 0, 840, 410, 1, 1, function(value)
			se.vorflugvolt = value
			system.pSave("vorflugvolt", se.vorflugvolt)
		end,{label="V"})
		
		addRow(2)                                          --experten
		addLabel({label=trans.vorflugzeit, width=198})
		addIntbox(se.vorflugzeit, 0, 10, 2, 0, 1, function(value)
			se.vorflugzeit = value
			system.pSave("vorflugzeit", se.vorflugzeit)
		end)
	
  else
		
		addRow(2)
		addLabel({label=trans.bluehight, width=250})               
		addIntbox(se.bluehight, 0, 5000, 0, 0, 1, function(value)
			se.bluehight = value
			system.pSave("bluehight", se.bluehight)
		end)
	
	
		addRow(3)
		addLabel({label=trans.gearSw, width=160})
		addInputbox(sw.gearSw, true, function(value)
		 if (not isSwitch(value)) then
			value = nil
		 end
			sw.gearSw = value
		 system.pSave("gearSw", sw.gearSw)
		end)
	 addInputbox(sw.flapsSw, true, function(value)
		if (not isSwitch(value)) then
			value = nil
		end

			sw.flapsSw = value
			system.pSave("flapsSw", sw.flapsSw)
		end)
		
		
		addRow(3)
		addLabel({label=trans.clutch, width=160})
		addInputbox(sw.clutchSw, true, function(value)
		 if (not isSwitch(value)) then
			value = nil
		 end
      sw.clutchSw = value
		  system.pSave("clutchSw", sw.clutchSw)
		end)
		 addInputbox(sw.ignitioSw, true, function(value)
		if (not isSwitch(value)) then
			value = nil
		end

			sw.ignitioSw = value
			system.pSave("ignitioSw", sw.ignitioSw)
		end)
		

		addRow(2)
		addLabel({label=trans.switchTiles, width=230})
		addInputbox(sw.switchTilesSw, true, function(value)
		 if (not isSwitch(value)) then
			value = nil
		 end

		sw.switchTilesSw = value
		system.pSave("switchTilesSw", sw.switchTilesSw)
		end)
		
		addRow(2)
		addLabel({label=trans.servo, width=200})
		addSelectbox(servos, se.servo, true, function(value)
			se.servo = value
			system.pSave("servo", value)
			form.reinit(1)
		end)	



		
		addLabel({label=trans.labelAlarmp, font=FONT_BOLD})


		addRow(2)
		addLabel({label=trans.an3Sw})
		addInputbox(sw.an3Sw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.an3Sw = value
			system.pSave("an3Sw", sw.an3Sw)
		end)

		addRow(2)
		addLabel({label=trans.an4Sw})
		addInputbox(sw.an4Sw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.an4Sw = value
			system.pSave("an4Sw", sw.an4Sw)
		end)

			-------------------------
			addSpacer(318, 4)
			-------------------------

		addRow(2)
		addLabel({label=trans.assSw, font=FONT_BOLD, width=230})
		addInputbox(sw.assSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.assSw = value
			system.pSave("assSw", sw.assSw)
		end)


		
		addLabel({label=trans.varih, font=FONT_BOLD})

		addRow(2)
		addLabel({label=trans.varihoheSw, width=260})
		addInputbox(sw.varihoheSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.varihoheSw = value
			system.pSave("varihoheSw", sw.varihoheSw)
		end)

		addRow(2)
		addLabel({label=trans.mitohne, width=200})
		addSelectbox(mitohne, se.mitohne, false, function(value)
			se.mitohne = value
			system.pSave("mitohne", value)
		end)

		addRow(2)
		addLabel({label=trans.gehohe, width=250})
		addIntbox(se.gehohe, 1, 200, 50, 0, 1, function(value)
			se.gehohe   = value
			speedValues = {}
			system.pSave("gehohe", se.gehohe)
		end)

		addRow(3)
		addLabel({label=trans.riseEngine, width=160})
		addIntbox(se.risea, 1, 99, 5, 0, 1, function(value)
			se.risea = value
			system.pSave("risea", se.risea)
		end , {width=118})
			riseForm = addCheckbox(se.rise, function(value)
			se.rise = not value
			system.pSave("rise", se.rise and 1 or 0)
			form.setValue(riseForm, se.rise)
		end)
		
		
		addLabel({label=trans.minmax, font=FONT_BOLD})

		addRow(2)
		addLabel({label=trans.sensor5, width=230})
		addSelectbox(listLabels1, indexSensor5, true, function(value)
			indexSensor5 = value
			system.pSave("sensor5", indexSensor5)
		end)

		addRow(2)
		addLabel({label=trans.maxSw, width=260})
		addInputbox(sw.maxSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.maxSw = value
			system.pSave("maxSw", sw.maxSw)
		end)

		addRow(2)
		addLabel({label=trans.minSw, width=260})
		addInputbox(sw.minSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.minSw = value
			system.pSave("minSw", sw.minSw)
		end)

		addRow(2)
		addLabel({label=trans.resetmimaSw})
		addInputbox(sw.resetmimaSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.resetmimaSw = value
			system.pSave("resetmimaSw", sw.resetmimaSw)
		end)

		
		addLabel({label=trans.timer, font=FONT_BOLD})

		addRow(3)
		addLabel({label=trans.countdown, width=160})
		addIntbox(se.countdownMin, 0, 99, 10, 0, 1, function(value)
			se.countdownMin = value
			cTime        = nil
			cMin, cSec   = se.countdownMin, se.countdownSec
			system.pSave("countdownMin", se.countdownMin)
		end)
		addIntbox(se.countdownSec, 0, 59, 0, 0, 1, function(value)
			se.countdownSec = value
			cTime        = nil
			cMin, cSec   = se.countdownMin, se.countdownSec
			system.pSave("countdownSec", se.countdownSec)
		end)

		addRow(2)
		addLabel({label=trans.sou})
		addAudioFilebox(se.timerSound, function(value)
			se.timerSound = value
			system.pSave("timerSound", se.timerSound)
		end)


		addRow(2)
		addLabel({label=trans.timerSw})
		addInputbox(sw.timerSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.timerSw = value
			system.pSave("timerSw", sw.timerSw)
		end)

		addRow(2)
		addLabel({label=trans.color, width=275})
			colorForm = addCheckbox(se.color, function(value)
			se.color = not value
			system.pSave("color", se.color and 1 or 0)
			form.setValue(colorForm, se.color)
		end)
		
		addLabel({label=trans.engineSw, font=FONT_BOLD})

		addRow(2)
		addLabel({label=trans.switch})
		addInputbox(sw.engineSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.engineSw = value
			system.pSave("engineSw", sw.engineSw)
		end)

		addRow(2)
		addLabel({label=trans.sound})
		addAudioFilebox(se.monitorSound, function(value)
			se.monitorSound = value
			system.pSave("monitorSound", se.monitorSound)
		end)

		addRow(2)
		addLabel({label=trans.vibrate, width=275})
		vibrateForm = addCheckbox(se.vibrate, function(value)
			se.vibrate = not value
			system.pSave("vibrate", se.vibrate and 1 or 0)
			form.setValue(vibrateForm, se.vibrate)
		end)

		addRow(2)
		addLabel({label=trans.vibrates, width=275})
		vibratesForm = addCheckbox(se.vibrates, function(value)
			se.vibrates = not value
			system.pSave("vibrates", se.vibrates and 1 or 0)
			form.setValue(vibratesForm, se.vibrates)
		end)

		                                                   
		addLabel({label=trans.flightSw, font=FONT_BOLD})

		addRow(2)
		addLabel({label=trans.prop})
		addInputbox(sw.flightSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.flightSw = value
			system.pSave("flightSw", sw.flightSw)
		end)

		addRow(2)
		addLabel({label=trans.timeTh, width=230})
		addIntbox(se.timeTh, -100, 100, -90, 0, 1, function(value)
			se.timeTh = value
			system.pSave("timeTh", se.timeTh)
		end)

		addRow(2)
		addLabel({label=trans.statsTimeSw})
		addInputbox(sw.statsTimeSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.statsTimeSw = value
			system.pSave("statsTimeSw", sw.statsTimeSw)
		end)

		addRow(2)
		addLabel({label=trans.flightsSw})
		addInputbox(sw.flightsSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.flightsSw = value
			system.pSave("flightsSw", sw.flightsSw)
		end)

		addRow(2)
		addLabel({label=trans.short, width=275})
		shortForm = addCheckbox(se.short, function(value)
			se.short = not value
			system.pSave("short", se.short and 1 or 0)
			form.setValue(shortForm, se.short)

			if (not se.short) then
				system.pSave("eTime", nil)
				system.pSave("fTime", nil)
				system.pSave("cTime", nil)
			end
		end)

		
		addLabel({label=trans.reset, font=FONT_BOLD})
		
		addRow(2)
		addLabel({label=trans.resetTimeSw})
		addInputbox(sw.resetTimeSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.resetTimeSw = value
			system.pSave("resetTimeSw", sw.resetTimeSw)
		end)

		addRow(2)
		addLabel({label=trans.resetRxSw})
		addInputbox(sw.resetRxSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.resetRxSw = value
			system.pSave("resetRxSw", sw.resetRxSw)
		end)

		addRow(2)
		addLabel({label=trans.resetTeleSw})
		addInputbox(sw.resetTeleSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.resetTeleSw = value
			system.pSave("resetTeleSw", sw.resetTeleSw)
		end)

		
		addLabel({label=trans.flights, font=FONT_BOLD})


		addRow(3)
		addLabel({label=trans.resetStatsSw, width=160})
		addIntbox(se.flightsReset, 0, 999999, 0, 0, 1, function(value)
			se.flightsReset = value
			system.pSave("flightsReset", se.flightsReset)
		end)
		addInputbox(sw.resetStatsSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.resetStatsSw = value
			system.pSave("resetStatsSw", sw.resetStatsSw)
		end)

		addRow(3)
		addLabel({label=trans.statsFlightSw, width=160})
		addIntbox(se.TimeDelay, 0, 110, 0, 0, 1, function(value)
			se.TimeDelay = value
			system.pSave("TimeDelay", se.TimeDelay)
		end)
		addInputbox(sw.statsFlightSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.statsFlightSw = value
			system.pSave("statsFlightSw", sw.statsFlightSw)
		end)

		addRow(2)
		addLabel({label=trans.speedTrigger, font=FONT_BOLD})
		addInputbox(sw.speedSw, true, function(value)
			if (not isSwitch(value)) then
				value = nil
			end

			sw.speedSw = value
			system.pSave("speedSw", sw.speedSw)
		end)

		addRow(2)
		addLabel({label=trans.speedTime})
		addIntbox(se.speedTime, 1, 60, 3, 0, 1, function(value)
			se.speedTime = value
			speedValues  = {}
			system.pSave("speedTime", se.speedTime)
		end)

		addRow(2)
		addLabel({label=trans.speedSensor})
		addSelectbox(sensors, se.speedSensor, true, function(value)
			se.speedSensor = value
			speedValues    = {}
			system.pSave("speedSensor", se.speedSensor)
		end)

		-------------------------
		addSpacer(318, 4)
		-------------------------

		addRow(2)
		addLabel({label=trans.image})
		addSelectbox(filesImage, indexImage, true, function(value)
			fileImage = value > 1 and filesImage[value] or ""
			image     = nil
			system.pSave("fileImage", fileImage)
		end)

		addRow(2)
		addLabel({label=trans.logo})
		addSelectbox(filesImage, indexLogo, true, function(value)
			fileLogo = value > 1 and filesImage[value] or ""
			logo     = nil
			system.pSave("fileLogo", fileLogo)
		end)

		addRow(2)
		addLabel({label=trans.picture})
		addSelectbox(filesImage, indexBattery, true, function(value)
			fileBattery = value > 1 and filesImage[value] or ""
			battery     = nil
			system.pSave("fileBattery", fileBattery)
		end)

		
		addLabel({label=trans.saveLoad, font=FONT_BOLD})

		addRow(2)
		addLabel({label=trans.save, width=200})
		addTextbox(fileSave, 63, function(value)
			fileSave = value
			form.setButton(4, "S", fileSave:len() > 0 and ENABLED or DISABLED)
		end)


		addRow(2)
		addLabel({label=trans.load, width=200})
		addSelectbox(filesLoad, indexLoad, true, function(value)
			fileLoad = value > 1 and filesLoad[value] or ""
			form.setButton(5, "L", fileLoad:len() > 0 and ENABLED or DISABLED)
		end)


		addRow(2)
		addLabel({label=trans.nickname, width=275})
			nicknameForm = addCheckbox(se.nickname, function(value)
			se.nickname = not value
			system.pSave("nickname", se.nickname and 1 or 0)
			form.setValue(nicknameForm, se.nickname)
		end)

		addRow(2)
		addLabel({label=trans.alphabet, width=275})
			alphabetForm = addCheckbox(se.alphabet, function(value)
			se.alphabet = not value
			system.pSave("alphabet", se.alphabet and 1 or 0)
			form.setValue(alphabetForm, se.alphabet)
			sorted = nil
		end)

		addRow(1)
		addLabel({label="Thorn Jeti Forum", font=FONT_MINI, alignRight=true})

		collectgarbage()
  end
end
--------------------------------------------------------------------------------
local function initForm2()
	if (not sorted) then
		sorted = true

		tiles   = {trans.empty, trans.percentB, trans.percentL, trans.battery, trans.level, trans.currents, trans.akkus, trans.images, trans.receivers1, trans.recminis1, trans.heights, trans.tempas, trans.vario, trans.rpms, trans.watts, trans.etimes, trans.akkuvtgs, trans.mulis, trans.gpss, trans.tempas2, trans.fuels, trans.pumps, trans.ecus, trans.gs, trans.engine, trans.vibess, trans.ftimes, trans.thros, trans.model, trans.akkuvtg1s, trans.akkuvtg2s, trans.akku1s, trans.akku2s, trans.current1s, trans.current2s, trans.kordinatena, trans.on, trans.streckes, trans.rpms2, trans.countdownTile, trans.logo, trans.muliss, trans.speedtriggernn, trans.stats, trans.Abss, trans.assSw, trans.percents, trans.levelprecents, trans.akkus2, trans.fuelbig, trans.mtag, trans.receivers2, trans.recminis2, trans.receivers3, trans.recminis3, trans.cRate, trans.name, trans.Kw, trans.lei, trans.gear1, trans.flaps1, trans.assa, trans.Temp2, trans.Temp3, trans.tempas3, trans.tempas4, trans.turbine, trans.drawBatter, trans.flaps2, trans.Assist1, trans.Assist2, trans.CRate, trans.cb, trans.cbo, trans.tempas5, trans.Temp, trans.Temps, trans.Ent, trans.hightbig, trans.kapabig, trans.cba, trans.cbaa, trans.MBAR, trans.vspeak1, trans.vspeak2, trans.akkud, trans.speed3, trans.akku2b, trans.gear2, trans.towingClutch, trans.ignitio, trans.servo, trans.heights2, trans.currenlage, trans.voltagelage, trans.temp6i, trans.temp7i, trans.temp8i, trans.temp9i, trans.temp10i, trans.current3A, trans.current3V, trans.gear3, trans.smoke, trans.impeller}
		indices = {}

		for i=1, methodsMax do
			indices[i] = i
		
			if (i > 1) then
				tiles[i] = tiles[i].." ("..heights[i]..")"
			end
		end
		
		if (se.alphabet) then
			quicksort(indices, tiles, 2, methodsMax)
		end

		for i=1, methodsMax do
			indices[-indices[i]] = i
		end
	end

	local setTitle, addSpacer, addRow       = form.setTitle, form.addSpacer, form.addRow
	local addLabel, addSelectbox, addIntbox = form.addLabel, form.addSelectbox, form.addIntbox
	local space, one, two, three = " ("," 1)", " 2)", " 3)"
	local labels = {
		trans.left..space..trans.tele..one  , trans.right..space..trans.tele..one  , trans.middle..space..trans.tele..one  ,
		trans.left..space..trans.tele..two  , trans.right..space..trans.tele..two  , trans.middle..space..trans.tele..two  ,
		trans.left..space..trans.tele..three, trans.right..space..trans.tele..three, trans.middle..space..trans.tele..three
	}

	setTitle(trans.title2)

	for i=1, positionsMax do
		local position = positions[i]
		local height   = 158 - spacers[-i]
		local used, space

		for j=1, positionMax do
			if (position[j] > 1) then
				height = height - heights[position[j]]
				
				if (heights[position[j]] > 0) then
					height = height - spacers[i]
					used   = true
				end
			end
		end
		
		if (used) then
			height = height + spacers[i]
		end

		addRow(3)
		addLabel({label=labels[i].."        "..height, width=200, font=FONT_BOLD})
		addIntbox(spacers[-i], 0, 160, 3, 0, 1, function(value)
			spacers[-i] = value
			system.pSave("spacers."..-i, value ~= 3 and value or nil)
			form.reinit(formID)
		end, {width=60})
		addIntbox(spacers[i], 0, 160, 1, 0, 1, function(value)
			spacers[i] = value
			system.pSave("spacers."..i, value ~= 1 and value or nil)
			form.reinit(formID)
		end, {width=60})

		for j=1, positionMax do		
			addRow(2)
			addLabel({label=trans.pos.." "..(j > positionMax and j - positionMax or j), width=160})
			addSelectbox(tiles, indices[-position[j]], true, function(value)
				local previous   = position[j]
				value            = indices[value]
				counts[previous] = counts[previous] - 1
				counts[value]    = counts[value]    + 1
				position[j]      = value
				system.pSave("positions."..i.."."..j, value ~= 1 and value or nil)
				form.reinit(formID)
			end)
		end
	end

	collectgarbage()
end
--------------------------------------------------------------------------------
local function initForm3(index)
	local setTitle, addSpacer, addRow, addLabel, addIntbox = form.setTitle, form.addSpacer, form.addRow, form.addLabel, form.addIntbox
	local param = params[index]
	
	if (rx.values[7] > 1 or rx.values[8] > 1 or rx.values[9] > 1) then
		system.messageBox(trans.message2, 5)
		system.playBeep(4, 3000, 400)

		if (se.vibrate) then
			system.vibration(false, 4)
			system.vibration(true,  4)
		end
		
		return
	end

	setTitle(index == 6 and trans.title9 or index == 5 and trans.title8 or index == 4 and trans.title7 or index == 3 and trans.title6 or index == 2 and trans.title4 or trans.title3)


	addLabel({label=trans.sensorInfo, font=FONT_MINI})

	for i=2, sensorsMax do
		addRow(2)
		addLabel({label=sensors[i], width=170})
		addIntbox(param[i], 0, 50, 0, 0, 1, function(value)
			param[i] = value
			system.pSave("params."..index.."."..i, value ~= 0 and value or nil)
		end)
	end

	collectgarbage()
end
--------------------------------------------------------------------------------
local function initForm5()
	local setTitle, addSpacer, addRow     = form.setTitle, form.addSpacer, form.addRow
	local addLabel, addTextbox, addIntbox = form.addLabel, form.addTextbox, form.addIntbox

	setTitle(trans.title5)

	for i=1, se.batteries  do
		if (i > 1) then
			addSpacer(318, 7)
		end

		addRow(2)
		addLabel({label=string.format("%s %d %s", trans.battery, i, trans.batName), width=152})
		addTextbox(names[i], 63, function(value)
			names[i] = value
			system.pSave("names."..i, value)
		end)

		addRow(2)
		addLabel({label=string.format("%s %d %s", trans.battery, i, trans.batId)})
		addIntbox(ids[i], 0, 999, 0, 0, 1, function(value)
			ids[i] = value
			system.pSave("ids."..i, value)
		end)
	end

	collectgarbage()
end
--------------------------------------------------------------------------------
local function initForm(id)
	formID = id

	if (formID == 1) then
		initForm1()
	elseif (formID == 2) then
		initForm2()
	elseif (formID == 3) then
		initForm3(1)
	elseif (formID == 4) then
		initForm3(2)
	elseif (formID == 5) then
		initForm5()
	elseif (formID == 6) then
		initForm3(3)
	elseif (formID == 7) then
		initForm3(4)
	elseif (formID == 8) then
		initForm3(5)
	elseif (formID == 9) then
		initForm3(6)
	end

	if (formID == 4) then
	  form.setButton(1, "4/1", formID == 1 and HIGHLIGHTED or ENABLED)
		form.setButton(2, "4/2", formID == 2 and HIGHLIGHTED or ENABLED)
		form.setButton(3, "4/3", formID == 3 and HIGHLIGHTED or ENABLED)
		form.setButton(4, "4",   formID == 4 and HIGHLIGHTED or ENABLED)
		form.setButton(5, "4/5", formID == 5 and HIGHLIGHTED or ENABLED)
	else
		form.setButton(1, "1", formID == 1 and HIGHLIGHTED or ENABLED)
		form.setButton(2, "2", formID == 2 and HIGHLIGHTED or ENABLED)
		form.setButton(3, "3", formID == 3 and HIGHLIGHTED or ENABLED)

		if (formID == 1) then
			form.setButton(4, "S", timeB4 and HIGHLIGHTED or fileSave:len() > 0 and ENABLED or DISABLED)
			form.setButton(5, "L", timeB5 and HIGHLIGHTED or fileLoad:len() > 0 and ENABLED or DISABLED)
		else
			form.setButton(4, "4", formID == 4 and HIGHLIGHTED or ENABLED)
			form.setButton(5, "5", formID == 5 and HIGHLIGHTED or ENABLED)
		end
	end
end

---------------------------------------------------------------------------------
local function saveConfig()
	if (fileSave:len() > 0) then
		local file = io.open(folder..fileSave..extensionFile, "w+")

		if (file) then
			local space = " "
			local line  = "\n"
			
			if (version == nil) then
			    version = appversion 
			end
			
			local text  = "["..version.."]"
			
			io.write(file, text..line)

			for i=1, positionsMax do
				text = ""

				for j=1, positionMax do
					if (j > 1) then
						text = text..space
					end

					text = text..positions[i][j]
				end

				io.write(file, text..line)
			end

			for i=1, paramsMax do
				text = ""

				for j=2, sensorsMax do
					if (j > 2) then
						text = text..space
					end

					text = text..params[i][j]
				end

				io.write(file, text..line)
			end

			text = ""

			for i=1, positionsMax do
				if (i > 1) then
					text = text..space
				end

				text = text..spacers[-i]..space..spacers[i]
			end

			io.write(file, text..line)
      io.close(file)

			timeB4 = system.getTimeCounter()
		end
	end
end
--------------------------------------------------------------
local function loadConfig()
	if (fileLoad:len() > 0) then
		local file = io.open(folder..fileLoad..extensionFile, "r")

		if (file) then
			local line, index, value
			
			line    = io.readline(file, true)
			version = line:match("%[([%w%.]+)%]")
			
			if (not version) then
				io.seek(file, "set")
			end

			for i=1, positionsMax do
				if (not version and i > 6) then
					line = "1 1 1 1 1 1"
				else			
				  line = io.readline(file, true)
				end
				
				index = 0

				if (line) then
					for value in line:gmatch("%d+") do
						index = index + 1
						value = tonumber(value)
						positions[i][index] = value
						system.pSave("positions."..i.."."..index, value ~= 1 and value or nil)
					end
				end

				for j=index+1, positionMax do
					positions[i][j] = 1
					system.pSave("positions."..i.."."..j, nil)
				end
			end

-- Read params
      for i=1, paramsMax do
        line = io.readline(file, true)
				index = 1
					 
				if (line) then
					for value in line:gmatch("%d+") do
						index = index + 1
						value = tonumber(value)
						params[i][index] = value
						system.pSave("params."..i.."."..index, value ~= 0 and value or nil)
					end
				end
		
				for j=index+1, sensorsMax do
					params[i][j] = 0
					system.pSave("params."..i.."."..j, nil)
				end
			end

--Read spacers???
			line = io.readline(file, true)
			index = 0
			
			if (line) then
				for value in line:gmatch("%d+") do
					index = -index

					if (index <= 0) then
						index = index - 1
					end

					value = tonumber(value)
					spacers[index] = value
					
					if (index <= 0) then
						system.pSave("spacers."..index, value ~= 3 and value or nil)
					else
						system.pSave("spacers."..index, value ~= 1 and value or nil)
					end
				end
			end

			for i=1, positionsMax do
				if (not spacers[-i]) then
					spacers[-i] = 3
					system.pSave("spacers."..-i, nil)
				end
				if (not spacers[i]) then
					spacers[i] = 1
					system.pSave("spacers.".. i, nil)
				end
			end
					
			io.close(file)

			timeB5 = system.getTimeCounter()
		end
	end
end
---------------------------------------------------------------------------------
local function keyForm(key)
	if (key == KEY_1) then
		if(formID == 4) then
			form.reinit(9)
		elseif (formID ~= 1) then
			form.reinit(1)
		end
	elseif (key == KEY_2) then
		if (formID == 4) then
			form.reinit(6)
		elseif (formID ~= 2) then
			form.reinit(2)
		end
	elseif (key == KEY_3) then
		if (formID == 4) then
			form.reinit(7)
		elseif (formID ~= 3) then
			form.reinit(3)
		end
	elseif (key == KEY_4) then
		if (formID == 1) then
			saveConfig()
			form.reinit(1)
		elseif (formID ~= 4) then
			form.reinit(4)
		end
	elseif (key == KEY_5) then
		form.preventDefault()

		if (formID == 1) then
			loadConfig()
			form.reinit(1)
		elseif (formID == 4) then
			form.reinit(8)
		elseif (formID ~= 5) then
			form.reinit(5)
		end
	end
end

--------------------------------------------------------------------------------
local function setButtons()
	if (timeB4 or timeB5) then
		local time  = system.getTimeCounter()
		local limit = 1000

		if (timeB4 and time - timeB4 > limit) then
			timeB4 = nil
			if (formID == 1) then
				form.setButton(4, "S", fileSave:len() > 0 and ENABLED or DISABLED)
			end
		end

		if (timeB5 and time - timeB5 > limit) then
			timeB5 = nil
			if (formID == 1) then
				form.setButton(5, "L", fileLoad:len() > 0 and ENABLED or DISABLED)
			end
		end
	end
end

--------------------------------------------------------------------------------
local function setTimers()
	engine              = system.getInputsVal(sw.engineSw)
	local flightVal     = system.getInputsVal(sw.flightSw)
	local flightsVal    = system.getInputsVal(sw.flightsSw)
	local timerVal      = system.getInputsVal(sw.timerSw)
	local statsTimeVal  = system.getInputsVal(sw.statsTimeSw)
	local resetTimeVal  = system.getInputsVal(sw.resetTimeSw)
	local an3Val        = system.getInputsVal(sw.an3Sw)
	local an4Val        = system.getInputsVal(sw.an4Sw)
	local timeMil       = system.getTimeCounter()


	---------------------------------------------------------------------------------
	-- engine time
	if (counts[tileEngine] == 0 or resetTimeVal == 1 and (not flightVal or flightVal * 100 <= se.timeTh)) then
		if (eTime) then
			eTime      = nil
			eMin, eSec = 0, 0

			if (se.short) then
				system.pSave("eTime", eTime)
			end
		end
	elseif ((not statsTimeVal or statsTimeVal > 0) and flightVal and flightVal * 100 > se.timeTh) then

		if (not eTime) then
			eLastTime = timeMil
			eTime     = 0

			if (se.short) then
				system.pSave("eTime", eTime)
			end
		end

		local time = timeMil - eLastTime
		if (time >= 1000) then 
			eLastTime = timeMil
			eTime     = eTime + time/1000
			eMin      = math.floor(eTime/60)
			eSec      = eTime - eMin*60

			if (se.short) then
				system.pSave("eTime", eTime * 1000)
			end
		end
	else
		eLastTime = timeMil
	end

	---------------------------------------------------------------------------------
	-- flight time
	if (counts[tileFlight] == 0 or resetTimeVal == 1 and (not flightVal or flightVal * 100 <= se.timeTh)) then
		if (fTime) then
			fTime      = nil
			fHrs, fMin, fSec = 0, 0, 0

			if (se.short) then
				system.pSave("fTime", fTime)
			end
		end

	elseif ((flightVal or not flightVal and statsTimeVal) and flightsVal ~= 1) then
		if (not fTime and (flightVal and flightVal * 100 > se.timeTh or not flightVal and statsTimeVal and statsTimeVal > 0)) then
			fLastTime = timeMil
			fTime     = 0

			if (se.short) then
				system.pSave("fTime", fTime)
			end
		end

		if (fTime) then
			local time = timeMil - fLastTime
			if (time >= 1000) then
				fLastTime = timeMil
				fTime     = fTime + time/1000
				fHrs      = math.floor(fTime/3600)
				fMin      = math.floor(fTime/60) % 60
				fSec      = fTime % 60

				if (se.short) then
					system.pSave("fTime", fTime * 1000)
				end
			end

			if (an4Val == 1 and lastAn4 < timeMil) then
				lastAn4    = timeMil + timeAlert
				local ceil = math.ceil(fTime)

				if (math.abs(ceil) < 60) then
					system.playNumber(ceil < 0 and -fSec or fSec, 0, "s")
				elseif (math.abs(ceil) < 3600) then
					system.playNumber(ceil < 0 and -fMin or fMin, 0, "min")
					system.playNumber(fSec, 0, "s")
				else
					system.playNumber(ceil < 0 and -fHrs or fHrs, 0, "h")
					system.playNumber(fMin, 0, "min")
					system.playNumber(fSec, 0, "s")
				end
			end
		end
	else
		fLastTime = timeMil
	end

	---------------------------------------------------------------------------------
	-- timer time

	if (counts[tileCounter] == 0 or resetTimeVal == 1 and (not flightVal or flightVal * 100 <= se.timeTh)) then
		if (cTime) then
			cTime      = nil
			cMin, cSec = se.countdownMin, se.countdownSec

			system.pSave("cTime", cTime)
		end
	else
		if ((not statsTimeVal or statsTimeVal > 0) and (timerVal == 1 or not timerVal and flightVal and flightVal * 100 > se.timeTh)) then
			if (not cTime) then
				cLastTime = timeMil
				cTime     = 60*se.countdownMin + se.countdownSec

				system.pSave("cTime", cTime)
				system.playFile("Timer Start.wav")
				lastAn3 = timeMil + timeAlert
			
			end

			local time = timeMil - cLastTime
			if (time >= 1000) then
				cLastTime   = timeMil
				cTime       = cTime - time/1000

				local ceil  = math.ceil(cTime)
				local abs   = math.abs(ceil)
				cMin        = math.floor(abs/60)
				cSec        = abs - cMin*60

				system.pSave("cTime", cTime * 1000)


				if (lastAn3 < timeMil) then
					if (ceil == 60) then
						system.playNumber(1, 0, "min")
						lastAn3 = timeMil + timeAlert
					
					elseif (ceil == 30 or ceil == 20 or ceil == 10) then
					 	system.playNumber(ceil, 0, "s")
				    lastAn3 = timeMil + timeAlert
					
				  end

					if (ceil == 0) then
						if (se.timerSound == "") then
							system.playNumber(ceil, 0, "s")
						else
							system.playFile(se.timerSound, AUDIO_IMMEDIATE)
						end

						lastAn3 = timeMil + timeAlert

						if (se.vibrates) then
							system.vibration(false, 4)
							system.vibration(true,  4)
							
						end
					end
				end
			end
		else
			cLastTime = timeMil
		end

		if (cTime and an3Val == 1 and lastAn3 < timeMil) then
			lastAn3    = timeMil + timeAlert
			local ceil = math.ceil(cTime)

			if (math.abs(ceil) < 60) then
				system.playNumber(ceil < 0 and -cSec or cSec, 0, "s")
			else
				system.playNumber(ceil < 0 and -cMin or cMin, 0, "min")
				system.playNumber(cSec, 0, "s")
			end
		end
	end

	---------------------------------------------------------------------------------
	-- engine monitor
	if (engine and engine <= 0 and flightVal and flightVal * 100 > se.timeTh) then
		alert = true

		if (lastAlert < timeMil) then
			lastAlert = timeMil + timeAlert

			if (se.vibrate) then
				system.vibration(false, 4)
				system.vibration(true,  4)
			end

			if (se.monitorSound ~= "") then
				system.playFile(se.monitorSound, AUDIO_IMMEDIATE)
			end
		end
	else
		alert     = nil
		lastAlert = 0
	end
end
---------------------------------------------------------------------------------
local function loop()

  val                  = system.getInputs ("O"..se.servo) 
  ass                  = system.getInputsVal(sw.assSw)
	gear                 = system.getInputsVal(sw.gearSw)
  flaps                = system.getInputsVal(sw.flapsSw)
	clutch               = system.getInputsVal(sw.clutchSw)
	ignitio              = system.getInputsVal(sw.ignitioSw)
	switchTiles          = system.getInputsVal(sw.switchTilesSw)
	local capaVal        = system.getInputsVal(sw.capaSw)
	local resetTeleVal   = system.getInputsVal(sw.resetTeleSw)
	local resetStatsVal  = system.getInputsVal(sw.resetStatsSw)
	local varihoheVal    = system.getInputsVal(sw.varihoheSw)
	local timeMil        = system.getTimeCounter()
	local array1         = spirit and listIds1 or listIds2
	local array2         = listIds2
	local id1            = array1[indexSensor1]
	local id2            = array2[indexSensor2]
	local id3            = array2[indexSensor3]
	local id4            = array2[indexSensor4]
	local id6            = array2[indexSensor6]
	local id7            = array2[indexSensor7]
  local id8            = array2[indexSensor8]
	local id5            = listIds1[indexSensor5]
	local param5         = listParams1[indexSensor5]

	setButtons()
	setTimers()

	if (resetTeleVal == 1) then
		setLimits(true)
		
		minval = 100
		maxval = 0
	end

	if (val) then
		if (val < minval) then
				minval = val 
		end

		if (val > maxval) then
				maxval = val 
		end
	end

	if (resetStatsVal == 1) then
		flightsTotal = se.flightsReset
		flightsToday = 0
		system.pSave("flightsTotal", flightsTotal)
		system.pSave("flightsToday", flightsToday)
	end

	-- Read Sensor ID 4 Empf�nger00
	local txTel = system.getTxTelemetry()
	if (txTel) then
		local resetRxVal     = system.getInputsVal(sw.resetRxSw)
		local statsFlightVal = system.getInputsVal(sw.statsFlightSw)

		if (resetRxVal == 1) then
				setLimits(false)
		end

		rx.values[ 7] = txTel.rx1Percent or 0
		rx.values[ 8] = txTel.rx2Percent or 0
		rx.values[ 9] = txTel.rxBPercent or 0
		rx.values[10] = txTel.rx1Voltage or 0
		rx.values[11] = txTel.rx2Voltage or 0
		rx.values[12] = txTel.rxBVoltage or 0

		for i=1, rx.count do
			if (i <= 6) then
				rx.values[i] = txTel.RSSI[i] or 0

				if (rx.values[i] > 6) then
					rx.limits[-i] = true
				end
			elseif (i <= 9) then
				if (rx.values[i] > 90) then
					rx.limits[-i] = true
				end
			end

			if (rx.limits[-i] and rx.limits[i] > rx.values[i]) then
				rx.limits[i] = rx.values[i]
			end
		end

		if (rx.values[7] > 1 or rx.values[8] > 1 or rx.values[9] > 1) then
			if (flightTime) then
				if (not statsFlightVal or statsFlightVal > 0) then
					if (not flightDone and timeMil - flightTime >= 120000) then
						setFlights()

						flightDone   = true
						flightsTotal = flightsTotal + 1
						flightsToday = flightsToday + 1

						system.pSave("flightsTotal", flightsTotal)
						system.pSave("flightsToday", flightsToday)
					end
				else
					if (not flightDone) then
						flightTime = nil
						flightLast = nil
					end
				end
			else
				if (not statsFlightVal or statsFlightVal > 0) then
					flightTime = timeMil
					flightDone = nil
					flightLast = nil
				end
			end
		else
			if (flightTime) then
				if (flightLast) then
					if (timeMil - flightLast > se.TimeDelay * 1000) then
						flightTime = nil
						flightDone = nil
						flightLast = nil
					end
				else
					if (flightDone) then
						flightTime = nil
						flightDone = nil
						flightLast = nil
					else
						flightLast = timeMil
					end
				end
			end
		end
	end

	if (id3 ~= 0) then
		for i=1, mtagMax do
			local sensor = system.getSensorValueByID(id3, i)

			if (sensor and sensor.valid) then
				if (i == 1 and mtag[i] ~= sensor.value) then
					name = nil

					for j=1, battMax do
						if (ids[j] == sensor.value) then
							name = names[j]
							break
						end
					end

					if (not name) then
						system.messageBox(trans.message, 5)
						system.playBeep(4, 3000, 400)

						if (se.vibrate) then
							system.vibration(false, 4)
							system.vibration(true,  4)
						end
					end
				end

				mtag[i] = sensor.value
			else
				mtag[i] = 0
			end
		end
	end

	-- Kapazit�t
	if (mtag[2] > 0) then
		capa1 = mtag[2]

		if (not mtag[0]) then
			mtag[0] = true
		end
	elseif (mtag[0]) then
		-- keep the previous value
	elseif (capa13 == 0) then
		if (capaVal == 1) then
			capa1 = capa12
		else
			capa1 = capa11
		end
	else
		if (capaVal == 1) then
			capa1 = capa13
		elseif (capaVal == 0) then
			capa1 = capa12
		else
			capa1 = capa11
		end
	end

	if (id1 ~= 0 or id2 ~= 0 or id4 ~= 0 or id6 ~= 0 or id7 ~= 0 or id8 ~= 0) then
		for i=2, sensorsMax do
			local sensor

			if (id1 ~= 0 and params[1][i] ~= 0) then
				sensor = system.getSensorByID(id1, params[1][i])
			elseif (id2 ~= 0 and params[2][i] ~= 0) then
				sensor = system.getSensorByID(id2, params[2][i])
			elseif (id4 ~= 0 and params[3][i] ~= 0) then
				sensor = system.getSensorByID(id4, params[3][i])
			elseif (id6 ~= 0 and params[4][i] ~= 0) then
				sensor = system.getSensorByID(id6, params[4][i])
			elseif (id7 ~= 0 and params[5][i] ~= 0) then
				sensor = system.getSensorByID(id7, params[5][i])
      elseif (id8 ~= 0 and params[6][i] ~= 0) then
				sensor = system.getSensorByID(id8, params[6][i])
			end

			if (sensor and sensor.valid) then
				values[i] = sensor.value

				if (i == 3) then
			    if (capa1 > 0) then
						arate  = math.max(arate,  1000 * sensor.value / capa1)
						arates = math.max(arates, 1000 * sensor.value / capa1)

						if (mtag[5] > 0) then
							prate = 100 * arate / mtag[5]
						end

						if (se.crate > 0) then
							prates = 100 * arates / se.crate
						end
			    end

					kw.value = values[2] * values[3] / 1000
					if (kw.limit < kw.value) then
						kw.limit = kw.value
					end
				elseif (i == 4) then					
					if (sensor.unit == unitCurrent) then
						values[i] = values[i] * 1000
					end
					
					capaSum = values[i]

					if (capa1 > 0) then
						if (akkudAnswer) then
							capaSum = capaSum + capaOld
							system.pSave("capaOld", capaSum)
						elseif (se.akkud) then
							system.pSave("capaOld", capaSum)
						else
							system.pSave("capaOld", 0)
						end
 
						remaining1 = 100 * math.max(0, (capa1 - capaSum) / capa1)
						remaining1 = math.floor(remaining1 + 0.5)
						
						if (remaining1 <= se.alarmValue1) then
							system.pSave("capaOld", 0)
						
							if (not pd.playDone1) then
								pd.playDone1 = true

								for i=1, se.again and 3 or 1 do
									if (se.alarmVoice1 ~= "") then
										system.playFile(se.alarmVoice1, AUDIO_QUEUE)
									end

									system.playNumber(se.alarmValue1, 0, "%")
								end

								if (se.vibrates) then
									system.vibration(false, 4)
									system.vibration(true,  4)
									
								end
							end
						else
							pd.playDone1 = false
						end

						if (remaining1 <= se.alarmValue11) then
							if (not pd.playDone5) then
								pd.playDone5 = true

								system.playNumber(se.alarmValue11, 0, "%")
								
								if (se.vibrates) then
									system.vibration(false, 4)
									system.vibration(true,  4)
									
								end
							end
						else
							pd.playDone5 = false
						end
					else
						remaining1 = 0
					end

					local an1Val = system.getInputsVal(sw.an1Sw)

					if (an1Val == 1 and lastAn1 < timeMil) then
						system.playNumber(remaining1, 0, "%", "Capacity")
						lastAn1 = timeMil + timeAlert
					end
				elseif (i == 5) then					
					unitDistance = sensor.unit
					
					if (unitDistance == unitDistance2) then
						values[i] = values[i] / 1000
					end
				elseif (i == 18) then
					unitSpeed = sensor.unit
					
					if (unitSpeed == unitSpeed2) then						
						values[i] = values[i] * 3.6
					end
				elseif (i == 21) then
					unitFuel = sensor.unit

					if (capa2 > 0) then
						if (se.fuel) then
							remaining2 = 100 * math.max(0, (capa2 - sensor.value) / capa2)
						else
							remaining2 = 100 * math.min(1, sensor.value / capa2)
						end
						
						remaining2 = math.floor(remaining2 + 0.5)
						
						if (remaining2 <= se.alarmValue2) then
							if (not pd.playDone2) then
								pd.playDone2 = true

								for i=1, se.again and 3 or 1 do
									if (se.alarmVoice2 ~= "") then
										system.playFile(se.alarmVoice2, AUDIO_QUEUE)
									end

									system.playNumber(se.alarmValue2, 0, "%")
								end

								if (se.vibrates) then
									system.vibration(false, 4)
									system.vibration(true,  4)								
								end
							end
						else
							pd.playDone2 = false
						end

						if (remaining2 <= se.alarmValue22) then
							if (not pd.playDone6) then
								pd.playDone6 = true

								system.playNumber(se.alarmValue22, 0, "%")
							
								if (se.vibrates) then
									system.vibration(false, 4)
									system.vibration(true,  4)
									
								end
							end
						else
							pd.playDone6 = false
						end
					else
						remaining2 = 0
					end
					local an2Val = system.getInputsVal(sw.an2Sw)

					if (an2Val == 1 and lastAn2 < timeMil) then
						system.playNumber(remaining2, 0, "%", "Capacity")
						lastAn2 = timeMil + timeAlert
					end
				elseif (i == 29) then

					if (capa3 > 0) then
						remaining3 = 100 * math.max(0, (capa3 - sensor.value) / capa3)
						remaining3 = math.floor(remaining3 + 0.5)

						if (remaining3 <= se.alarmValue3) then
							if (not pd.playDone3) then
								pd.playDone3 = true

								for i=1, se.again and 3 or 1 do
									if (se.alarmVoice3 ~= "") then
										system.playFile(se.alarmVoice3, AUDIO_QUEUE)
									end

									system.playNumber(remaining3, 0, "%")
									
								end

								if (se.vibrates) then
									system.vibration(false, 4)
									system.vibration(true,  4)
								
								end
							end
						else
							pd.playDone3 = false
						end
					else
						remaining3 = 0
					end
				elseif (i == 30) then

					if (capa4 > 0) then
						remaining4 = 100 * math.max(0, (capa4 - sensor.value) / capa4)
						remaining4 = math.floor(remaining4 + 0.5)
						
						if (remaining4 <= se.alarmValue3) then
							if (not pd.playDone4) then
								pd.playDone4 = true

								for i=1, se.again and 3 or 1 do
									if (se.alarmVoice3 ~= "") then
										system.playFile(se.alarmVoice3, AUDIO_QUEUE)
									end

									system.playNumber(remaining4, 0, "%")
								end

								if (se.vibrates) then
									system.vibration(false, 4)
									system.vibration(true,  4)
								
								end
							end
						else
							pd.playDone4 = false
						end
					else
						remaining4 = 0
					end
				elseif (i == 39)  then
				  unitent =  sensor.unit
				elseif (i == 40)  then
				  unitmbar = sensor.unit
				elseif (i == 41) then
					if (sensor.unit == unitSpeed2) then
						values[i] = values[i] * 3.6
					end
				elseif (i == 43) then
					se.gpsLatVal = sensor.valGPS
					se.gpsLatDec = sensor.decimals
				elseif (i == 44) then
					se.gpsLonVal = sensor.valGPS
					se.gpsLonDec = sensor.decimals
				end
				
				if (values[i] and values[i] > 0) then
					if (limits[-i] > values[i]) then
						limits[-i] = values[i]
					end

					if (limits[i] < values[i]) then
						limits[i] = values[i]
					end
				end
			else
				values[i] = 0
			end
		end
	end
	

		if (Calca_dispFuel ~= nil and Calca_dispFuel <= se.alarmValue1) then		
			if (not pd.playDone7) then
				pd.playDone7 = true

				for i=1, se.again and 3 or 1 do
					if (se.alarmVoice1 ~= "") then
						system.playFile(se.alarmVoice1, AUDIO_QUEUE)
					end

					system.playNumber(se.alarmValue1, 0, "%")
				end

				if (se.vibrates) then
					system.vibration(false, 4)
					system.vibration(true,  4)
					
				end
			end
		else
			pd.playDone7 = false
		end

		if (Calca_dispFuel ~= nil and Calca_dispFuel <= se.alarmValue11) then
			if (not pd.playDone8) then
				pd.playDone8 = true

				system.playNumber(se.alarmValue11, 0, "%")
				
				if (se.vibrates) then
					system.vibration(false, 4)
					system.vibration(true,  4)
					
				end
			end
		else
			pd.playDone8 = false
		end
	 

	--if (capa2 > 0) then
--	if (Calca_selTank > 0) then
		if (Calca_dispGas ~= nil and Calca_dispGas <= se.alarmValue2) then
			if (not pd.playDone9) then
				pd.playDone9 = true

				for i=1, se.again and 3 or 1 do
					if (se.alarmVoice2 ~= "") then
						system.playFile(se.alarmVoice2, AUDIO_QUEUE)
					end

					system.playNumber(se.alarmValue2, 0, "%")
				end

				if (se.vibrates) then
					system.vibration(false, 4)
					system.vibration(true,  4)								
				end
			end
		else
			pd.playDone9 = false
		end

		if (Calca_dispGas ~= nil and Calca_dispGas <= se.alarmValue22) then
			if (not pd.playDone10) then
				pd.playDone10 = true

				system.playNumber(se.alarmValue22, 0, "%")
			
				if (se.vibrates) then
					system.vibration(false, 4)
					system.vibration(true,  4)
					
				end
			end
		else
			pd.playDone10 = false
		end
	

	if (timeMil - se.gpsTime >= 3000) then
		se.gpsTime = timeMil
		
		system.pSave("gpsLatVal", se.gpsLatVal)
		system.pSave("gpsLatDec", se.gpsLatDec)
		system.pSave("gpsLonVal", se.gpsLonVal)
		system.pSave("gpsLonDec", se.gpsLonDec)
	end

	if (counts[tileSpeed] > 0 and se.speedSensor > 1) then
		local index    = - (math.floor(timeMil/1000) % se.speedTime + 2)
		local value    = values[se.speedSensor]
		local speedVal = system.getInputsVal(sw.speedSw)

		if (speedValues[-1] ~= index or not speedValues[index] or speedValues[index] < value) then
			speedValues[index] = value
		end

		speedValues[-1] = index

		if (speedVal == 1) then
			if (not se.speedDone) then
				se.speedDone   = true
				local limit = 0

				for i=-se.speedTime, -1 do
					value = speedValues[i]

					if (value and limit < value) then
						limit = value
					end
				end

				index              = (speedValues[0] or 0) % 10 + 1
				speedValues[index] = limit
				speedValues[0]     = index
			end
		else
			if (se.speedDone) then
				se.speedDone = nil
			end
		end
	end
	
	if (values[2] == 0) then
		if (batteryAlert) then
			batteryAlert = nil
		end
	elseif (se.vorflugvolt > 0 and values[2] * 10 >= se.vorflugvolt) then
		if (batteryAlert ~= 0) then
			batteryAlert = 0
		end
	else
		if (batteryAlert) then
			if (batteryAlert < 0) then
				if (timeMil >= -batteryAlert and se.vorflugvolt > 0 and values[2] * 10 < se.vorflugvolt) then
					batteryAlert = timeMil + 20000
					system.playBeep(4, 3000, 400)

					if (se.vibrate) then
						system.vibration(false, 4)
						system.vibration(true , 4)
					end
				end
			elseif (batteryAlert > 0) then
				if (timeMil >= batteryAlert) then
					batteryAlert = 0
				end
			end
		else
			batteryAlert = -(timeMil + se.vorflugzeit * 1000)
		end
	end

	if (varihoheVal == 1) then
		local current = values[3]
		local height  = values[6]

		if (se.lastHeight) then
			local mode = se.mitohne
			local step = se.gehohe
			local rise = se.rise
			local diff = height - se.lastHeight
			local amp  = se.risea

			if (math.abs(diff) > step) then
				se.lastHeight = height

				if (not rise or current <= amp) then
					if (diff > 0 and mode ~= 2 or diff < 0 and mode ~= 1) then
						system.playNumber(height, 0, "m")
					end
				end
			end
		else
			se.lastHeight = height
		end
	end

	if (id5 ~= 0) then

		local sensor_I     = system.getSensorByID(id5, param5)
		local Sw_Max_val   = system.getInputsVal(sw.maxSw)
		local Sw_Min_val   = system.getInputsVal(sw.minSw)
		local Sw_Reset_val = system.getInputsVal(sw.resetmimaSw)

		if (sensor_I and sensor_I.valid) then

			if sensor_I.value > Pmax then Pmax = sensor_I.value end
			if sensor_I.value < Pmin then Pmin = sensor_I.value end

			if (not system.isPlayback()) then

				if (Sw_Max_val == 1) then
				 if (not se.maxDone) then
					 system.playNumber(Pmax, sensor_I.decimals, sensor_I.unit)
					 se.maxDone = true
				 end
			  else
			    se.maxDone = false
		    end

				if (Sw_Min_val == 1) then
         if (not se.minDone) then
					 system.playNumber(Pmin, sensor_I.decimals, sensor_I.unit)
					 se.minDone = true
				 end
        else
			    se.minDone = false
		    end

				if (Sw_Reset_val == 1) then
					Pmax = 0
					Pmin = 99
				end
			end
		end
	end
end


--------------------------------------------------------------------------------
local function init(code)
	local pLoad, registerForm, registerTelemetry = system.pLoad, system.registerForm, system.registerTelemetry
   
	model           = system.getProperty("Model")
	se.user         = system.getUserName("name")

	spirit          = pLoad("spirit",     0) == 1
	se.fuel         = pLoad("fuel",       0) == 1
	se.vibrate      = pLoad("vibrate",    0) == 1
	se.vibrates     = pLoad("vibrates",   0) == 1
	se.short        = pLoad("short",      0) == 1
	se.color        = pLoad("color",      0) == 1
	se.again        = pLoad("again",      0) == 1
	se.rise         = pLoad("rise",       0) == 1
	se.nickname     = pLoad("nickname",   0) == 1
	se.alphabet     = pLoad("alphabet",   0) == 1
	se.akkud        = pLoad("akkud",      0) == 1


	indexSensor1    = pLoad("sensor1",        1)
	indexSensor2    = pLoad("sensor2",        1)
	indexSensor3    = pLoad("sensor3",        1)
	indexSensor4    = pLoad("sensor4",        1)
	indexSensor5    = pLoad("sensor5",        1)
	indexSensor6    = pLoad("sensor6",        1)
	indexSensor7    = pLoad("sensor7",        1)
	indexSensor8    = pLoad("sensor8",        1)

	flightsTotal    = pLoad("flightsTotal",   0)
	flightsToday    = pLoad("flightsToday",   0)

	capa11          = pLoad("capa11",         0)
	capa12          = pLoad("capa12",         0)
	capa13          = pLoad("capa13",         0)
	capa2           = pLoad("capa2",          0)
	capa3           = pLoad("capa3",          0)
	capa4           = pLoad("capa4",          0)
	capaOld         = pLoad("capaOld",        0)
	se.alarmValue1  = pLoad("alarmValue1",   30)
	se.alarmValue2  = pLoad("alarmValue2",   30)
	se.alarmValue3  = pLoad("alarmValue3",   30)
	se.alarmValue11 = pLoad("alarmValue11",  50)
	se.alarmValue22 = pLoad("alarmValue22",  50)
	se.countdownSec = pLoad("countdownSec",   0)
	se.batteries    = pLoad("batteries",      0)
	se.crate	      = pLoad("crate",          0)
	se.bluehight    = pLoad("bluehight",      0)
	se.gpsLatVal    = pLoad("gpsLatVal",      0)
	se.gpsLatDec    = pLoad("gpsLatDec",      0)
	se.gpsLonVal    = pLoad("gpsLonVal",      0)
	se.gpsLonDec    = pLoad("gpsLonDec",      0)
	se.vorflugvolt  = pLoad("vorflugvolt",    0)  
	se.vorflugzeit  = pLoad("vorflugzeit",    0)  
	

	se.flightsReset = pLoad("flightsReset",   0)
	se.servo        = pLoad("servo",          1)
	se.mitohne      = pLoad("mitohne",        3)
	se.speedSensor  = pLoad("speedSensor",    1)
	se.speedTime    = pLoad("speedTime",      3)
	se.gehohe       = pLoad("gehohe",        50)
	se.countdownMin = pLoad("countdownMin",  10)
	se.timeTh       = pLoad("timeTh",       -90)
	se.risea        = pLoad("risea",          5)
  se.TimeDelay    = pLoad("TimeDelay",      0)

	flightDate      = pLoad("flightDate",   "")

	se.alarmVoice1  = pLoad("alarmVoice1",  "")
	se.alarmVoice2  = pLoad("alarmVoice2",  "")
	se.alarmVoice3  = pLoad("alarmVoice3",  "")
	se.monitorSound = pLoad("monitorSound", "")
	se.timerSound   = pLoad("timerSound",   "")

	fileImage       = pLoad("fileImage",    "")
  fileLogo        = pLoad("fileLogo",     "")
	fileBattery     = pLoad("fileBattery",  "")

	

	sw.an1Sw         = pLoad("an1Sw")
	sw.an2Sw         = pLoad("an2Sw")
	sw.an3Sw         = pLoad("an3Sw")
	sw.an4Sw         = pLoad("an4Sw")
	sw.capaSw        = pLoad("capaSw")
	sw.speedSw       = pLoad("speedSw")
	sw.engineSw      = pLoad("engineSw")
	sw.assSw         = pLoad("assSw")
	sw.flightSw      = pLoad("flightSw")
	sw.timerSw       = pLoad("timerSw")
	sw.flightsSw     = pLoad("flightsSw")
	sw.varihoheSw    = pLoad("varihoheSw")
	sw.maxSw         = pLoad("maxSw")
	sw.minSw         = pLoad("minSw")
	sw.statsTimeSw   = pLoad("statsTimeSw")
	sw.statsFlightSw = pLoad("statsFlightSw")
	sw.resetTimeSw   = pLoad("resetTimeSw")
	sw.resetRxSw     = pLoad("resetRxSw")
	sw.resetTeleSw   = pLoad("resetTeleSw")
	sw.resetStatsSw  = pLoad("resetStatsSw")
	sw.resetmimaSw   = pLoad("resetmimaSw")
	sw.gearSw        = pLoad("gearSw")  
	sw.flapsSw       = pLoad("flapsSw")
	sw.clutchSw      = pLoad("clutchSw")
	sw.ignitioSw     = pLoad("ignitioSw")
	sw.switchTilesSw = pLoad("switchTilesSw")
	Pmax = 0
	Pmin = 0
	
	se.option = 1

	if (se.short) then
		local timeMil = system.getTimeCounter()

		eLastTime     = timeMil
		fLastTime     = timeMil
		cLastTime     = timeMil

		eTime         = pLoad("eTime")
		fTime         = pLoad("fTime")
		cTime         = pLoad("cTime")

		if (eTime) then
			eTime = eTime / 1000
		end

		if (fTime) then
			fTime = fTime / 1000
		end

		if (cTime) then
			cTime = cTime / 1000
		end
	end

	if (eTime) then
		eMin       = math.floor(eTime/60)
		eSec       = eTime - eMin*60
	else
		eMin, eSec = 0, 0
	end

	if (fTime) then
		fHrs       = math.floor(fTime/3600)
		fMin       = math.floor(fTime/60) % 60
		fSec       = fTime % 60
	else
		fHrs, fMin, fSec = 0, 0, 0
	end

	if (cTime) then
		local abs  = math.abs(cTime)
		cMin       = math.floor(abs/60)
		cSec       = abs - cMin*60
	else
		cMin, cSec = se.countdownMin, se.countdownSec
	end

	-- hier stehen die Zeichen-Funktionen der Kacheln
  methods      = {nil, ka.drawBatteryPercent, ka.drawLevelPercent, ka.drawBattery, ka.drawLevel, ka.drawCurrent, ka.drawAkku, ka.drawImage, ka.drawRxMaxi1, ka.drawRxMini1, ka.drawHeight, ka.drawTemp, ka.drawVario, ka.drawRPM, ka.drawWatt, ka.drawTime, ka.drawAkkuVtg, ka.drawMuli, ka.drawSpeed, ka.drawTemp2, ka.drawFuel, ka.drawPump, ka.drawEcu, ka.drawG, ka.drawEngine, ka.drawVibes, ka.drawTimes, ka.drawThro, ka.drawModel, ka.drawAkku1, ka.drawAkku2, ka.drawAkku1s, ka.drawAkku2s, ka.drawCurrent1, ka.drawCurrent2, ka.drawKordinaten , ka.drawEngines, ka.drawStrecke, ka.drawRPM2, ka.drawCountdown, ka.drawLogo, ka.drawMuis, ka.drawSpeetri, ka.drawStats, ka.drawHeights, ka.drawAssi, ka.drawBatteryPercents, ka.drawLevelPercents, ka.drawAkkuBig, ka.drawFuelBig, ka.drawMTAG, ka.drawRxMaxi2, ka.drawRxMini2, ka.drawRxMaxi3, ka.drawRxMini3, ka.drawCRate, ka.drawName, ka.drawKw, ka.drawLei, ka.drawGear, ka.drawFlaps, ka.drawAss, ka.drawTEmps2, ka.drawTEmps3, ka.drawTemp3, ka.drawTemp4, ka.drawTurbine,ka.drawPercentss, ka.drawFlaps1, ka.drawAss1, ka.drawAss2, ka.drawCRateo, ka.drawcb, ka.drawcbao, ka.drawTemp5, ka.drawTEmp, ka.drawTEmps, ka.drawEntfernung, ka.drawhightbig, ka.drawkapatbig, ka.drawcba, ka.drawcbaa, ka.drawMbar, ka.vspeak1, ka.vspeak2, ka.drawAkkud, ka.drawSpeed3, ka.drawBattery2Percents, ka.drawGear1, ka.drawTowingClutch, ka.drawIgnition, ka.drawServo, ka.drawHeightBig, ka.drawCurrentBig, ka.drawAkkuVtgBig, ka.drawTemp6, ka.drawTemp7, ka.drawTemp8, ka.drawTemp9, ka.drawTemp10, ka.drawCurrent3, ka.drawAkku3, ka.drawGear2, ka.drawIgnition1, ka.drawIgnition2}
--heights      = {0, 41, 41, 115, 115, 36, 36, 62, 31, 22, 27, 36, 27, 27, 27, 36, 37, 81, 45, 36, 37, 37, 36, 19, 18, 36, 36, 36, 23, 37, 37, 36, 36, 36, 36, 50, 14, 36, 27, 36, 154, 36, 85, 18, 27, 23, 54, 54, 54, 54, 40, 31, 22, 31, 22, 36, 25, 28, 36, 38, 38, 19, 28, 39, 36, 36, 19, 158, 38, 19, 19, 36, 48, 36, 36, 60, 50, 36, 79, 79, 58, 36, 36, 19, 19, 36, 38, 155, 38, 38, 38, 36, 54, 54, 54, 36, 36, 36, 36, 36, 36, 37} -- H�hen der Kacheln eintragen
	heights      = {0, 41, 41, 115, 115, 36, 36, 61, 31, 22, 27, 36, 27, 27, 27, 36, 37, 81, 45, 36, 37, 36, 36, 19, 18, 36, 36, 36, 23, 37, 37, 36, 36, 36, 36, 43, 14, 36, 27, 36, 154, 36, 85, 18, 27, 23, 54, 54, 54, 54, 40, 31, 22, 31, 22, 36, 25, 28, 36, 38, 38, 19, 28, 39, 36, 36, 19, 155, 38, 19, 19, 36, 48, 36, 36, 60, 50, 36, 79, 79, 58, 36, 36, 19, 19, 36, 36, 155, 38, 38, 38, 36, 54, 54, 54, 36, 36, 36, 36, 36, 36, 37, 38, 38, 38} -- H�hen der Kachel
	sensors      = {trans.empty, trans.akkuvtg, trans.current, trans.akku, trans.strecke, trans.height, trans.varios, trans.tempa, trans.rpm, trans.watttrans, trans.muli1, trans.muli2, trans.muli3, trans.muli4, trans.muli5, trans.muli6, trans.schw, trans.speed, trans.sat, trans.tempa2, trans.fuel, trans.pump, trans.ecu, trans.g, trans.vibes, trans.thro, trans.akkuvtg1, trans.akkuvtg2, trans.akku1, trans.akku2, trans.current1, trans.current2, trans.Abs, trans.lei, trans.assa, trans.tempa3, trans.tempa4, trans.tempa5, trans.Ent, trans.MBAR, trans.speed3, trans.rpm2, trans.kordinatenb, trans.kordinatenc, trans.temp6, trans.temp7, trans.temp8, trans.temp9, trans.temp10, trans.current3, trans.akkuvtg3}  
	-- hier stehen die Optionen
	options      = {trans.other, trans.electric, trans.combustion, trans.cb, trans.expert}
	-- hier stehen f�r die H�he die Variabeln
	mitohne      = {trans.steigen, trans.sinken, trans.beides}
	
	servos       = {}
	
	for i=1, 24 do
		servos[i] = trans.servooutput..i
	end

	-- hier stehen die Indizes der Kacheln
	tileEngine   = 16
	tileFlight   = 27
	tileCounter  = 40
	tileSpeed    = 43

	methodsMax   = #methods
	sensorsMax   = #sensors

	rx.values, values, counts, positions, params, spacers, speedValues = {}, {}, {}, {}, {}, {}, {}
	names, ids, mtag = {}, {}, {}

	se.gpsTime = 0
	kw.value   = 0

	for i=1, rx.count do
		rx.values[i] = 0
	end

	for i=2, sensorsMax do
		values[i] = 0
	end

	for i=1, mtagMax do
		 mtag[i] = 0
	end

	for i=1, methodsMax do
		counts[i] = 0
	end

	for i=1, positionsMax do
		positions[i] = {}

		for j=1, positionMax do
			local position   = pLoad("positions."..i.."."..j, 1)
			positions[i][j]  = position
			counts[position] = counts[position] + 1
		end
	end

	for i=1, paramsMax do
		params[i] = {}

		for j=2, sensorsMax do
			params[i][j] = pLoad("params."..i.."."..j, 0)
		end
	end

	for i=1, positionsMax do
		spacers[-i] = pLoad("spacers."..-i, 3)
		spacers[ i] = pLoad("spacers.".. i, 1)
	end

	for i=1, se.batteries  do
		names[i] = pLoad("names."..i, "")
		ids  [i] = pLoad("ids."  ..i, 0 )
	end

	setDefaults()
	setLimits(true)
	setLimits(false)
	setSensors()
	setFlights()

	local name = ""
	if (not se.nickname) then
		local length = 60 - #se.user - #trans.appName21 - #model
		local spaces = string.rep(" ", length)

		name = spaces..se.user
	end

	registerForm(1, MENU_MAIN, trans.appName21, initForm, keyForm)
	registerTelemetry(1, trans.appName21.." 1: "..model..name, 4, ka.drawPage1)
	registerTelemetry(2, trans.appName21.." 2: "..model..name, 4, ka.drawPage2)
	
	if (se.akkud and capaOld > 0) then
		local result = form.question(trans.akkud3, trans.akkud1, trans.akkud2, 0, false, 0)
		
		if (result == 0) then
			akkudAnswer = false
		elseif (result == 1) then
			akkudAnswer = true
		end
	end
	
	collectgarbage()
end
--------------------------------------------------------------------------------
--changeColor(colors.color09)

setLanguage()
setColors()
collectgarbage()
return {init=init, loop=loop, author="Thorn Jeti Forum", version=appversion, name=trans.appName21}
-- x              linksb�ndig
-- x - width      rechtsb�ndig
-- x - width/2    mittig