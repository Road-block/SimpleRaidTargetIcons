-- Setup the translation table.
-- DO NOT EDIT THIS BLOCK
SRTI_LOCALE = setmetatable({},{__index = function(t,k)
  local v = tostring(k)
  rawset(t,k,v)
  return v
end})
local L = SRTI_LOCALE
local LOCALE = GetLocale()

-- Add terms to each local locale block.
-- No terms need be added for English.
-- English is the default and fallback for missing terms in other languages.

if LOCALE == "zhCN" then
  -- creature types
  L["Humanoid"] = "人形"
  L["Giant"] = "巨人"
  L["Beast"] = "野兽"
  L["Dragonkin"] = "龙类"
  L["Demon"] = "恶魔"
  L["Elemental"] = "元素"
  L["Undead"] = "亡灵"
  L["Mechanical"] = "机械"
  -- CC Immune
    -- ZG
  L["Gurubashi Champion"] = "古拉巴什勇士"
  L["Gurubashi Berserker"] = "古拉巴什狂暴者"
    -- MC
  L["Ancient Core Hound"] = "上古熔火恶犬"
  L["Firelord"] = "火焰之王"
  L["Flameguard"] = "烈焰守卫"
  L["Firewalker"] = "火焰行者"
    -- BWL
  L["Death Talon Captain"] = "死爪龙人队长"
  L["Death Talon Wyrmguard"] = "死爪龙人护卫"
  L["Death Talon Flamescale"] = "死爪火鳞龙人"
  L["Death Talon Seether"] = "死爪狂乱者"
  L["Death Talon Overseer"] = "死爪监工"
  L["Blackwing Spellbinder"] = "黑翼缚法者"
  L["Blackwing Technician"] = "黑翼技师"
  L["Blackwing Warlock"] = "黑翼管理者"
  -- Kill Targets
  L["Firewalker"] = "火焰行者"
  L["Flameguard"] = "烈焰守卫"
  L["Lava Elemental"] = "熔岩元素"
  L["Lava Reaver"] = "熔岩掠夺者"
  L["Gurubashi Berserker"] = "古拉巴什狂暴者"
  -- Packs
  L["Slavering Ghoul"] = "被奴役的食尸鬼"
  L["Firesworn"] = "火誓者"
  L["Core Hound"] = "熔火恶犬"
  L["Flamewaker Healer"] = "烈焰行者医师"
  L["Flamewaker Elite"] = "烈焰行者精英"
  -- Options
  L[" - %0/srti\n no command opens the options menu\n commands to set icon on target"] = " - %0/srti\n 没有命令打开选项菜单\n 在目标上设置图标的命令"
  L[" - %1Demoted"] = " - %1降职"
  L[" - %1Not Promoted"] = " - %1不能提升"
  L[" - %1Party leader is out of range of target."] = " - %1队长超出目标范围."
  L[" - %1Promoted"] = " - %1提升-"
  L["Click above to test settings"] = "点击上面测试设置"
  L["Demote SRTI Assistant"] = "降职 SRTI 助手"
  L["Demotes party member from SRTI assistant."] = "降职队伍成员从 SRTI 助手."
  L["Double Click Speed - %s sec"] = "双击速度 - %s 秒"
  L["Double Left Click"] = "双击左键"
  L["Enable"] = "启用"
  L["Hover Wait Time - %s sec"] = "悬停等待时间 - %s 秒"
  L["Key Bindings"] = "快捷键"
  L["Left Click"] = "左键单击"
  L["Modifiers"] = "调节器"
  L["Press |cffffffffEsc|r to cancel"] = "按 |cffffffffEsc|r 退出"
  L["Promote SRTI Assistant"] = "提升 SRTI 助手"
  L["Promotes party member to SRTI assistant."] = "提升队伍成员到 SRTI 助手."
  L["Quick"] = "快"
  L["Radial Menu Options"] = "径向菜单选项"
  L["Select Icon on Hover"] = "在悬停上选择图标"
  L["Slow"] = "慢"
  L["SRTI Assistant"] = "SRTI 助手"
  L["SRTI Assistants"] = "SRTI 助手"
  L["SRTI Disabled"] = "SRTI 禁用"
  L["SRTI Not Promoted"] = "SRTI 不能提升"
  L["Test Me"] = "测试"
  L["|cffff0000%s Function will be Unbound from this Key!"] = "|cffff0000%s 功能将从此键中释放！"
  L["|cffff0000%s Function will be Unbound!"] = "|cffff0000%s 功能将被释放!"
  L["|cffff0000You are about to unbind key from |r%s"] = "|cffff0000你要取消绑定按键 |r%s"
  L["|cffffffffPress a key to bind |r%s"] = "|cffffffff按键绑定 |r%s"
  -- Keybinds
  L["Show Radial Menu"] = "径向菜单显示"
  L["Mouseover Mark CC"] = "鼠标悬停标记 职业类型怪物"
  L["Mouseover Clear Marks"] = "鼠标悬停退出标记"
  L["CC TargetBar"] = "职业类型怪物 目标条"
  L["Yellow Star Icon"] = "黄色星星图标"
  L["Orange Circle Icon"] = "橙色圆圈图标"
  L["Purple Diamond Icon"] = "紫色钻石图标"
  L["Green Triangle Icon"] = "绿色三角形图标"
  L["Silver Moon Icon"] = "银色月亮图标"
  L["Blue Square Icon"] = "蓝色方块图标"
  L["Red Cross Icon"] = "红色十字图标"
  L["White Skull Icon"] = "白色骷髅图标"
  L["Target Star"] = "目标星星"
  L["Target Circle"] = "目标圆圈"
  L["Target Diamond"] = "目标菱形"
  L["Target Triangle"] = "目标三角"
  L["Target Moon"] = "目标月亮"
  L["Target Square"] = "目标方块"
  L["Target Cross"] = "目标十字"
  L["Target Skull"] = "目标骷髅"
  L["Remove Icon"] = "清除图标"
  -- Cursor Companion Text
  L["%s|cffffffffSkull|r"] = "%s|cffffffff骷髅|r"
  L["%s|cffFF4500Cross|r"] = "%s|cffFF4500叉叉|r"
  L["%s|cff00BFFFSquare|r"] = "%s|cff00BFFF方块|r"
  L["%s|cffc7c7cfMoon|r"] = "%s|cffc7c7cf月亮|r"
  L["%s|cff7CFC00Triangle|r"] = "%s|cff7CFC00三角|r"
  L["%s|cffff00ffDiamond|r"] = "%s|cffff00ff菱形|r"
  L["%s|cffff8000Circle|r"] = "%s|cffff8000圆圈|r"
  L["%s|cffffff00Star|r"] = "%s|cffffff00星星|r"
  -- Icon Names
  L["remove icon"] = "清除图标"
  L["yellow star"] = "黄色星星"
  L["orange circle"] = "橙色圆圈"
  L["purple diamond"] = "紫色钻石"
  L["green triangle"] = "绿色三角形"
  L["silver moon"] = "银色月亮"
  L["blue square"] = "蓝色方块"
  L["red cross"] = "红色十字"
  L["white skull"] = "白色骷髅"
  -- Tooltip
  L["Mark "] = "标记 "
  L["Target "] = "目标 "
  L["Click to target %s"] = "点击目标 %s"
  L["Group Target Scan"] = "队伍目标扫描"
  L["Drag icon over units."] = "在头像上点击和拖动."
  L["Targets %s"] = "目标 %s"
  return
end

if LOCALE == "ruRU" then

  return
end