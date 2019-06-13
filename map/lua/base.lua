local runtime = require 'jass.runtime'
local console = require 'jass.console'

base = {}

-- 判断是否是发行版本
base.release = true

-- 版本
base.version = '0.01'

-- 是否打开控制台
if base.release then
    console.enable = true
end

-- 中文不乱码
print = console.write

-- 将句柄等级设置为0(地图中所有的句柄均使用table封装)
runtime.handle_level = 0

-- 关闭等待
runtime.sleep = false

function base.error_handle(msg)
    print("---------------------------------------")
	print(tostring(msg) .. "\n")
	print(debug.traceback())
	print("---------------------------------------")
end

--错误汇报
function runtime.error_handle(msg)
	base.error_handle(msg)
end

package.path = package.path ..[[\;scripts\?.lua]]

if base.release then
	--调试器端口
	runtime.debugger = 4279
end

local std_print = print

function print(...)
	std_print(('[%.3f]'):format(os.clock()), ...)
end

-- 初始化脚本
require 'main'