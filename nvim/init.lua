require('siray.base')
require('siray.highlights')
require('siray.maps')
require('siray.plugins')

local has = function(x)
    return vim.fn.has(x) == 1
end
local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then
    require('siray.macos')
end
if is_win then
    require('siray.windows')
end
