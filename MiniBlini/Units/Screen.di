MOD10 dw 10

; Numbers
Number0:
        db 00000000b
        db 00111100b
        db 01000010b
        db 01000010b
        db 01000010b
        db 01000010b
        db 00111100b
        db 00000000b

Number1:
        db 00000000b
        db 00000010b
        db 00000110b
        db 00001010b
        db 00010010b
        db 00000010b
        db 00000010b
        db 00000000b

Number2:
        db 00000000b
        db 00111100b
        db 01000010b
        db 00000010b
        db 00111100b
        db 01000000b
        db 00111110b
        db 00000000b

Number3:
        db 00000000b
        db 00111100b
        db 01000010b
        db 00011100b
        db 00000010b
        db 01000010b
        db 00111100b
        db 00000000b

Number4:
        db 00000000b
        db 00001010b
        db 00010010b
        db 00100010b
        db 01111110b
        db 00000010b
        db 00000010b
        db 00000000b

Number5:
        db 00000000b
        db 00111110b
        db 01000000b
        db 01000000b
        db 00111100b
        db 00000010b
        db 01111100b
        db 00000000b

Number6:
        db 00000000b
        db 00111100b
        db 01000010b
        db 01000000b
        db 01111100b
        db 01000010b
        db 00111100b
        db 00000000b

Number7:
        db 00000000b
        db 01111110b
        db 00000110b
        db 00001100b
        db 00011000b
        db 00110000b
        db 01100000b
        db 00000000b

Number8:
        db 00000000b
        db 00111100b
        db 01000010b
        db 00111100b
        db 01000010b
        db 01000010b
        db 00111100b
        db 00000000b

Number9:
        db 00000000b
        db 00111100b
        db 01000010b
        db 00111110b
        db 00000010b
        db 01000010b
        db 00111100b
        db 00000000b

NumbersInGraphics:
        dw Number0, Number1, Number2, Number3, Number4, Number5, Number6, Number7, Number8, Number9

Berry:
        db 0001_1000b
        db 0011_1100b
        db 0111_1110b
        db 0111_1110b
        db 1111_1111b
        db 1111_1111b
        db 0111_1110b
        db 0111_1110b
        db 0011_1100b
        db 0001_1000b