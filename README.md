# Agate Util

This tool allows you to load your addon files dynamically

## Features
- [x] Facilitates file loadding
- [x] Clean logging

## Usage

The addon is designed to be used with [Helix](https://github.com/NebulousCloud/helix). But you can work without it if you always `prioritize` or just edit the `sh_agate_utils.lua:94`.<br><br>
It will load the files **alphabetically** meaning that you can set order of files loading, but don't forget the the recursion load isn't flat: so a folder's files will be prioritized if the folder's name is greater at the alphabetical order.

### Folder Structure
```
📂 addons
  📂 your_addon_name
    📂 lua
      📂 autorun
         📄 your_addon_name_init.lua
      📂 your_addon_name
         📄 cl_init.lua (You can name it whatever you want, it's just an example)
         📄 sv_init.lua (same)
         📄 sh_init.lua (same again smh)
         📂 example_folder_again
            📄 sh_things.lua (an example again, this will load too)
```
and in the `your_addon_name_init.lua` file
```lua
if not AgateUtil then
     hook.Add("AgateUtilReady", "your_addon_name", function()
          AgateUtil:LoadAddon("your_addon_name", false)
     end)
else
     AgateUtil:LoadAddon("your_addon_name", false)
end
```

## Functions

```lua
-- Load an addon
AgateUtil:LoadAddon(addon_name, prioritized)
```
- addon_name `string`
  - The addon's name to load
- prioritized `boolean`
  - Should the addon load before Helix

***

```lua
-- Fancy console log
AgateUtil:Log(addon_name, ...)
```
- addon_name `string`
  - The addon's name to load
- prioritized `boolean`
  - Should the addon load before Helix
- Example: 
  ```lua
  SardonUtil:Log("Sardon İksir", AgateUtil.colors.purple, ply:Nick(), AgateUtil.colors.yellow, " used ", AgateUtil.colors.blue, "[" .. pot_name .. "]")
  ```
  ![img](https://media.discordapp.net/attachments/724403355450867743/939250243097202758/unknown.png)

## License

Copyright 2022 Can Bora CİNER

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.