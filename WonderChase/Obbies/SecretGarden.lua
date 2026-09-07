-- =====================================================
-- Wonder Chase | Obby Module: Secret Garden
-- Di-load dinamis oleh Main.lua lewat loadstring(game:HttpGet(...))()
-- Return: table config obby ini
-- =====================================================

return {
        TOTAL_TIME = 100, -- akan di-override saat runOneLap
        SPAWN_Y = 17.1,
        PATH_GAME_START = {"Utility","ObbyColliders","GameStart"},
        PATH_GAME_STOP  = {"Utility","ObbyColliders","GameStop"},
        PATH_PORTAL     = {"Utility","Teleporters","Portal_to_Wc"},
        SWEEP_MODE = true,  -- Mode sweep folder, bukan waypoint biasa
        SWEEP_FOLDERS = {"Pickups", "Stickers"},
        RANDOM_TIME = {90, 100}, -- override TOTAL_TIME random tiap lap
        FLOAT_ON_SWEEP = true, -- aktifkan BodyVelocity naik pelan selama sweep
        SWEEP_STOP_ITEM = "sg10", -- nama item yang menandakan sweep selesai
        FLOAT_STOP_ITEM = "CheckpointNoSticker15A", -- nama item yang mematikan float
        INITIAL_TELEPORT = Vector3.new(8.66, -21.43, -240.53), -- teleport awal sebelum sweep
        INITIAL_CHECKPOINT_PATH = {"Stickers", "CheckpointNoSticker00A", "CheckpointNoSticker"},
        waypoints = {}
    }
