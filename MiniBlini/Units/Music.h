; ------
; - Notes/Keys frequencies equivalent
; --
;Note       Port Frequency          Real Frequency
a0      equ   43388       ;   27.5000 hz
ais0    equ   40953       ;   29.1353 hz
b0      equ   38655       ;   30.8677 hz
c1      equ   36485       ;   32.7032 hz
cis1    equ   34437       ;   34.6479 hz
d1      equ   32505       ;   36.7081 hz
dis1    equ   30680       ;   38.8909 hz
e1      equ   28958       ;   41.2035 hz
f1      equ   27333       ;   43.6536 hz
fis1    equ   25799       ;   46.2493 hz
g1      equ   24351       ;   48.9995 hz
gis1    equ   22984       ;   51.9130 hz
a1      equ   21694       ;   55.0000 hz
ais1    equ   20477       ;   58.2705 hz
b1      equ   19327       ;   61.7354 hz
c2      equ   18243       ;   65.4064 hz
cis2    equ   17219       ;   69.2957 hz
d2      equ   16252       ;   73.4162 hz
dis2    equ   15340       ;   77.7817 hz
e2      equ   14479       ;   82.4069 hz
f2      equ   13666       ;   87.3071 hz
fis2    equ   12899       ;   92.4986 hz
g2      equ   12175       ;   97.9989 hz
gis2    equ   11492       ;  103.8260 hz
a2      equ   10847       ;  110.0000 hz
ais2    equ   10238       ;  116.5410 hz
b2      equ   9664        ;  123.4710 hz
c3      equ   9121        ;  130.8130 hz
cis3    equ   8609        ;  138.5910 hz
d3      equ   8126        ;  146.8320 hz
dis3    equ   7670        ;  155.5630 hz
e3      equ   7240        ;  164.8140 hz
f3      equ   6833        ;  174.6140 hz
fis3    equ   6450        ;  184.9970 hz
g3      equ   6088        ;  195.9980 hz
gis3    equ   5746        ;  207.6520 hz
a3      equ   5424        ;  220.0000 hz
ais3    equ   5119        ;  233.0820 hz
b3      equ   4832        ;  246.9420 hz
c4      equ   4561        ;  261.6260 hz
cis4    equ   4305        ;  277.1830 hz
d4      equ   4063        ;  293.6650 hz
dis4    equ   3835        ;  311.1270 hz
e4      equ   3620        ;  329.6280 hz
f4      equ   3417        ;  349.2280 hz
fis4    equ   3225        ;  369.9940 hz
g4      equ   3044        ;  391.9950 hz
gis4    equ   2873        ;  415.3050 hz
a4      equ   2712        ;  440.0000 hz
ais4    equ   2560        ;  466.1640 hz
b4      equ   2416        ;  493.8830 hz
c5      equ   2280        ;  523.2510 hz
cis5    equ   2152        ;  554.3650 hz
d5      equ   2032        ;  587.3300 hz
dis5    equ   1918        ;  622.2540 hz
e5      equ   1810        ;  659.2550 hz
f5      equ   1708        ;  698.4560 hz
fis5    equ   1612        ;  739.9890 hz
g5      equ   1522        ;  783.9910 hz
gis5    equ   1437        ;  830.6090 hz
a5      equ   1356        ;  880.0000 hz
ais5    equ   1280        ;  932.3280 hz
b5      equ   1208        ;  987.7670 hz
c6      equ   1140        ; 1046.5000 hz
cis6    equ   1076        ; 1108.7300 hz
d6      equ   1016        ; 1174.6600 hz
dis6    equ    959        ; 1244.5100 hz
e6      equ    905        ; 1318.5100 hz
f6      equ    854        ; 1396.9100 hz
fis6    equ    806        ; 1479.9800 hz
g6      equ    761        ; 1567.9800 hz
gis6    equ    718        ; 1661.2200 hz
a6      equ    678        ; 1760.0000 hz
ais6    equ    640        ; 1864.6600 hz
b6      equ    604        ; 1975.5300 hz
c7      equ    570        ; 2093.0000 hz
cis7    equ    538        ; 2217.4600 hz
d7      equ    508        ; 2349.3200 hz
dis7    equ    479        ; 2489.0200 hz
e7      equ    452        ; 2637.0200 hz
f7      equ    427        ; 2793.8300 hz
fis7    equ    403        ; 2959.9600 hz
g7      equ    380        ; 3135.9600 hz
gis7    equ    359        ; 3322.4400 hz
a7      equ    339        ; 3520.0000 hz
ais7    equ    320        ; 3729.3100 hz
b7      equ    302        ; 3951.0700 hz
c8      equ    285        ; 4186.0100 hz

MUSIC_END       equ 1

whole_note          equ 2000
half_note_dot       equ whole_note/2 + whole_note/4
half_note           equ whole_note/2
quarter_note_dot    equ whole_note/4 + whole_note/8
quarter_note        equ whole_note/4
eighth_note         equ whole_note/8
pause               equ 30