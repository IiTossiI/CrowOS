print("Initializing CrowOS...")
local c = require("component")
local computer = c.computer
local id = computer.address
print("Using " .. id .. " as computer address!")
print("Should wallpapers be enabled?")
print("0 for no, 1 for yes")
local wallpapers = io.read()
os.sleep(1)
local screen = c.screen
local gpu = c.gpu
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
local notepad = false
local term = require("term")
new_window(2, 2, 12, 4)
gpu.setBackground(0xFFFFFF)
gpu.setForeground(0x000000)
gpu.set(3, 4, "CrowOS has started! Click to continue")
while true do
  local _, _, x, y = event.pull("touch")
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
  if (x > 1 and x < (1 + #"Programs") and y == 1) then
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
  if (x > 1 and x < (1 + #"Text Editor") and y == 2) then
    notepad = true
  end
  if (notepad) then
    gpu.setBackground(0xFFFFFF)
    gpu.setForeground(0x000000)
    gpu.fill(2, 3, 64, 16, " ")
    gpu.setBackground(0xAAAAAA)
    gpu.fill(2, 3, 64, 1, " ")
    gpu.set(2, 3, "Text Editor")
    gpu.setBackground(0xFFFFFF)
    term.setCursor(2, 4)
    io.read()
  end
  gpu.setBackground(0xFF0000)
  gpu.setForeground(0xFFFFFF)
  gpu.set(w - #"DEMO VERSION", 1, "DEMO VERSION")
  gpu.setBackground(0x0000FF)
  gpu.setForeground(0xFFFFFF)
  gpu.set(2, h - 1, "MONITOR 1")
  gpu.set(3 + #"MONITOR 1", h - 1, w .. "x" .. h)
end