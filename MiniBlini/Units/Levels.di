Levels          dw Level1, Level2, Level3

; ======= Level1 =========
Level1          dw map_height1, map_width1, MAP1, pos_x1, pos_y1, pos_a1,\
                   WallCoefs1, WallColors1, ExitCoefs1, ExitColors1, FloorCoefs1, FloorColors1, SkyColor1,\
                   song1

pos_x1          dd 1.0
pos_y1          dd 1.0
pos_a1          dd 0.7

map_height1     dw 20
map_width1      dw 20
MAP1 db "####################"
     db "#..#...............#"
     db "#....#..#...#.#.#..#"
     db "#.#..#.....#.......#"
     db "#..#...#....#...#..#"
     db "#......*...........#"
     db "#..#.##..##.#...#..#"
     db "#............*.....#"
     db "#..#.#.#...##......#"
     db "#....#....#....##..#"
     db "#..##..##.#.#......#"
     db "#..................#"
     db "#.*.##..##.##......#"
     db "#...........*.##...#"
     db "#.#..#.###......#.##"
     db "#..#.....#.#..#....#"
     db "#.....##...#....#.##"
     db "#..#.##..##.#.#...##"
     db "#...............#..#"
     db "####################"

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
    dw f3, quarter_note, g3, quarter_note, d3, quarter_note, f3, quarter_note
    dw gis3, eighth_note, g3, eighth_note, 0, half_note
    dw d3, quarter_note, f3, quarter_note, g3, quarter_note, f3, quarter_note
    dw d3, quarter_note
    dw MUSIC_END

; ========= Level2 ===========

Level2          dw map_height2, map_width2, MAP2, pos_x2, pos_y2, pos_a2,\
                   WallCoefs2, WallColors2, ExitCoefs2, ExitColors2, FloorCoefs2, FloorColors2, SkyColor2,\
                   song2

pos_x2          dd 1.0
pos_y2          dd 1.0
pos_a2          dd 0.7

map_height2     dw 25
map_width2     dw 25
MAP2 db "#########################"
     db "#..#....................#"
     db "#....#..#...#.#.#.#.....#"
     db "#.#..#.....#.........#..#"
     db "#..#...#....#...#.#.....#"
     db "#....................#..#"
     db "#..#.##..##.#...#.#.....#"
     db "#...............#...#...#"
     db "#..#.......##...........#"
     db "#..............##..#....#"
     db "#..##..##.#.#...........#"
     db "#...............#...#...#"
     db "#...##..##.##...........#"
     db "#.............##....#...#"
     db "#.......##......#.#.....#"
     db "#....................#..#"
     db "#.....##........#.#.....#"
     db "#..####..##.#.#.....#...#"
     db "#........#........#....#"
     db "#.............#......#..#"
     db "#.#...#...#.#....#......#"
     db "#..#.......#.#.......#..#"
     db "#......#.......#...#....#"
     db "#....#......#...#.......#"
     db "#######################*#"

; Wall
WallCoefs2       dd 4, 5.0, 4.0, 3.0, 2.0
WallColors2      db 5, WALL_COLOR_21, WALL_COLOR_22, WALL_COLOR_23, WALL_COLOR_24, WALL_COLOR_25

; Exit
ExitCoefs2       dd 4, 5.0, 4.0, 3.0, 2.0
ExitColors2      db 5, EXIT_COLOR_21, EXIT_COLOR_22, EXIT_COLOR_23, EXIT_COLOR_24, EXIT_COLOR_25

; Floor
FloorCoefs2      dd 3, 0.25, 0.5, 0.75
FloorColors2     db 4, FLOOR_COLOR_21, FLOOR_COLOR_22, FLOOR_COLOR_23, FLOOR_COLOR_24

SkyColor2        db SKY_COLOR2

song2:
    dw 0, 16 * pause
    dw g3,quarter_note
    dw c4,quarter_note_dot,b3,eighth_note,c4,quarter_note,e4,quarter_note
    dw d4,quarter_note_dot,c4,eighth_note,d4,quarter_note,e4,eighth_note,d4,eighth_note
    dw c4,quarter_note,0,pause,c4,quarter_note,e4,quarter_note,g4,quarter_note
    dw a4,half_note_dot,0,pause,a4,quarter_note
    dw g4,quarter_note_dot,e4,eighth_note,0,pause,e4,quarter_note,c4,quarter_note
    dw d4,quarter_note_dot,c4,eighth_note,d4,quarter_note,e4,eighth_note,d4,eighth_note
    dw c4,quarter_note_dot,a3,eighth_note,0,pause,a3,quarter_note,g3,quarter_note
    dw c4,half_note_dot,0,quarter_note,a4,quarter_note
    dw g4,quarter_note_dot,e4,eighth_note,0,pause,e4,quarter_note,c4,quarter_note
    dw d4,quarter_note_dot,c4,eighth_note,d4,quarter_note,a4,quarter_note
    dw g4,quarter_note_dot,e4,eighth_note,0,pause,e4,quarter_note,g4,quarter_note
    dw a4,half_note_dot,0,pause,a4,quarter_note
    dw g4,quarter_note_dot,e4,eighth_note,0,pause,e4,quarter_note,c4,quarter_note
    dw d4,quarter_note_dot,c4,eighth_note,d4,quarter_note,e4,eighth_note,d4,eighth_note
    dw c4,quarter_note_dot,a3,eighth_note,0,pause,a3,quarter_note,g3,quarter_note
    dw c4,half_note_dot
    dw MUSIC_END

; ========= Level3 ===========

Level3          dw map_height3, map_width3, MAP3, pos_x3, pos_y3, pos_a3,\
                   WallCoefs3, WallColors3, ExitCoefs3, ExitColors3, FloorCoefs3, FloorColors3, SkyColor3,\
                   song3

pos_x3          dd 1.0
pos_y3          dd 1.0
pos_a3          dd 0.0

map_height3     dw 25
map_width3     dw 25
MAP3 db "#########################"
     db "#..#....................#"
     db "#....#..#...#.#.#.#.....#"
     db "#.#..#.....#.........#..#"
     db "#..#...#....#...#.#.....#"
     db "#....................#..#"
     db "#..#.##..##.#...#.#.....#"
     db "#...............#...#...#"
     db "#..#.......##...........#"
     db "#..............##..#....#"
     db "#..##..##.#.#...........#"
     db "#...............#...#...#"
     db "#...##..##.##...........#"
     db "#.............##....#...#"
     db "#.......##......#.#.....#"
     db "#....................#..#"
     db "#.....##........#.#.....#"
     db "#..####..##.#.#.....#...#"
     db "#........#........#....#"
     db "#.............#......#..#"
     db "#.#...#...#.#....#......#"
     db "#..#.......#.#.......#..#"
     db "#......#.......#...#....#"
     db "#....#......#...#.......#"
     db "#######################*#"

; Wall
WallCoefs3       dd 4, 5.0, 4.0, 3.0, 2.0
WallColors3      db 5, WALL_COLOR_21, WALL_COLOR_22, WALL_COLOR_23, WALL_COLOR_24, WALL_COLOR_25

; Exit
ExitCoefs3       dd 4, 5.0, 4.0, 3.0, 2.0
ExitColors3      db 5, EXIT_COLOR_21, EXIT_COLOR_22, EXIT_COLOR_23, EXIT_COLOR_24, EXIT_COLOR_25

; Floor
FloorCoefs3      dd 3, 0.25, 0.5, 0.75
FloorColors3     db 4, FLOOR_COLOR_21, FLOOR_COLOR_22, FLOOR_COLOR_23, FLOOR_COLOR_24

SkyColor3        db SKY_COLOR2

song3:
    dw 0, 6 * pause
    dw g3,quarter_note
    dw c4,quarter_note_dot,b3,eighth_note,c4,quarter_note,e4,quarter_note
    dw d4,quarter_note_dot,c4,eighth_note,d4,quarter_note,e4,eighth_note,d4,eighth_note
    dw c4,quarter_note,0,pause,c4,quarter_note,e4,quarter_note,g4,quarter_note
    dw a4,half_note_dot,0,pause,a4,quarter_note
    dw g4,quarter_note_dot,e4,eighth_note,0,pause,e4,quarter_note,c4,quarter_note
    dw d4,quarter_note_dot,c4,eighth_note,d4,quarter_note,e4,eighth_note,d4,eighth_note
    dw c4,quarter_note_dot,a3,eighth_note,0,pause,a3,quarter_note,g3,quarter_note
    dw c4,half_note_dot,0,quarter_note,a4,quarter_note
    dw g4,quarter_note_dot,e4,eighth_note,0,pause,e4,quarter_note,c4,quarter_note
    dw d4,quarter_note_dot,c4,eighth_note,d4,quarter_note,a4,quarter_note
    dw g4,quarter_note_dot,e4,eighth_note,0,pause,e4,quarter_note,g4,quarter_note
    dw a4,half_note_dot,0,pause,a4,quarter_note
    dw g4,quarter_note_dot,e4,eighth_note,0,pause,e4,quarter_note,c4,quarter_note
    dw d4,quarter_note_dot,c4,eighth_note,d4,quarter_note,e4,eighth_note,d4,eighth_note
    dw c4,quarter_note_dot,a3,eighth_note,0,pause,a3,quarter_note,g3,quarter_note
    dw c4,half_note_dot
    dw MUSIC_END