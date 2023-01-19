fs = require("filesystem")
net = require("internet")
fs.remove("/home/init.lua")
f = net.request("https://crowos.glitch.me/main.lua")
result = ""
for line in f do
  result = result .. line
end
f = io.open("/home/main.lua", "w")
f:write(result)
f:close()
os.execute("/home/main.lua")
