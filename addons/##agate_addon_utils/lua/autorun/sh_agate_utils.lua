AgateUtil = AgateUtil or {}
AgateUtil.__loaded = AgateUtil.__loaded or {}
AgateUtil.__addonQueue = AgateUtil.__addonQueue or {}

AgateUtil.colors = {
     white = Color(255, 255, 255),
     blue = Color(0, 255, 255),
     yellow = Color(201, 176, 15),
     red = Color(230, 58, 64),
     green = Color(46, 204, 113),
     purple = Color(174, 0, 255)
}

local white = Color(255, 255, 255)
local blue = Color(0, 255, 255)
local yellow = Color(201, 176, 15)
local red = Color(230, 58, 64)
local green = Color(46, 204, 113)
local purple = Color(174, 0, 255)

local function __LoadAddon(root_dir)
     local files, directories = file.Find(root_dir .. "/*", "LUA")
     local allFiles = {}
     local allFileNames = {}

     for _, v in pairs(files) do
          allFiles[v] = "f"
          table.insert(allFileNames, v)
     end

     for _, v in pairs(directories) do
          allFiles[v] = "d"
          table.insert(allFileNames, v)
     end

     for _, v in SortedPairs(allFileNames, false) do
          local fileType = allFiles[v]

          if (fileType == "f") then
               if not string.EndsWith(v, ".lua") then return end
               v = root_dir .. "/" .. v

               if v:find("sv_") and SERVER then
                    include(v)
                    MsgC(red, "[Agate Addon Util] ", blue, "(SV) ", white, "Loaded ", green, v, "\n")
               elseif v:find("sh_") then
                    if SERVER then
                         AddCSLuaFile(v)
                    end

                    include(v)
                    MsgC(red, "[Agate Addon Util] ", purple, "(SH) ", white, "Loaded ", green, v, "\n")
               elseif v:find("cl_") then
                    if SERVER then
                         AddCSLuaFile(v)
                    else
                         include(v)
                    end

                    MsgC(red, "[Agate Addon Util] ", yellow, "(CL) ", white, "Loaded ", green, v, "\n")
               end
          elseif (fileType == "d") then
               __LoadAddon(root_dir .. "/" .. v)
          end
     end
end

function AgateUtil:Log(addon_name, ...)
     MsgC(unpack({red, "[" .. addon_name .. "] ", yellow, ...}))
end

function AgateUtil:LoadAddon(addon_name, prioritized)
     if table.HasValue(AgateUtil.__loaded, addon_name) then return end

     if not prioritized and ix == nil and not table.HasValue(AgateUtil.__addonQueue, addon_name) then
          table.insert(AgateUtil.__addonQueue, addon_name)
     else
          __LoadAddon(addon_name)
          table.insert(AgateUtil.__loaded, addon_name)
          MsgC(red, "[Agate Addon Util] ", yellow, purple, addon_name, yellow, " has been successfully activated!\n\n")
     end
end

function AgateUtil:TableMap(tbl, cb)
     local el = {}

     for key, value in pairs(tbl) do
          el[key] = cb(value, key, tbl)
     end

     return el
end

hook.Add("InitializedSchema", "addon_loader", function()
     for _, v in ipairs(AgateUtil.__addonQueue) do
          __LoadAddon(v)
          table.insert(AgateUtil.__loaded, v)
          MsgC(red, "[Agate Addon Util] ", yellow, addon_name .. " has been successfully activated!\n\n")
     end
end)

MsgC(red, "[Agate Addon Util] ", yellow, "Activated!\n\n")

timer.Simple(0, function()
     hook.Run("AgateUtilReady")
end)
