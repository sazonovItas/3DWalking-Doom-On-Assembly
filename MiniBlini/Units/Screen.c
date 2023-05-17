proc    Screen.SetMode uses bx si di,\
        wModeInfo

        mov     ah, $0F
        int     10h
        mov     dl, al
        mov     dh, bh

        movzx   ax, byte[wModeInfo]
        int     10h
        mov     ah, $05
        mov     al, byte[wModeInfo + 1]
        int     10h

        xchg    ax, dx
        ret
endp

Screen.apfnClear        dw      nil, nil, nil, Screen.Clear_03h,\
                                nil, nil, nil, nil,\
                                nil, nil, nil, nil,\
                                nil, nil, nil, nil,\
                                nil, nil, nil, Screen.Clear_13h
Screen.apfnClear.Length = ($ - Screen.apfnClear) / 2

proc    Screen.Clear uses bx

        mov     ah, $OF
        int     10h
        movzx   bx, al

        cmp     bx, Screen.apfnClear.Length
        jae     .EndProc

        shl     bx, 1
        mov     cx, [Screen.apfnClear + bx]
        jcxz    .EndProc
        stdcall cx

        .EndProc:
                ret
endp

proc    Screen.Clear_03h uses es di

        push    $B800
        pop     es
        xor     ax, ax
        mov     cx, 80 * 25
        xor     di, di
        rep stosw
        ret

endp

proc    Screen.Clear_13h uses es di

        push    $A000
        pop     es
        xor     di, di
        mov     cx, 320 * 200 / 2
        xor     ax, ax
        rep stosw
        ret

endp

proc    Screen.WriteString uses es si di,\
        ofsText, nLine, alAlign, bAttr: BYTE

        push    $B800
        pop     es

        imul    si, [nLine], 80
        mov     si, [ofsText]
        lodsb
        movzx   cx, al
        jcxz    .EndProc

        cmp     [alAlign], alLeft
        je      .WriteString

        mov     ax, 80
        sub     ax, cx

        cmp     [alAlign], alRight
        je      @F
        shr     ax, 1

        @@:
                add     di, ax

        .WriteString:
                shl     di, 1
                mov     ah, [bAttr]
        .WriteLoop:
                lodsb
                stosw
                loop    .WriteLoop

        .EndProc:
                ret

endp

proc    Screen.DrawPixelPict uses bx di es cx,\
        wRow, wCol, wBuffer, bClr:BYTE

        push    word[wBuffer]
        pop     es

        mov     di, word[wCol]
        mov     cx, word[wRow]
        jcxz    .EndProc
        .stupidLoop:
                add     di, WIDTH
                loop    .stupidLoop

        .EndProc:
                mov     ah, byte[bClr]
                mov     byte[es:di], ah

        ret

endp

proc    Screen.DrawBitPicture uses cx bx di si es,\
        wMemPicture, wHeight, wRow, wCol, wBuffer, bClearClr:BYTE, bPictClr:BYTE

        mov     di, word[wRow]
        mov     si, word[wCol]
        mov     bx, word[wMemPicture]

        mov     cx, word[wHeight]
        jcxz    .EndProc
        .loopForRow:

                push    cx
                mov     cx, 8
                mov     dl, byte[bx]
                mov     al, 1000_0000b
                push    si

                .loopForCol:

                        test    dl, al
                        jz      .EmptyPixel

                        stdcall Screen.DrawPixelPict, di, si, word[wBuffer], word[bPictClr]
                        jmp     .continue

                        .EmptyPixel:
                                stdcall Screen.DrawPixelPict, di, si, word[wBuffer], word[bClearClr]

                        .continue:
                                inc     si
                                shr     al, 1

                        loop    .loopForCol

                pop     si
                pop     cx
                inc     bx
                inc     di

                loop .loopForRow

        .EndProc:

        ret
endp

proc    Screen.DrawNumberOnScreen uses bx si di,\
        wNumber, wBuffer, wRow, wCol, bPictClr:BYTE, bEmptyClr:BYTE

        mov     ax, word[wNumber]
        xor     cx, cx
        mov     bx, 10

        .loop1:
                xor     dx, dx
                div     bx
                push    dx
                inc     cx
                test    ax, ax
                jnz     .loop1

                mov     bx, NumbersInGraphics
                jcxz    .EndProc
        .loop2:
                pop     dx
                push    bx
                add     bx, dx
                add     bx, dx
                stdcall Screen.DrawBitPicture, word[bx], 8, word[wRow], word[wCol], word[wBuffer], word[bPictClr], word[bEmptyClr]
                pop     bx

                add     word[wCol], 8
                loop    .loop2

    .EndProc:

        ret
endp

proc    Screen.DrawVerticalLine uses es si di cx,\
        wWidth, wHeight, wColumn, wStartRow, wEndRow, bColor: BYTE

        ; Проверка на корректность ввода данных
        mov     di, word[wStartRow]
        cmp     di, word[wHeight]
        jge    .EndProc
        cmp     di, 0
        jg      @F
        mov     word[wStartRow], 0

        @@:

        mov     si, word[wEndRow]
        cmp     si, 0
        jl      .EndProc
        cmp     si, word[wHeight]
        jl      @F
        mov     word[wEndRow], 199

        @@:

        mov     di, word[wStartRow]
        mov     si, word[wEndRow]
        cmp     di, si
        ja      .EndProc

        mov     si, word[wColumn]
        cmp     si, word[wWidth]
        jae     .EndProc
        cmp     si, 0
        jl      .EndProc
        ; Конец проверки на ввод

        xor     di, di
        mov     cx, word[wStartRow]
        jcxz    @F
        .stupidLoop:
                add     di, word[wWidth]
                loop    .stupidLoop

        @@:

        add     di, word[wColumn]

        mov     cx, word[wEndRow]
        sub     cx, word[wStartRow]
        inc     cx

        push    $A000
        pop     es

        mov     al, byte[bColor]

        .drawLoop:
                mov     byte[es:di], al
                add     di, word[wWidth]
                loop    .drawLoop

        .EndProc:
                ret

endp
