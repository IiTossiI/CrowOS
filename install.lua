computer = require("computer")
fs = require("filesystem")
fs.remove("/home/install.lua")
f = io.open("/home/.shrc", "w")
f:write("cd /home/\nwget -fq https://raw.githubusercontent.com/IiTossiI/CrowOS/main/init.lua\n./init.lua")
f:close()
computer.shutdown(true)