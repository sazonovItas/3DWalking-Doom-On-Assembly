proc    Colors.DistanceWallColor uses di si bx,\
        wMemCoefs, wMemWallColors, wMemDist, wMemDepth

locals
        trash   dd ?
endl

        mov     di, word[wMemCoefs]
        mov     ecx, dword[di]
        add     di, 4

        mov     si, word[wMemWallColors]
        inc     si

        jcxz    .EndProc

        mov     bx, word[wMemDist]
        fld     dword[bx] ; st0 = distance
        .loop:
                mov     bx, word[wMemDepth]
                fld     dword[bx] ; st0 = DEPTH, st1 = distance
                fld     dword[di] ; st0 = Coefs[di], st1 = DEPTH, st2 = distance
                fdivp   st1, st0 ; st0 = DEPTH / Coefs[di], st1 = distance
                fcomp   st1
                fstsw   ax
                sahf
                jae     .EndProc

                inc     si
                add     di, 4
                loop    .loop

        .EndProc:
                fstp    dword[trash]
                xor     ax, ax
                mov     al, byte[si]
        ret
endp

proc    Colors.DistanceFloorColor uses di si bx,\
        wHeight, wMemCoefs, wMemFloorColors, wRow

locals
        trash   dd ?
endl

        mov     di, word[wMemCoefs]
        mov     ecx, dword[di]
        add     di, 4

        mov     si, word[wMemFloorColors]
        inc     si

        jcxz    .EndProc

        fld     dword[One]
        fild    word[wHeight]
        fld     dword[DIV_2]
        fdivp   st1, st0
        fild    word[wRow]
        fsub    st0, st1
        fdiv    st0, st1
        fsubp   st2, st0
        fstp    dword[trash]

        .loop:
                fld     dword[di]
                fcomp   st1
                fstsw   ax
                sahf
                jae     .EndProc

                inc     si
                add     di, 4
                loop    .loop


        .EndProc:
                fstp    dword[trash]
                xor     ax, ax
                mov     al, byte[si]

        ret

endp