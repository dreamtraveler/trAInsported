local versionCheck = {}

local configFile = "trAInsported.conf"

function versionCheck.start()

	versionMatch = nil

	exists = love.filesystem.exists( configFile )
	if exists then
		local file = love.filesystem.newFile( configFile )
		file:open('r')
		local data = file:read()
		--print("config file:", data)
		s, e = data:find("version = ")
		if s then 
			local tmp = data:sub(e+1, #data)
			s2, e2 = tmp:find("\r\n")
			if s2 then
				v = tmp:sub(1, s2-1)
				print("Config file is version:",  v)
				print("Game version:", version)
				if v == version then
					versionMatch = true
					print("Versions match!")
				end
			end
		end
	end
	
	if not versionMatch then
		local data = ""
		data = data .. "version = " .. version .. "\r\n"
		love.filesystem.write( configFile, data )
	end
end

function versionCheck.getMatch()
	return versionMatch
end

return versionCheck