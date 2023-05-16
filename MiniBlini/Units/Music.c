proc StopSound
      in al,61h
      and al, 11111100b       ; menutup soundcard (invers dari akses soundcard)
      out 61h, al
      ret
endp

proc    PlaySound uses ax,\
        Tone

        in      al, 61h
        or      al, 00000011b          ; mengakses soundcard
        out     61h, al                 ; mengirim control word untuk ganti frekuensi
        mov     al, 0B6h
        out     43h, al
        mov     ax, word[Tone]
        out     42h, al               ; mengirim lower byte
        mov     al, ah
        out     42h, al               ; mengirim upper  byte
        pop     ax

     ret
endp

proc    delay uses bx si,\
        Time, dwMemTime

        locals
                tick    dd ?
                temp    dd ?
                div1    dd 14318180
                div2    dd 786432000
        endl

        push      40h
        pop       es
        mov       ebx, [es:6ch]
        mov       [tick], ebx

        fild      word[Time]
        fild      dword[div1]
        fmulp     st1, st0
        fild      dword[div2]
        fdivp     st1,st0
        fistp     dword[temp]

        mov     ebx, dword[temp]
        add     ebx, dword[tick]
        mov     si, word[dwMemTime]
        mov     dword[si], ebx

      ret

endp