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
}

Update_State = {
    [0] = IntroUpdate,
    [0.5] = PreGameUpdate,
    [1] = GameUpdate,
}

Keypressed_State = {
    [0] = IntroKey,
    [0.5] = PreGameKey,
    [1] = GameKey,
    [2] = OverKey
}

Mousepressed_State = {
    [0] = IntroMouse,
    [1] = GameMouse,
}

Draw_State = {
    [0] = IntroDraw,
    [0.5] = PreGameDraw,
    [1] = GameDraw,
    [2] = OverDraw
}
