local appName="DateTime"

local function printDate()
  --lcd.drawImage((310-imagepng.width)/2, -70, imagepng)
  local dt = system.getDateTime()
  lcd.setColor(255,255,255)
  local dtDate = string.format("%02d.%02d.%d", dt.day, dt.mon, dt.year)
  local dtTime = string.format("%d:%02d:%02d", dt.hour, dt.min, dt.sec)
  lcd.drawText((310 - lcd.getTextWidth(FONT_MAXI,dtDate))/2,75,dtDate,FONT_MAXI)
  lcd.drawText((310 - lcd.getTextWidth(FONT_MAXI,dtTime))/2,110,dtTime,FONT_MAXI)
end

local function init()
  system.registerTelemetry(2,"Jeti DC-14 powered by C. Zielke",4,printDate);
  --imagepng = lcd.loadImage("Apps/Images/thoughts.png")
end
--------------------------------------------------------------------

return { init=init, loop=loop, author="C. Zielke", version="1.00",name=appName}