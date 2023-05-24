Levels          dw Level1

; ======= Level1 =========
Level1          dw map_height1, map_width1, MAP1, pos_x1, pos_y1, pos_a1,\
                   WallCoefs1, WallColors1, ExitCoefs1, ExitColors1, FloorCoefs1, FloorColors1, SkyColor1,\
                   song1

pos_x1          dd 1.0
pos_y1          dd 1.0
pos_a1          dd 0.7

map_height1     dw 30
map_width1      dw 30
MAP1 db "##############################"
     db "#..#.........................#"
     db "#.......#...#.#.#....#....#..#"
     db "#....#.....#.................#"
     db "#..#...,....#...#.......#....#"
     db "#......*............#........#"
     db "#.....#.....#...#............#"
     db "#............*........#...#..#"
     db "#......#....#....#...........#"
     db "#..#......#...........#...#..#"
     db "#.......#...#......#.........#"
     db "#................#......#....#"
     db "#.*.....##...................#"
     db "#...........*.#....#..#......#"
     db "#.#..#...#......#.........#..#"
     db "#..#.....#....#.......#......#"
     db "#...............#.#....#..#..#"
     db "#..#.....#....#...#..........#"
     db "#...............#.........#..#"
     db "##############################"

; Wall
WallCoefs1       dd 4, 5.0, 4.0, 3.0, 2.0
WallColors1      db 5, WALL_COLOR_1, WALL_COLOR_2, WALL_COLOR_3, WALL_COLOR_4, WALL_COLOR_5

; Exit
ExitCoefs1       dd 4, 5.0, 4.0, 3.0, 2.0
ExitColors1      db 5, EXIT_COLOR_1, EXIT_COLOR_2, EXIT_COLOR_3, EXIT_COLOR_4, EXIT_COLOR_5

; Floor
FloorCoefs1      dd 3, 0.25, 0.5, 0.75
FloorColors1     db 4, FLOOR_COLOR_1, FLOOR_COLOR_2, FLOOR_COLOR_3, FLOOR_COLOR_4

SkyColor1        db SKY_COLOR

song1:
    dw 0, 16 * pause
    dw 0, half_note
    dw d3, quarter_note
    dw f3, quarter_note, g3, quarter_note_dot , 0, eighth_note, d3, quarter_note, f3, quarter_note
    dw gis3, eighth_note, g3, quarter_note, 0, quarter_note
    dw d3, quarter_note, f3, quarter_note, g3, quarter_note_dot,  f3, quarter_note
    dw d3, quarter_note_dot
    dw MUSIC_END
