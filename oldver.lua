print("Starting components...")
local c = require("component")
local computer = c.computer
local id = computer.address
print("Using " .. id .. " as computer address!")
local wallpapers = 0
os.sleep(1)
print("Starting gpusrv...")
local screen = c.screen
local gpu = c.gpu
print("Initializing UI...")
local w, h = gpu.getResolution()
function new_window(x, y, w, h)
  w = #id
  gpu.setBackground(0xFFFFFF)
  gpu.fill(x, y, w, h, " ")
  gpu.setBackground(0xAAAAAA)
  gpu.setForeground(0xFFFFFF)
  gpu.fill(x, y, w, 1, " ")
  gpu.set(x, y, id)
end
new_window(2, 2, 12, 4)
gpu.setBackground(0xFFFFFF)
gpu.setForeground(0x000000)
gpu.set(3, 4, "Starting CrowOS...")
local event = require("event")
local fs = require("filesystem")
local notepad = false
local f = fs.open("/home/notepad.txt")
local notepad_text = f:read(64)
f:close()
local keyboard = require("keyboard")
new_window(2, 2, 12, 4)
gpu.setBackground(0xFFFFFF)
gpu.setForeground(0x000000)
gpu.set(3, 4, "CrowOS has started! Click to continue")
while true do
  local e, _, x, y = event.pullMultiple("touch", "key_down")
  gpu.setBackground(0x0000FF)
  gpu.setForeground(0xFFFFFF)
  gpu.set(2, h - 1, "REFRESHING SCREEN...")
  if (wallpapers == "1") then
    for y = 1, h do
      for x = 1, w do
        gpu.setBackground(0x000000)
        gpu.setForeground(x + y * 2)
        gpu.set(x, y, utf8.char(x + y * w))
      end
    end
  else
    gpu.setBackground(0x000000)
    gpu.fill(1, 1, w, h, " ")
  end
  if (e == "touch" and x > 1 and x < (1 + #"Programs") and y == 1) then
    gpu.setBackground(0xFFFFFF)
    gpu.setForeground(0xFFFFFF)
    gpu.fill(1, 1, w, 1, " ")
    gpu.setBackground(0x0000FF)
    gpu.set(2, 1, "Programs")
    gpu.setBackground(0xFFFFFF)
    gpu.setForeground(0x000000)
    gpu.set(2, 2, "Text Editor")
  else
    gpu.setBackground(0xFFFFFF)
    gpu.setForeground(0x000000)
    gpu.fill(1, 1, w, 1, " ")
    gpu.set(2, 1, "Programs")
  end
  if ((e == "touch" and x > 1 and x < (1 + #"Text Editor") and y == 2) or e == "key_down") then
    notepad = true
    if (e == "key_down") then
      if (keyboard.keys[y] == "back") then
        notepad_text = notepad_text:sub(1, -2)
      elseif (keyboard.keys[y] == "space") then
        notepad_text = notepad_text .. " "
      else
        notepad_text = notepad_text .. keyboard.keys[y]
      end
      local f = fs.open("/home/notepad.txt", "w")
      f:write(notepad_text, notepad_text)
      f:close()
    end
  end
  if (e == "touch" and x == 65 and y == 3) then
    notepad = false
  end
  if (notepad) then
    gpu.setBackground(0xFFFFFF)
    gpu.setForeground(0x000000)
    gpu.fill(2, 3, 64, 16, " ")
    gpu.setBackground(0xAAAAAA)
    gpu.fill(2, 3, 64, 1, " ")
    gpu.set(2, 3, "Text Editor")
    gpu.setBackground(0xFF0000)
    gpu.set(65, 3, "X")
    gpu.setBackground(0xFFFFFF)
    gpu.set(2, 4, notepad_text)
  end
  gpu.setBackground(0xFF0000)
  gpu.setForeground(0xFFFFFF)
  gpu.set(w - #"DEMO VERSION", 1, "DEMO VERSION")
  gpu.setBackground(0x0000FF)
  gpu.setForeground(0xFFFFFF)
  gpu.set(2, h - 1, "MONITOR 1")
  gpu.set(3 + #"MONITOR 1", h - 1, x .. "x" .. y)
end