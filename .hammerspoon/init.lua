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

-- Toggle Microsoft Teams microphone
hs.hotkey.bind({ "cmd", "ctrl" }, "M", function()
	local teams = hs.application.find("Microsoft Teams")
	if teams then
		local previousApp = hs.application.frontmostApplication()
		teams:activate()
		hs.timer.doAfter(0.1, function()
			hs.eventtap.keyStroke({ "cmd", "shift" }, "M")
			hs.timer.doAfter(0.1, function()
				if previousApp and previousApp ~= teams then
					previousApp:activate()
				end
			end)
		end)
		hs.notify.show("Teams", "", "Microphone toggled")
	else
		hs.notify.show("Teams", "", "Microsoft Teams is not running")
	end
end)
-- Toggle Microsoft Teams video
hs.hotkey.bind({ "cmd", "ctrl" }, "V", function()
	local teams = hs.application.find("Microsoft Teams")
	if teams then
		local previousApp = hs.application.frontmostApplication()
		teams:activate()
		hs.timer.doAfter(0.1, function()
			hs.eventtap.keyStroke({ "cmd", "shift" }, "O")
			hs.timer.doAfter(0.1, function()
				if previousApp and previousApp ~= teams then
					previousApp:activate()
				end
			end)
		end)
		hs.notify.show("Teams", "", "Video toggled")
	else
		hs.notify.show("Teams", "", "Microsoft Teams is not running")
	end
end)
-- End Microsoft Teams Call
hs.hotkey.bind({ "cmd", "ctrl" }, "D", function()
	local teams = hs.application.find("Microsoft Teams")
	if teams then
		local previousApp = hs.application.frontmostApplication()
		teams:activate()
		hs.timer.doAfter(0.1, function()
			hs.eventtap.keyStroke({ "cmd", "shift" }, "H")
			hs.timer.doAfter(0.1, function()
				if previousApp and previousApp ~= teams then
					previousApp:activate()
				end
			end)
		end)
		hs.notify.show("Teams", "", "Call Ended")
	else
		hs.notify.show("Teams", "", "Microsoft Teams is not running")
	end
end)
