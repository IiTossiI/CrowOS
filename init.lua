print("Initializing CrowOS...")
local c = require("component")
local computer = c.computer
local id = computer.address
print("Using " .. id .. " as computer address!")
os.sleep(1)
local gpu = c.gpu
local w, h = gpu.getResolution()
function new_window(x, y, w, h)
  w = #id
  gpu.setBackground(0xFFFFFF)
  gpu.fill(x, y, w, h, " ")
  gpu.setBackground(0xAAAAAA)
  gpu.fill(x, y, w, 1, " ")
  gpu.set(x, y, id)
end
new_window(2, 2, 12, 4)
gpu.setBackground(0xFFFFFF)
gpu.setForeground(0x000000)
gpu.set(3, 4, "Starting CrowOS...")
os.sleep(1)
local event = require("event")
while true do
  local _, _, x, y = event.pull("touch")
  gpu.setBackground(0x0000FF)
  gpu.setForeground(0xFFFFFF)
  gpu.set(2, h - 1, "REFRESHING SCREEN...")
  for y = 1, h do
    for x = 1, w do
      gpu.setBackground(x + y * 2)
      gpu.setForeground(0x000000)
      gpu.set(x, y, string.char(x + y))
    end
  end
  if (x > 1 and x < (1 + #"Programs") and y == 1) then
    gpu.setBackground(0xFFFFFF)
    gpu.setForeground(0xFFFFFF)
    gpu.fill(1, 1, w, 1, " ")
    gpu.setBackground(0x0000FF)
    gpu.set(2, 1, "Programs")
    gpu.setBackground(0xFFFFFF)
    gpu.setForeground(0x000000)
    gpu.set(2, 2, "Nothing here")
  else
    gpu.setBackground(0xFFFFFF)
    gpu.setForeground(0x000000)
    gpu.fill(1, 1, w, 1, " ")
    gpu.set(2, 1, "Programs")
  end
  gpu.setBackground(0x0000FF)
  gpu.setForeground(0xFFFFFF)
  gpu.set(2, h - 1, "MONITOR 1")
  gpu.set(3 + #"MONITOR 1", h - 1, w .. "x" .. h)
end