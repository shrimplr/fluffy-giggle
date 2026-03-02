require("Modules/assets")
require("Modules/sfx")

require("Assets/load_assets")

Game = {}
Game.State = 0
Game.totaltime = 0

require("Modules.space_obj")
require("space")

Load_State = {
    [0] = IntroLoad,
    [0.5] = PreGameLoad,
    [1] = GameLoad,
   -- [0.1] = SettingsLoad
}

Update_State = {
    [0] = IntroUpdate,
    [0.5] = PreGameUpdate,
    [1] = GameUpdate,
    --[0.1] = SettingsUpdate
}

Keypressed_State = {
    [0] = IntroKey,
    [0.5] = PreGameKey,
    [1] = GameKey,
    [2] = OverKey,
    [3] = WinKey,
    --[0.1] = SettingsKey
}

Mousepressed_State = {
    [0] = IntroMouse,
    [1] = GameMouse,
}

Draw_State = {
    [0] = IntroDraw,
    [0.5] = PreGameDraw,
    [1] = GameDraw,
    [2] = OverDraw,
    [3] = WinDraw,
    --[0.1] = SettingsDraw
}
