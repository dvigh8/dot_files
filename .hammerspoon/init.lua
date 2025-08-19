-- add password to keychain add -U to update existing password
-- security add-generic-password -a "$USER" -s "MY_API_KEY" -w "supersecret123"

local function getKey(service)
	local handle = io.popen("security find-generic-password -a $USER -s " .. service .. " -w")
	local result = handle:read("*a")
	handle:close()
	return result:gsub("%s+", "")
end

HA_TOKEN = getKey("HA_TOKEN")

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
	hs.notify.new({ title = "Hammerspoon", informativeText = "Hello World" }):send()
end)

-- Example HammerSpoon script
hs.hotkey.bind({ "cmd", "ctrl" }, "L", function()
	-- Call Home Assistant REST API
	hs.http.asyncPost(
		"http://homeassistant.local:8123/api/services/light/toggle",
		'{"entity_id": ["light.innr_2", "light.innr_3"]}',
		{ ["Authorization"] = "Bearer " .. HA_TOKEN, ["Content-Type"] = "application/json" },
		function(status, body, headers)
			if status == 200 then
				hs.notify.show("Home Assistant", "", "Lights toggled")
			else
				hs.notify.show("Home Assistant", "", "Error: " .. body)
			end
		end
	)
end)
