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
