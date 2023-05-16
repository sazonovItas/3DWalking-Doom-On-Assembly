        include 'macro/proc16.inc'

        include "Units/Keyboard.h"
        include "Units/Colors.h"
        include "Units/Levels.h"
        include "Units/Music.h"

; Useful things
nil      = 0
FALSE    = 0
TRUE     = 1

; Keybord keys
KEY_ESC         = 1
KEY_UP          = 72
KEY_DOWN        = 80
KEY_TURN_LEFT   = 75
KEY_TURN_RIGHT  = 77

        org 100h

EntryPoint:

        mov     ax, cs
        add     ax, 1000h
        mov     word[Buffer], ax
        stdcall StartWalking, 0
        stdcall Keyboard.ReadKey

        ret

WIDTH   = 320
HEIGHT  = 200

; Game symbols
WALL    = '#'
EXIT    = '*'
SPACE   = '.'

proc    DrawOneLine uses es si di bx,\
        wWidth, wHeight, wColumn, wCeiling, wFloor, bSymbol

        push    word[Buffer]
        pop     es

        mov     di, word[wColumn]
        xor     si, si

        .DrawLoop:

                cmp     si, word[wCeiling]
                jle     .Sky

                cmp     si, word[wFloor]
                jle     .WallType

                jmp     .Floor

                .Sky:
                        mov     al, byte[SkyColor]
                        mov     byte[es:di], al
                        jmp     .continue

                .WallType:

                        mov     bx, word[bSymbol]
                        mov     al, byte[bx]
                        cmp     al, EXIT
                        je      .Exit

                        .Wall:
                                stdcall Colors.DistanceWallColor, word[WallCoefs], word[WallColors], OtherDistance, DEPTH
                                jmp     .Draw
                        .Exit:
                                stdcall Colors.DistanceWallColor, word[ExitCoefs], word[ExitColors], OtherDistance, DEPTH
                        .Draw:
                                mov     byte[es:di], al
                                jmp     .continue

                .Floor:
                        stdcall Colors.DistanceFloorColor, HEIGHT, word[FloorCoefs], word[FloorColors], si
                        mov     byte[es:di], al

        .continue:
                add     di, word[wWidth]
                inc     si
                cmp     si, word[wHeight]
                jb      .DrawLoop

        ret
endp

proc    DrawBerryLine uses es si di bx,\
        wWidth, wHeight, wColumn, wCeiling, wFloor, bSymbol

        push    word[Buffer]
        pop     es

        mov     di, word[wColumn]
        xor     si, si

        .DrawLoop:

                cmp     si, word[wCeiling]
                jle     .Sky

                cmp     si, word[wFloor]
                jle     .WallType

                jmp     .Floor

                .Sky:
                        jmp     .continue

                .WallType:

                        mov     bx, word[bSymbol]
                        mov     al, byte[bx]
                        cmp     al, EXIT
                        je      .Exit

                        .Wall:
                                stdcall Colors.DistanceWallColor, word[WallCoefs], word[WallColors], OtherDistance, DEPTH
                                jmp     .Draw
                        .Exit:
                                stdcall Colors.DistanceWallColor, word[ExitCoefs], word[ExitColors], OtherDistance, DEPTH
                        .Draw:
                                mov     byte[es:di], al
                                jmp     .continue

                .Floor:

        .continue:
                add     di, word[wWidth]
                inc     si
                cmp     si, word[wHeight]
                jb      .DrawLoop

        ret
endp

; Use
;       ax, dx
proc    Renderingkeyboard uses es di si bx

        .Music:

                push    40h
                pop     es
                mov     eax, [es:6ch]

                cmp     dword[MusicTime], eax
                ja      .PlayMusic

                ; Some interesting
                mov     ax, word[AddK]
                cmp     word[AddVar], -10
                jle     .nxt

                cmp     word[AddVar], 10
                jge     .nxt

                add     word[AddVar], ax
                jmp     .end

                .nxt:
                        cmp     ax, 10
                        je     .lower

                .greater:
                        mov     word[AddK], 10
                        add     word[AddVar], 10
                        jmp     .end

                .lower:
                        dec     word[AddVar]
                        add     word[AddVar], -10
                        mov     word[AddK], -10

                .end:



                add     word[Note], 4
                mov     di, word[Note]
                cmp     word[di], 1
                jne     .next

                mov     si, word[Music]
                add     si, 4
                mov     word[Note], si
                mov     di, si

                .next:

                stdcall delay, word[di + 2], MusicTime

                .PlayMusic:
                        mov     di, word[Note]
                        stdcall PlaySound, word[di]

        Rendering_keyboard:

        mov ah, 01h
        int 16h
        jz .to_end

        mov ah, 00h
        int 16h

        cmp ah, KEY_ESC
        je .Escape_Key

        cmp ah, KEY_UP
        je .go_forward

        cmp ah, KEY_DOWN
        je .go_backward

        cmp ah, KEY_TURN_LEFT
        je .turn_left

        cmp ah, KEY_TURN_RIGHT
        je .turn_right

        jmp .to_end
        .go_forward:
                fld dword[SPEED] ; st0 = SPEED
                fld dword[pos_a] ; st0 = pos_a, st1 = SPEED
                fsin ; st0 = sin(pos_a), st1 = SPEED
                fmulp st1, st0 ; st0 = sin(pos_a) * SPEED
                fstp dword[delta_x]

                fld dword[SPEED] ; st0 = SPEED
                fld dword[pos_a] ; st0 = pos_a, st1 = SPEED
                fcos ; st0 = cos(pos_a), st1 = SPEED
                fmulp st1, st0 ; st0 = cos(pos_a) * SPEED
                fstp dword[delta_y]

                fld dword[pos_x]
                fld dword[delta_x]
                faddp st1, st0
                fstp dword[pos_x]

                fld dword[pos_y]
                fld dword[delta_y]
                faddp st1, st0
                fstp dword[pos_y]

                fld dword[pos_x]
                fistp word[test_x]

                fld dword[pos_y]
                fistp word[test_y]

                stdcall CalcSymbolOnMap, word[test_x], word[test_y], word[map_width], word[MAP]
                cmp al, '*'
                jne @F

                .GoOutOfLabirint:
                        mov byte[is_game_over], TRUE

                @@:

                cmp al, '#'
                jne .notForward

                fld dword[pos_x] ; st0 = pos_x
                fld dword[delta_x] ; st0 = delta_x, st1 = pos_x
                fsubp st1, st0 ; st0 = pos_x - delta_x
                fstp dword[pos_x]

                fld dword[pos_y] ; st0 = pos_y
                fld dword[delta_y] ; st0 = delta_y, st1 = pos_y
                fsubp st1, st0 ; st0 = pos_y - delta_y
                fstp dword[pos_y]

                .notForward:
                jmp Rendering_keyboard

        .go_backward:
                fld dword[SPEED] ; st0 = SPEED
                fld dword[pos_a] ; st0 = pos_a, st1 = SPEED
                fsin ; st0 = sin(pos_a), st1 = SPEED
                fmulp st1, st0 ; st0 = sin(pos_a) * SPEED
                fstp dword[delta_x]

                fld dword[SPEED] ; st0 = SPEED
                fld dword[pos_a] ; st0 = pos_a, st1 = SPEED
                fcos ; st0 = cos(pos_a), st1 = SPEED
                fmulp st1, st0 ; st0 = cos(pos_a) * SPEED
                fstp dword[delta_y]

                fld dword[pos_x]
                fld dword[delta_x]
                fsubp st1, st0
                fstp dword[pos_x]

                fld dword[pos_y]
                fld dword[delta_y]
                fsubp st1, st0
                fstp dword[pos_y]

                fld dword[pos_x]
                fistp word[test_x]

                fld dword[pos_y]
                fistp word[test_y]

                stdcall CalcSymbolOnMap, word[test_x], word[test_y], word[map_width], word[MAP]
                cmp al, '*'
                jne @F

                .GoOutOfLabirintB:
                        mov byte[is_game_over], TRUE

                @@:

                cmp al, '#'
                jne .notBackward

                fld dword[pos_x] ; st0 = pos_x
                fld dword[delta_x] ; st0 = delta_x, st1 = pos_x
                faddp st1, st0 ; st0 = pos_x - delta_x
                fstp dword[pos_x]

                fld dword[pos_y] ; st0 = pos_y
                fld dword[delta_y] ; st0 = delta_y, st1 = pos_y
                faddp st1, st0 ; st0 = pos_y - delta_y
                fstp dword[pos_y]

                .notBackward:
                        jmp Rendering_keyboard

        .turn_left:
                fld dword[pos_a]
                fld dword[ROTATION_SPEED] ;  st0 = ROTATION_SPEED,st1=pos_a

                fsubp st1,st0
                fstp dword[pos_a]
                jmp Rendering_keyboard
        .turn_right:
                fld dword[pos_a]
                fld dword[ROTATION_SPEED] ;  st0 = ROTATION_SPEED,st1=pos_a

                faddp st1,st0
                fstp dword[pos_a]
                jmp Rendering_keyboard

        .Escape_Key:
                mov     byte[is_game_over], TRUE
                mov     byte[level], 3
                jmp     Rendering_keyboard

        .to_end:
                ret
endp

proc    StartWalking uses di si bx,\
        bStartLevel: BYTE

        .StartSystemSettings:
                mov     al, 13h
                mov     ah, 00h
                stdcall Screen.SetMode, ax
                mov     bx, ax

                finit
                FNSTCW  word[TRASH]
                or      [TRASH], 00001100_00000000b
                FLDCW   word[TRASH]

                push    word[bStartLevel]
                pop     word[level]

        .StartGameSettings:

                mov     di, Levels
                add     di, word[level]
                add     di, word[level]
                mov     di, word[di]

                mov     si, word[di]
                mov     si, word[si]
                mov     word[map_height], si

                mov     si, word[di + 2]
                mov     si, word[si]
                mov     word[map_width], si

                push    word[di + 4]
                pop     word[MAP]

                mov     si, word[di + 6]
                mov     esi, dword[si]
                mov     dword[pos_x], esi

                mov     si, word[di + 8]
                mov     esi, dword[si]
                mov     dword[pos_y], esi

                mov     si, word[di + 10]
                mov     esi, dword[si]
                mov     dword[pos_a], esi

                mov     si, word[di + 12]
                mov     word[WallCoefs], si
                mov     si, word[di + 14]
                mov     word[WallColors], si

                mov     si, word[di + 16]
                mov     word[ExitCoefs], si
                mov     si, word[di + 18]
                mov     word[ExitColors], si

                mov     si, word[di + 20]
                mov     word[FloorCoefs], si
                mov     si, word[di + 22]
                mov     word[FloorColors], si

                mov     si, word[di + 24]
                mov     al, byte[si]
                mov     byte[SkyColor], al

                mov     si, word[di + 26]
                mov     word[Music], si

                mov     di, word[Music]
                mov     word[Note], di
                stdcall delay, word[di + 2], MusicTime

                mov     byte[is_game_over], FALSE

        .MainLoop:

                fld     dword[Minus1]
                fld     dword[FOV]
                fld     dword[DIV_2]
                fdivp   st1, st0
                fmulp   st1, st0
                fstp    dword[angleOfDistance]

                mov     word[col], 0

                .ColDrawLoop:

                        stdcall CalcRayAngle, word[col], WIDTH, pos_a, ray_angle
                        stdcall CalcEyeX, ray_angle, eye_x
                        stdcall CalcEyeY, ray_angle, eye_y

                        mov     dword[distance], 0.0
                        fld     dword[RESOLUTION]
                        fld     dword[DEPTH]
                        fld     dword[distance]

                        mov     byte[symbol], '.'
                        mov     byte[bSymbol], '.'

                        .loopDistanceToWall:

                                fadd    st0, st2
                                fst     dword[distance]

                                stdcall CalcTestCoordinates, distance, eye_x, pos_x, test_x
                                stdcall CalcTestCoordinates, distance, eye_y, pos_y, test_y
                                stdcall CalcSymbolOnMap, word[test_x], word[test_y], word[map_width], word[MAP]
                                mov byte[symbol], al

                                cmp     al, WALL
                                je      .FindTheWall

                                cmp     al, EXIT
                                jne     .nextLoopDist

                                cmp     byte[bSymbol], EXIT
                                je     .nextLoopDist

                                .Berry:
                                        mov     byte[bSymbol], EXIT
                                        fst     dword[berryDistance]

                        .nextLoopDist:
                                fcom    st1
                                fstsw   ax
                                sahf
                                jb      .loopDistanceToWall

                        .FindTheWall:
                                fstp    dword[TRASH]
                                fstp    dword[TRASH]
                                fstp    dword[TRASH]

                        fld     dword[distance]
                        fstp    dword[OtherDistance]
                        stdcall CalcNormalDistance, angleOfDistance, distance
                        stdcall CalcHeightOfCeiling, distance, HEIGHT, ceiling
                        stdcall CalcHeightOfFloor, HEIGHT, word[ceiling], floor

                        stdcall DrawOneLine, WIDTH, HEIGHT, word[col], word[ceiling], word[floor], symbol

                        fld     dword[berryDistance]
                        fstp    dword[OtherDistance]
                        stdcall CalcNormalDistance, angleOfDistance, berryDistance
                        stdcall CalcHeightOfCeiling, berryDistance, HEIGHT, ceiling
                        stdcall CalcHeightOfFloor, HEIGHT, word[ceiling], floor

                        mov     ax, word[floor]
                        sub     ax, word[ceiling]
                        shr     ax, 2

                        mov     dx, word[AddVar]

                        add     word[ceiling], ax
                        add     word[ceiling], dx
                        sub     word[floor], ax
                        add     word[floor], dx

                        cmp     byte[bSymbol], EXIT
                        jne     .nextCol

                        stdcall DrawBerryLine, WIDTH, HEIGHT, word[col], word[ceiling], word[floor], bSymbol

                .nextCol:
                        fld     dword[angleOfDistance]
                        fld     dword[delta_angleOfDistance]
                        faddp   st1, st0
                        fstp    dword[angleOfDistance]
                        inc     word[col]
                        cmp     word[col], WIDTH
                        jb     .ColDrawLoop

        push    ds es

        mov     ds, word[Buffer]
        push    $A000
        pop     es
        mov     cx, 64000
        xor     si, si
        xor     di, di
        rep     movsb

        pop     es ds

        stdcall Renderingkeyboard

        .continue:
                cmp     byte[is_game_over], FALSE
                je      .MainLoop

        inc     word[level]
        cmp     word[level], 3
        jb      .StartGameSettings

        .EndProc:
                stdcall StopSound
                stdcall Screen.SetMode, bx

        ret
endp

        include "Units/Keyboard.ñ"
        include "Units/Colors.c"
        include "Units/Screen.c"
        include "Units/Mathimatica.c"
        include "Units/Music.c"

; =========== Data =============

        include "Units/Colors.di"
        include "Units/Colors.du"
        include "Units/Mathimatica.di"
        include "Units/Levels.di"

; float CONSTANTS
RESOLUTION              dd 0.01
DEPTH                   dd 16.0
SPEED                   dd 0.1
ROTATION_SPEED          dd 0.07
ScreenWidth             dd 320.0
ScreenHeight            dd 200.0

; Game variables
pos_x                   dd ?
pos_y                   dd ?
pos_a                   dd ?

col                     dw ?
angleOfDistance         dd ?
ray_angle               dd ?
eye_x                   dd ?
eye_y                   dd ?
distance                dd ?
berryDistance           dd ?
OtherDistance           dd ?
lengthOfDistance        dd ?
delta_x                 dd ?
delta_y                 dd ?

test_x                  dw ?
test_y                  dw ?
ceiling                 dw ?
floor                   dw ?
FloorColor              dw ?
WallColor               dw ?
AddVar                  dw 0
AddK                    dw 5

symbol                  db ?
bSymbol                 db ?
level                   dw ?
is_game_over            db ?

Music                   dw ?
Note                    dw ?
MusicTime               dd ?

; Our map
map_height              dw ?
map_width               dw ?
MAP                     dw ?

; Wall
WallCoefs               dw ?
WallColors              dw ?

; Exit
ExitCoefs               dw ?
ExitColors              dw ?

; Floor
FloorCoefs              dw ?
FloorColors             dw ?

; SKY
SkyColor                db ?

; Double Buffer
Buffer                  dw ?
