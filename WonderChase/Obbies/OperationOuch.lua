-- =====================================================
-- Wonder Chase | Obby Module: Operation Ouch!
-- Di-load dinamis oleh Main.lua lewat loadstring(game:HttpGet(...))()
-- Return: table config obby ini
-- =====================================================
-- CATATAN:
-- - SPAWN_Y = 284.0 dan RANDOM_TIME = {200, 210} sudah dikonfirmasi.
-- - Nama folder "Checkpoints" di Zone-2..5 diasumsikan sama polanya dengan
-- Zone-1-Mouth (workspace.Level["Zone-1-Mouth"].Checkpoints). Kalau beda,
-- tinggal ubah path di ZONES di bawah.
-- =====================================================

return {
    TOTAL_TIME = 205, -- fallback, dipakai kalau RANDOM_TIME tidak ada (di sini selalu di-override RANDOM_TIME)
    SPAWN_Y = 284.0,
    PATH_GAME_START = {"Utility","ObbyColliders","GameStart"},
    PATH_GAME_STOP  = {"Utility","ObbyColliders","GameStop"},
    PATH_PORTAL     = {"Utility","Teleporters","Portal_to_Wc"},

    ZONE_SWEEP_MODE = true,
    START_POS = Vector3.new(1826.24, 292.04, 837.31),
    RANDOM_TIME = {200, 210}, -- override TOTAL_TIME random tiap lap
    FLOAT_TAGS = {"Pickup"}, -- float nyala saat menuju item bertag ini, mati untuk tag lain (mis. Checkpoint)
    ALL_PICKUPS_TELEPORT = Vector3.new(3429.32, -82.74, 2255.05), -- teleport sekali setelah semua pickup habis

    -- Hapus semua object bernama "StreamTogether" di bawah workspace.Level
    -- (mencakup semua zona, bukan cuma Zone-1-Mouth)
    DELETE_ITEMS = {
        {scope = {"Level"}, name = "StreamTogether"},
    },

    -- Urutan zona: habiskan checkpoint+pickup satu zona (terdekat dulu),
    -- baru lanjut ke zona berikutnya.
    ZONES = {
        {
            name = "Zone-1-Mouth",
            folders = {
                {path = {"PickupSlots", "1-Mouth"}, tag = "Pickup"},
                {path = {"Level", "Zone-1-Mouth", "Checkpoints"}, tag = "Checkpoint"},
            }
        },
        {
            name = "Zone-2-Lungs",
            folders = {
                {path = {"PickupSlots", "2-Lungs"}, tag = "Pickup"},
                {path = {"Level", "Zone-2-Lungs", "Checkpoints"}, tag = "Checkpoint"},
            }
        },
        {
            name = "Zone-3-Heart",
            folders = {
                {path = {"PickupSlots", "3-Heart"}, tag = "Pickup"},
                {path = {"Level", "Zone-3-Heart", "Checkpoints"}, tag = "Checkpoint"},
            }
        },
        {
            name = "Zone-4-Stomach",
            folders = {
                {path = {"PickupSlots", "4-Stomach"}, tag = "Pickup"},
                {path = {"Level", "Zone-4-Stomach", "Checkpoints"}, tag = "Checkpoint"},
            }
        },
        {
            name = "Zone-5-Intestine",
            folders = {
                {path = {"PickupSlots", "5-Intestine"}, tag = "Pickup"},
                {path = {"Level", "Zone-5-Intestines", "Checkpoints"}, tag = "Checkpoint"},
            }
        },
    },
}
