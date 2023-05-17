proc    CalcRayAngle uses bx,\
        wCol, wScreenWidth, wMemPosA, wMemRayAngle

        fild    word[wCol]
        fild    word[wScreenWidth]
        fdivp   st1, st0

        fld     dword[FOV]
        fmulp   st1, st0

        mov     bx, word[wMemPosA]
        fld     dword[bx]
        fld     dword[FOV]
        fld     dword[DIV_2]
        fdivp   st1, st0
        fsubp   st1, st0
        faddp   st1, st0

        mov     bx, word[wMemRayAngle]
        fstp    dword[bx]

        ret

endp

proc    CalcEyeX uses bx,\
        wMemRayAngle, wMemEyeX

        mov     bx, word[wMemRayAngle]
        fld     dword[bx]
        fsin

        mov     bx, word[wMemEyeX]
        fstp    dword[bx]

        ret
endp

proc    CalcEyeY uses bx,\
        wMemRayAngle, wMemEyeY

        mov     bx, word[wMemRayAngle]
        fld     dword[bx]
        fcos

        mov     bx, word[wMemEyeY]
        fstp    dword[bx]

        ret
endp

proc    CalcTestCoordinates uses bx,\
        wMemDist, wMemEye, wMemPos, wMemTestCoord

        mov     bx, word[wMemDist]
        fld     dword[bx]
        mov     bx, word[wMemEye]
        fld     dword[bx]
        fmulp   st1, st0

        mov     bx, word[wMemPos]
        fld     dword[bx]
        faddp   st1, st0

        mov     bx, word[wMemTestCoord]
        fistp   word[bx]

        ret

endp

proc    CalcSymbolOnMap uses bx di,\
        x, y, map_width, wMemMap

        mov     bx, word[wMemMap]
        mov     di, word[y]
        imul    di, word[map_width]
        add     di, word[x]
        add     bx, di
        mov     al, byte[bx]

        ret

endp

proc    SetSymbolOnMap  uses bx di,\
        x, y, map_width, wMemMap, symbol:BYTE

        mov     bx, word[wMemMap]
        mov     di, word[y]
        imul    di, word[map_width]
        add     di, word[x]
        add     bx, di
        mov     al, byte[symbol]
        mov     byte[bx], al

        ret

endp

proc    CalcHeightOfCeiling uses bx,\
        wMemDistance, wScreenHeight, wMemCeiling

        fild    word[wScreenHeight]
        fld     dword[DIV_2]
        fdivp   st1, st0
        fild    word[wScreenHeight]
        mov     bx, word[wMemDistance]
        fld     dword[bx]
        fdivp   st1, st0
        fsubp   st1, st0

        mov     bx, word[wMemCeiling]
        fistp   word[bx]

        ret

endp

proc    CalcHeightOfFloor uses bx,\
        wScreenHeight, wHeightCeiling, wMemFloor

        mov     ax, word[wScreenHeight]
        sub     ax, word[wHeightCeiling]
        mov     bx, word[wMemFloor]
        mov     word[bx], ax

        ret

endp

proc    CalcNormalDistance uses bx,\
        wMemAngleOfDistance, wMemDist

        mov     bx, word[wMemAngleOfDistance]
        fld     dword[bx]

        .Calculate:
                fcos
                mov     bx, word[wMemDist]
                fld     dword[bx]
                fmulp   st1, st0

        .EndProc:
                mov     bx, word[wMemDist]
                fstp    dword[bx]

        ret
endp

