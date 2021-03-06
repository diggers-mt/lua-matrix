#! /usr/bin/env lua
--
-- get-user-info.lua
-- Copyright (C) 2016 Adrian Perez <aperez@igalia.com>
--
-- Distributed under terms of the MIT license.
--

if #arg ~= 3 then
   io.stderr:write(string.format("Usage: %s <homeserver-URL> <username> <password>\n", arg[0]))
   os.exit(1)
end

local client = require "matrix" .client(arg[1])
client:login_with_password(arg[2], arg[3])

local user = client:get_user()
print("User ID: " .. user.user_id)

user:hook("property-changed", function (user, property)
   print("  - " .. property .. ": " .. tostring(user[property]))
end)
user:update_display_name()
user:update_avatar_url()

client:logout()
