-- =====================================================
-- Wonder Chase | Obby Module: TNS
-- Di-load dinamis oleh Main.lua lewat loadstring(game:HttpGet(...))()
-- Return: table config obby ini
-- =====================================================

return {
        TOTAL_TIME = 180, -- akan di-override random 180-190 saat runOneLap
        SPAWN_Y = 54.19,
        PATH_GAME_START = {"Utility","ObbyColliders","GameStart"},
        PATH_GAME_STOP  = {"Utility","ObbyColliders","GameStop"},
        PATH_PORTAL     = {"Utility","Teleporters","Portal_to_Wc"},
        SWEEP_MODE = true,
        SWEEP_FOLDERS = {"Pickups", "ActiveStickers", "Checkpoints-NoSticker"},
        SWEEP_FOLDER_PATHS = {
            ["Pickups"] = {"Pickups"},
            ["ActiveStickers"] = {"ActiveStickers"},
            ["Checkpoints-NoSticker"] = {"Level", "Checkpoints"},
        },
        START_POS = Vector3.new(31.56, 54.19, -256.96),
        RANDOM_TIME = {150, 160}, -- override TOTAL_TIME random tiap lap
        FLOAT_ON_SWEEP = true, -- aktifkan BodyVelocity naik pelan selama sweep
        waypoints = {}
    }
