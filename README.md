## Simple RaidTarget Icons
SRTI offers several functional improvements to Raid Target Marking in vanilla.

### Description
The main innovation of SRTI is the ability to raid mark in the 3D world by directly double-clicking or modifier-clicking units.  
This will show a radial menu that allows for fast marking.  
The addon provides convenience and utility both for **marking** a unit and **targetting** a mark.  
Mark > Target || Target > Mark.

### Configuration
`/srti` will bring up the options interface.  
Most of the options can be selected and tested without a party there.
![SimpleRaidTargetIcons Options](https://github.com/Road-block/SimpleRaidTargetIcons/raw/docs/srti_options.png)

### Features
1. Radial Popup Marking Menu. ![SimpleRaidTargetIcons Radial Menu](https://github.com/Road-block/SimpleRaidTargetIcons/raw/docs/srti_unit_radial_mark.png)
2. Ability to set SRTI Assistants in 5man Groups that allow other players than the leader to mark (both players need the addon)  
This can for example be used to retain control of masterlooting while allowing a puller / tank to mark. ![SimpleRaidTargetIcons Assistant](https://github.com/Road-block/SimpleRaidTargetIcons/raw/docs/srti_party_assistant.png)
3. Support for double-click or modifier-click radial marking menu on many unitframes (pfUI, Luna, oRA2, Blizzard unitframes) ![SimpleRaidTargetIcons unitframes](https://github.com/Road-block/SimpleRaidTargetIcons/raw/docs/srti_unitframe_radial_mark.png)
4. On demand mark/kill order bar (shown at the cursor on keybind) with icons to target existing marks. ![SimpleRaidTargetIcons Mark Order](https://github.com/Road-block/SimpleRaidTargetIcons/raw/docs/srti_targetbar.png)
    - Click the icon and the addon will do a target scan of everyone in your group to find that target.
    - Alternatively click and drag the icon over a group of mobs and the addon will automatically target the one with the matching mark.
5. A bunch of keybinds provided in the default keybinding menu to perform various tasks:
    - Mouseover CC mark groups of mobs intelligently, based on mob types and CC classes present in the group.
    - Mouseover mass mark Garr Firesworn, Core Hound packs, Majordomo adds for RL convenience (more to be added)
    - Keybind to mark your target or mouseover unit.
      - Pressing and holding the keybind loads a mark on the cursor to "drop" on a mouseover unit.
    - Load a specific mark on the cursor and mouseover marked mobs to target that mark.
    - Mark cleaner. Hold keybind and swipe the cursor across a bunch of marked mobs to remove all marks.
![SimpleRaidTargetIcons Keybinds](https://github.com/Road-block/SimpleRaidTargetIcons/raw/docs/srti_keybinds.png)

### Caveats
SRTI has only been tested on the English client. Mass marking will not work without localization (there will be no errors, they will just silently fail)  
SRTI is not a replacement for BananaBar and will likely never be, despite some overlap in features.  
It doesn't continuously scan group targets for performance reasons, so features like showing marked targets HP or number of group members targetting a mark are not in the scope of this addon.  
If you want those features use the addon that provides them, the two can co-exist without issues.  
This addon is geared more towards the keybinding style of play while BananaBar towards the visual, clicking style of play.  
SRTI will be invisible 90% of the time, except when you call for it using one of its keybinds or click combos.

### Download
Get the SimpleRaidTargetIcons-x.y.z-11200.zip file from [latest](https://github.com/Road-block/SimpleRaidTargetIcons/releases/latest) and extract in your AddOns folder.
