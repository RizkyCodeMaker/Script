-- =====================================================
-- Wonder Chase | Obby Module: MOTD
-- Di-load dinamis oleh Main.lua lewat loadstring(game:HttpGet(...))()
-- Return: table config obby ini
-- =====================================================

return {
        TOTAL_TIME = 140, -- akan di-override random 140-150 saat runOneLap
        SPAWN_Y = 282.1,
        PATH_GAME_START = {"Utility","ObbyColliders","GameStart"},
        PATH_GAME_STOP  = {"Utility","ObbyColliders","GameStop"},
        PATH_PORTAL     = {"Utility","Teleporters","Portal_to_Wc"},
        RANDOM_TIME = {140, 150}, -- override TOTAL_TIME random tiap lap
        waypoints = {
            Vector3.new(554.83, 280.57, 587.45),
            Vector3.new(490.10, 281.74, 610.26),
            Vector3.new(489.48, 281.89, 642.22),
            Vector3.new(502.48, 291.12, 706.01),
            Vector3.new(438.52, 300.59, 728.69),
            Vector3.new(416.17, 302.73, 738.29),
            Vector3.new(368.86, 298.95, 735.79),
            Vector3.new(350.00, 299.26, 745.64),
            Vector3.new(330.52, 298.97, 735.23),
            Vector3.new(297.87, 297.63, 734.53),
            Vector3.new(202.00, 300.82, 724.02),
            Vector3.new(162.71, 300.72, 695.74),
            Vector3.new(145.01, 312.83, 667.96),
            Vector3.new(98.82, 302.22, 636.08),
            Vector3.new(78.30, 281.34, 637.99),
            Vector3.new(28.44, 321.48, 643.17),
            Vector3.new(-115.16, 294.07, 709.38),
            Vector3.new(-116.32, 294.35, 745.61),
            Vector3.new(-132.84, 347.49, 908.45),
            Vector3.new(-129.55, 363.51, 953.88),
            Vector3.new(-71.63, 367.09, 966.31),
            Vector3.new(-48.96, 351.93, 975.99),
            Vector3.new(-15.62, 350.98, 1015.88),
            Vector3.new(11.33, 351.18, 1021.27),
            Vector3.new(76.70, 358.86, 1051.76),
            {pos = Vector3.new(99.54, 397.81, 1050.74), float = true},
            {pos = Vector3.new(124.10, 403.33, 1051.94), float = true},
            Vector3.new(155.62, 371.93, 1060.65),
            Vector3.new(213.51, 370.80, 1062.19),
            Vector3.new(211.43, 371.54, 1170.30),
            Vector3.new(211.85, 377.91, 1227.58),
            Vector3.new(142.34, 363.93, 1309.23),
            Vector3.new(75.95, 381.55, 1312.73),
            Vector3.new(55.23, 365.96, 1358.49),
            Vector3.new(62.45, 365.65, 1424.62),
            Vector3.new(61.54, 421.48, 1628.79),
            Vector3.new(72.72, 420.51, 1664.60),
            Vector3.new(144.03, 421.76, 1708.66),
            Vector3.new(168.24, 445.86, 1707.84),
            Vector3.new(288.63, 431.48, 1709.48),
            Vector3.new(502.14, 433.30, 1716.19),
            Vector3.new(512.21, 430.58, 1776.99),
            Vector3.new(471.81, 430.58, 1802.47),
            Vector3.new(415.80, 428.80, 1820.98),
            Vector3.new(368.60, 429.26, 1893.16),
            Vector3.new(367.81, 433.31, 1925.68),
            Vector3.new(391.09, 433.71, 2463.71),
        }
    }
