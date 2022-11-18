print("Initializing CrowOS...")
local c = require("component")
local computer = c.computer
local id = computer.address
print("Using " .. id .. " as computer address!")
os.sleep(1)
local gpu = c.gpu
local w, h = gpu.getResolution()
function new_window(x, y, w, h)
  x = #id
  gpu.setBackground(0xFFFFFF)
  gpu.fill(x, y, w, h, " ")
  gpu.setBackground(0xAAAAAA)
  gpu.fill(x, y, w, 1, " ")
  gpu.set(x, y, id)
end
new_window(2, 2, 12, 4)
gpu.setBackground(0xAAAAAA)
gpu.fill(3, 4, 10, 1, " ")
for i = 1, 10 do
  gpu.setBackground(0x00FF00)
  gpu.set(2 + i, 4, " ")
  os.sleep(1)
end
os.sleep(10)
for y = 1, h do
  for x = 1, w do
    gpu.setBackground(x + y)
    gpu.set(x, y, " ")
  end
end
gpu.setBackground(0x0000FF)
gpu.set(2, h - 1, "MONITOR 1")