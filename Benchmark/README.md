# M4 FORTH: A Forth compiler for the Z80 CPU and ZX Spectrum

## Testing

There are examples of small benchmarks on the https://theultimatebenchmark.org/ website. Including speeds on individual platforms.

### Factorization

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/decomp.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/decomp.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/decomp_fast.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/decomp_fast.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/decomp.c

|       Name        |                System                |        Forth / C               |  Benchmark   | Time (sec/round) |
| :---------------: | :----------------------------------: | :----------------------------: | :----------: | :--------------- |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH                       | Decompose    | 1m6.81s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH div:old               | Decompose    | 1m0.03s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH div:old_fast          | Decompose    | 47.54s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH div:fast              | Decompose    | 1m3.07s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH mul:fast              | Decompose    | 1m3.07s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH mul:old_fast          | Decompose    | 1m4.75s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH mul:fast div:old_fast | Decompose    | 43.08s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | zcc z88dk v16209               | Decompose    | 1m40.47s

### Gcd 1

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd1.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd1.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/boriel_gcd1.bas
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/boriel_gcd1.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd1.c

|        Name       |                  System                   |       Forth / C         | Benchmark | Time (sec/round) | Scale |
| :---------------: | :---------------------------------------: | :---------------------: | :-------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu             | M4_FORTH                |    GCD1   | 3.77s
| Dw0rkin           | ZX Spectrum Fuse 1.6.0 Ubuntu             | Boriel Basic zxbc 1.16.4|    GCD1   | 11.27s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu             | zcc z88dk v16209        |    GCD1   | 31.72s
| Ben               | IBM PS/2 L40SX                            | DX-Forth                |    GCD1   | 0m29s            | 10x
| Thunder.Bird      | Amstrad PPC 512                           | DX-Forth                |    GCD1   | 0m48s            | 5x
| Alexander Muller  | IBM PS/2 L40SX                            | DX-Forth                |    GCD1   | 0m15s            | 5x
| Alexander Muller  | Raspberry Pi ARM 700Mhz                   | Gforth 0.7.0            |    GCD1   | 0m04s            | 100x
| Thorsten Schoeler | Sinclair Spectrum+                        | Aber Forth (FIG-Forth)  |    GCD1   | 2m14s
| Wolfgang Stief    | SUN SparcStation 10 TI TMS390255          | OpenFirmware            |    GCD1   | 0,51s
| Wolfgang Stief    | SUN Ultra 1 200 Mhz UltraSprac            | OpenBoot 3.25           |    GCD1   | 0,08s
| Stefan Niestegge  | Atari Falcon 68060                        | f68kans                 |    GCD1   | 0,063s
| Herbert Lange     | Compaq Deskpro P166                       | pForth V27              |    GCD1   | 0,002s
| Herbert Lange     | Apple iMac G3 400Mhz                      | pForth V27              |    GCD1   | 0,063s
| Herbert Lange     | DEC 3000 400s                             | pForth V27              |    GCD1   | 0,483
| Herbert Lange     | SUN Ultra 1 Creator 3D                    | pForth V27              |    GCD1   | 0,022s
| Johan Kotlinski   | C64                                       | DurexForth 1.6.1 (STC)  |    GCD1   | 60s               | 1x
| Carsten Fulde     | Amiga 500 mit ACA1233n-Turbokarte (68030 @ 40 MHz) | JForth 3.1 Delta Research (Phil Burk) | GCD1 | 0.4s | 1x
| Carsten Fulde     | Enterprise 128                            | IS-Forth von B. Tanner  |    GCD1   | 78s     | 1x
| Carsten Fulde     | Sinclair QL M68008 7,5 Mhz                | Forth79 (G.W.Jackson)   |    GCD1   | 21
| Carsten Strotmann | Nixdorf 8810 M15 (8Mhz i286)              | L.O.V.E. Forth          |    GCD1   | 6
| Enrico/Dirk       | Robotron A 7150 i8086/8087 Multibus ~5Mhz | VolksForth MS-DOS (ITC) |    GCD1   | 25
| Ralf Neumann      | Yodabashi Formula 1 Z80 4Mhz              | VolksForth CP/M (ITC)   |    GCD1   | 42
| Carsten Strotmann | Scheider Tower AT 220 i286 10Mhz          | VolksForth MS-DOS (ITC) |    GCD1   | 5
| Martin Metz       | Amstrad NC100 Z80 4.606Mhz                | VolksForth CP/M (ITC)   |    GCD1   | 38.1
| Andreas Boehm     | Commodore C64 6510                        | Audiogenic Forth-64     |    GCD1   | 215.52
| Thorsten Kuphaldt | Amiga 3000 68030 25Mhz                    | jforth                  |    GCD1   | 0.64
| Ingo Soetebier    | iBook PPC 750lx (G3) 600Mhz               | OpenFirmware            |    GCD1   | 0.024
| Matthias Trute    | Atmega16 8MHz                             | amForth 4.4             |    GCD1   | 7.12
| Norbert Kehrer    | Mupid II (BTX Decoder)                    | FIG-Forth 1.1           |    GCD1   | 205s
| Norbert Kehrer    | Mupid II (BTX Decoder)                    | Camel Forth 1.01        |    GCD1   | 116s

### Gcd 2

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd2.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd2.asm
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd2u.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd2u.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd2.c

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/boriel_gcd2.bas
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/boriel_gcd2.asm
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/boriel_gcd2u.bas
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/boriel_gcd2u.asm

I had to manually delete lines starting with: 

    #line

Rename labels:

    __BOR16: -->  .core.__BOR16:
    __EQ16:  -->  .core.__EQ16:
    etc.

Erase the lines:

    push namespace core
    pop namespace


|       Name        |                  System                   |          Forth / C        | Benchmark | Time (sec/round) | Scale |
| :---------------: | :---------------------------------------: | :-----------------------: | :-------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu             | M4_FORTH                  |   GCD2    | 4.53s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu             | M4_FORTH                  |   GCD2 ui | 4.08s
| Dw0rkin           | ZX Spectrum Fuse 1.6.0 Ubuntu             | Boriel Basic zxbc 1.16.4  |   GCD2    | 12.52s
| Dw0rkin           | ZX Spectrum Fuse 1.6.0 Ubuntu             | Boriel Basic zxbc 1.16.4  |   GCD2 ui | 10.36s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu             | zcc z88dk v16209          |   GCD2    | 35.31s
| Ben               | IBM PS/2 L40SX                            | DX-Forth                  |   GCD2    | 42s              | 10x
| Wolfgang Stief    | SUN SparcStation 10 TI TMS390255          | OpenFirmware              |   GCD2    | 0,65s            |
| Wolfgang Stief    | SUN Ultra 1 200 Mhz UltraSprac            | OpenBoot 3.25             |   GCD2    | 0,11s            |
| Stefan Niestegge  | Atari Falcon 68060                        | f68kans                   |   GCD2    | 0,067s           |
| Martin Neitzel    | Asus EeePC 1000h (Atom N270 1.6Ghz)       | FreeBSD 9 FICL Bootloader |   GCD2    | 0.57s            |
| Johan Kotlinski   | C64                                       | DurexForth 1.6.1 (STC)    |   GCD2    | 70s              | 1x
| Carsten Strotmann | A-ONE (Apple 1 Clone) mit 65C02           | TaliForth 2 (STC)         |   GCD2    | 1m25s            | 1x
| Thomas Woinke     | Steckschwein 8MHz 65c02                   | TaliForth 2 (STC)         |   GCD2    | 11.75s           | 1x
| Enrico/Dirk       | Robotron A 7150 i8086/8087 Multibus ~5Mhz | VolksForth MS-DOS (ITC)   |   GCD2    | 30               |
| Andreas Boehm     | Commodore C64 6510                        | Audiogenic Forth-64       |   GCD2    | 84.84            |
| Matthias Trute    | Atmega16 8MHz                             | amForth 4.4               |   GCD2    | 10.5             |
| Norbert Kehrer    | Mupid II (BTX Decoder)                    | FIG-Forth 1.1             |   GCD2    | 188s             |
| Norbert Kehrer    | Mupid II (BTX Decoder)                    | Camel Forth 1.01          |   GCD2    | 135s             |


### Fib 1

Warning: The code for FORTH and C is adopted and contains an error where it correctly calculates only for positive values. 
Nevertheless, in both variants, a signed integer is calculated and no one is favored to use an unsigned integer. 
Furthermore, it actually calculates fib(n+1) instead of fib(n). So it returns 1 for negative numbers and zero.

    if (n<2)
        return 1;
    else
        return fib(n-1)+fib(n-2);

    DUP PUSH(2) LT IF 
        DROP PUSH(1) SEXIT 
    THEN
    DUP  _1SUB SCALL(fib1s) 
    SWAP _2SUB SCALL(fib1s) ADD

It should correctly return from the definition for:

    Fib(0) = 0
    Fib(1) = 1
    Fib(n) = Fib(n-1) + Fib(n-2)

    if (n<2)
        return n;
    else
        return fib(n-1)+fib(n-2);
        
    DUP PUSH(2) LT IF
        SEXIT 
    THEN
    DUP  _1SUB SCALL(fib1s) 
    SWAP _2SUB SCALL(fib1s) ADD
    
Or a faster but incorrect variant for Fib(0) is:

    Fib(0) = 0 ... fail
    Fib(1) = 1
    Fib(2) = 1
    Fib(n) = Fib(n-1) + Fib(n-2)

    if (n<3)
        return 1;
    return fib(n-1)+fib(n-2);
        
    DUP PUSH(3) LT IF
        SEXIT 
    THEN
    DUP  _1SUB SCALL(fib1s) 
    SWAP _2SUB SCALL(fib1s) ADD

or

    DUP PUSH(2) GT IF
        DUP  _1SUB SCALL(fib1s) 
        SWAP _2SUB SCALL(fib1s) ADD
        SEXIT 
    THEN
    DROP PUSH(1)
    
And negative values should be counted as positive and the result should be turned to a negative value.
The algorithm could be greatly speeded up using CASE, but it would have to be used for both C and FORTH to make the results comparable.

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib1.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib1.asm

Use data stack for function:

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib1s.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib1s.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib1.c


|       Name        |               System                 |        Forth / C        |  Benchmark  | Time (sec/round) | Scale |
| :---------------: | :----------------------------------: | :---------------------: | :---------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH                | Fib1        | 32m40.27s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH use data stack | Fib1s       | 18m49.03s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | zcc z88dk v16209        | Fib1        | 41m50.97s
| Johan Kotlinski   | DEC 3000-600 Alpha 21064 175Mhz      | pForth                  | Fibonacci 1 | 0.0038
| Ingo Soetebier    | iBook PPC 750lx (G3) 600Mhz          | OpenFirmware            | Fibonacci 1 | 0.0026
| Michael Kalus     | Rockwell R1200-14, 2Mhz 65F12        | RSC-Forth               | Fibonacci 1 | 16.09
| Matthias Trute    | Atmega16 8MHz                        | amForth 4.4             | Fibonacci 1 | 1.46
| Carsten Strotmann | IBM L40X (386SX)                     | VolksForth MS-DOS       | Fibonacci 1 | 0.36s
| Wolfgang Stief    | SUN SparcStation 10 TI TMS390255     | OpenFirmware            | Fib1        | 0,005s
| Wolfgang Stief    | SUN Ultra 1 200 Mhz UltraSprac       | OpenBoot 3.25           | Fib1        | 0,014s
| Herbert Lange     | Compaq Deskpro P166                  | pForth V27              | Fib1        | 0,061s
| Herbert Lange     | Apple iMac G3 400Mhz                 | pForth V27              | Fib1        | 0,015s
| Herbert Lange     | DEC 3000 400s                        | pForth V27              | Fib1        | 0,098s
| Herbert Lange     | SUN Ultra 1 Creator 3D               | pForth V27              | Fib1        | 0,052s
| Thorsten Schoeler | NCR 3150 486SX/25Mhz+FPU=Linux 2.0.0 | gforth 0.3.0            | Fib1        | 1m79s
| Thorsten Schoeler | MSP430FR5739, 8Mhz DCO intern MSP-EXP430FR5739 Experimenter Board |CamelForth|FIB1| 00'46':39 | 100x


### Fib 2

Wariant with `?do`. Because the variant with `do` starts `0 0 do` and executes 65536!

    : fib2 ( n1 -- n2 )
        0 1 ROT 0 ?DO
            OVER_ADD SWAP LOOP
        DROP
    ;

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib2.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib2.asm

Use data stack for function, do loop --> for next:

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib2s.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib2s.asm

To get an idea of how far the resulting code is from one of the best. Handwritten M4 word in assembler replacing C function "fib2":

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib2a.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib2a.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/fib2.c

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/boriel_fib2.bas
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/boriel_fib2.asm


|       Name        |               System                 |        Forth / C        |  Benchmark  | Time (sec/round) | Scale |
| :---------------: | :----------------------------------: | :---------------------: | :---------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH                | Fib2        | 0m6.39s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH use data stack | Fib2s       | 0m5.23s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH use assembler  | Fib2a       | 0m2.55s
| Dw0rkin           | ZX Spectrum Fuse 1.6.0 Ubuntu        | Boriel Basic zxbc 1.16.4| Fib2 a = a+c| 0m14.38s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | zcc z88dk v16209        | Fib2 a = a+c| 0m49.19s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | zcc z88dk v16209        | Fib2 a+= c  | 0m43.97s
| Carsten Strotmann | Scheider Tower AT 220 i286 10Mhz     | VolksForth MS-DOS (ITC) | Fibonacci2  | 8
| Johan Kotlinski   | C64                                  | DurexForth 1.6.1 (STC)  | Fibonacci 2 | 1m57s   | 1x
| Carsten Fulde     | Amiga 500 mit ACA1233n-Turbokarte (68030 @ 40 MHz) | JForth 3.1 Delta Research (Phil Burk) | Fibonacci 2 | 0.35s | 1x
| Carsten Fulde     | Enterprise 128                       | IS-Forth von B. Tanner  | Fibonacci 2 | 118.4s  | 1x
| Carsten Strotmann | A-ONE (Apple 1 Clone) mit 65C02      | TaliForth 2 (STC)       | Fibonacci 2 | 1m50s   | 1x
| Thomas Woinke     | Steckschwein 8MHz 65c02              | TaliForth 2 (STC)       | Fibonacci 2 | 15.23s  | 1x
| Carsten Fulde     | Sinclair QL M68008 7,5 Mhz           | Forth79 (G.W.Jackson)   | Fibonacci 2 | 35      |
| Enrico/Dirk       |Robotron A 7150 i8086/8087 Multibus ~5Mhz|VolksForth MS-DOS (ITC)| Fibonacci 2| 46      |
| J. Kunz           | DEC 3000-600 Alpha 21064 175Mhz      | pForth                  | Fibonacci 2 | 0.00001425 |
| Stefan Herold     | Amstrad 6128+ Z80A 4Mhz              | Uniforth                | Fibonacci 2 | 0.23    |
| Ingo Soetebier    | iBook PPC 750lx (G3) 600Mhz          | OpenFirmware            | Fibonacci 2 | 0.0027  |
| Michael Kalus     | Rockwell R1200-14, 2Mhz 65F12        | RSC-Forth               | Fibonacci 2 | 0.05    |
| Matthias Trute    | Atmega16 8MHz                        | amForth 4.4             | Fibonacci 2 | 0.0047  |
| Carsten Strotmann | Nixdorf 8810 M15 (8Mhz i286)         | L.O.V.E. Forth          | Fibonicci 2 | 8
| Ben               | IBM PS/2 L40SX                       | DX-Forth                | Fib2        | 1m03s   | 10x
| Thunder.Bird      | Amstrad PPC 512                      | DX-Forth                | Fib2        | 1m45s   | 5x
| Alexander Muller  | IBM PS/2 L40SX                       | DX-Forth                | fib2        | 1m03s   | 10x
| Michael Mengel    | Apple II UltraWarp 13Mhz             | Apple II v. 3.2         | Fib2        | 0m21s   | 1x
| Michael Mengel    | Apple II UltraWarp 13Mhz             | Apple GraForth          | Fib2        | 0m11s   | 1x
| Michael Mengel    | Apple II 1Mhz                        | Apple II v. 3.2         | Fib2        | 3m56s   | 1x
| Michael Mengel    | Apple II 1Mhz                        | Apple GraForth          | Fib2        | 2m19s   | 1x
| Wolfgang Stief    | SUN SparcStation 10 TI TMS390255     | OpenFirmware            | Fib2        | 0,2s    |
| Wolfgang Stief    | SUN Ultra 1 200 Mhz UltraSprac       | OpenBoot 3.25           | Fib2        | 0,06s   |
| Stefan Niestegge  | Atari Falcon 68060 100mhz            | f68kans                 | Fib2        | 0,0012s |
| Martin Neitzel    | Asus EeePC 1000h (Atom N270 1.6Ghz)  | FreeBSD 9 FICL Bootloader | Fib2      | 66s     |
| Sabine "Atari Frosch" Engelhardt | Atari Portfolio       | VolksForth 3.81         | Fib2        | 35s     |
| Herbert Lange     | Compaq Deskpro P166                  | pForth V27              | Fib2        | 0,001s  |
| Herbert Lange     | Apple iMac G3 400Mhz                 | pForth V27              | Fib2        | 0,001s  |
| Herbert Lange     | SUN Ultra 1 Creator 3D               | pForth V27              | Fib2        | 0,001s  |
| Ralf Neumann      | mc-CP/M Z80 4Mhz                     | FIG-Forth 1.1           | Fib2        | 1m19s   |
| Ralf Neumann      | Prof80 CP/M Z80 6Mhz                 | FIG-Forth 1.1           | Fib2        | 53s     |
| Carsten Strotmann | IBM L40S (386SX)                     | mina (Fig-Forth)        | Fib2 (1000) | 8s
| Carsten Strotmann | IBM L40X (386SX)                     | F83 (Laxen & Perry)     | Fib2 (1000) | 8s
| Carsten Strotmann | IBM L40X (386SX)                     | GNU Forth 0.5.0 ec8086  | Fib2 (1000) | 24s
| Thorsten Schoeler | Sinclair Spectrum+                   | Aber Forth (FIG-Forth)  | Fib2 (1000) | 1m46s
| Thorsten Schoeler | HX-20                                | Epson Forth E1.0        | Fib2 (1000) | 3m16s
| Thorsten Schoeler | Fignition (ATMEL)                    | Fignition Forth         | fib2 (1000) | 13s
| Thorsten Kuphaldt | C64 (normal)                         | Forth64                 | Fib2 (1000) | 3m50s
| Thorsten Kuphaldt | C64 (Turbo FPGA 6502)                | Forth64                 | Fib2 (1000) | 16s
| Carsten Strotmann | Zilog Super-8 20Mhz                  | Super8 Forth            | Fib2 (1000) | 31s
| Bernd Paysan      | Samsung Galaxy Note 2 (Exynos 4core) | Gforth                  | Fib2 (1000) | 0.01s
| Thorsten Schoeler | PDP11                                | FIG-Forth 1.3           | Fib2 (1000) | 37s
| Norbert Kehrer    | Mupid II (BTX Decoder)               | FIG-Forth 1.1           | Fib2 (1000) | 210s
| Norbert Kehrer    | Mupid II (BTX Decoder)               | Camel Forth 1.01        | Fib 2 (1000)| 150s


### Forth Nesting Benchmark

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/nesting.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/nesting.asm

Use data stack for function:

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/nestings.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/nestings.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/nesting.c

|       Name        |              System                  |        Forth / C        |  Benchmark   | Time (sec/round) | Scale |
| :---------------: | :----------------------------------: | :---------------------: | :----------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH recursive      | Nesting 1mil | 1m2.67s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH                | Nesting 1mil | 34.72s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH use data stack | Nesting 1mil | 16.47s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | zcc z88dk v16209        | Nesting 1mil | 18.78s
| Johan Kotlinski   | C64                                  | DurexForth 1.6.1 (STC)  | Nest 1M      | 17s              | 1x
| Carsten Strotmann | A-ONE (Apple 1 Clone) mit 65C02      | TaliForth 2 (STC)       | Nest 1M      | 25s              | 1x
| Thomas Woinke     | Steckschwein 8MHz 65c02              | TaliForth 2 (STC)       | Next 1M      | 3.7s             | 1x
| Thorsten Schoeler | ZX Spectrum 2+                       | FIG-Forth 1.1a          | Nesting      | 3m15s
| Thorsten Schoeler | ZX Spectrum 2+                       | Spect ZX Forth 1.1      | Nesting      | 4m13s
| Thorsten Schoeler | Sinclair Spectrum+                   | Aber Forth (FIG-Forth)  | Nesting 1m   | 3m17s
| Carsten Strotmann | Zilog Super-8 20Mhz                  | Super8 Forth            | Nesting 1m   | 20s
| Thorsten Schoeler | PDP11                                | FIG-Forth 1.3           | Nesting 1m   | 49s
| Norbert Kehrer    | Mupid II (BTX Decoder)               | FIG-Forth 1.1           | Nesting 1m   | 380s
| Thorsten Schoeler | NCR 3150 486SX/25Mhz+FPU=Linux 2.0.0 | gforth 0.3.0            | Nesting 1m   | 3s
| Norbert Kehrer    | Mupid II (BTX Decoder)               | Camel Forth 1.01        | Nesting 1m   | 292s
| Ingo Soetebier    | Nextstation 68040 33Mhz              | pfe                     | Nesting 1Mil | 340
| KC85 Team         | KC85/4 U880 4Mhz                     | VolksForth CP/M         | Nesting 1Mil | 144
| Thorsten Kuphaldt | Amiga 3000 68030 25Mhz               | jforth                  | Nesting 1Mil | 1.32
| Stefan Herold     | Amstrad 6128+ Z80A 4Mhz              | Uniforth                | Nesting 1Mil | 206
| Ingo Soetebier    | iBook PPC 750lx (G3) 600Mhz          | OpenFirmware            | Nesting 1Mil | 1
| Michael Kalus     | Rockwell R1200-14, 2Mhz 65F12        | RSC-Forth               | Nesting 1Mil | 149
| Matthias Trute    | Atmega16 8MHz                        | amForth 4.4             | Nesting 1Mil | 15.4
| Thorsten Schoeler | HX-20                                | Epson Forth E1.0        | Nesting 1mil | 5m08s
| Martin Neitzel    | Asus EeePC 1000h (Atom N270 1.6Ghz)  |FreeBSD 9 FICL Bootloader| Nesting 1mil | 0.66s
| Helfried Schuerer | robotron K 1510, U 808 D (i8008), 480 kHz (auf FOSY Emulator) | FOSY V1.2P 1988 (FIG) | Nesting 1MILLION | 02:32:05 2h 32min 5s

### Forth Sieve Benchmark

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/sieve.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/sieve.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/sieve.c

|       Name        |                System                |        Forth / C        |  Benchmark   | Time (sec/round) | Scale |
| :---------------: | :----------------------------------: | :---------------------: | :----------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH                | Sieve Bench  | 1.18s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | zcc z88dk v16209        | Sieve Bench  | 5.94s
| Johan Kotlinski   | C64                                  | DurexForth 1.6.1 (STC)  | Sieve/Prime  | 10s              | 1x
| Alexander Muller  | Raspberry Pi ARM 700Mhz              | Gforth 0.7.0            | Sieve        | 0m08s            | 100x
| Andreas Boehm     | Commodore C64 6510                   | Audiogenic Forth-64     | Sieve Bench  | 18.1             |
| Venty             | Nokia N900 ARM A8 600Mhz             | gforth-fast, Linux      | Sieve Bench  | 0.015            |
| Venty             | Nokia N900 ARM A8 600Mhz             | gforth-dtc, Linux       | Sieve Bench  | 0.025            |
| Venty             | Nokia N900 ARM A8 600Mhz             | gforth-itc, Linux       | Sieve Bench  | 0.028            |
| Thorsten Kuphaldt | Amiga 3000 68030 25Mhz               | jforth                  | Sieve Bench  | 0.148            |
| Stefan Herold     | Amstrad 6128+ Z80A 4Mhz              | Uniforth                | Sieve Bench  | 12               |
| Ingo Soetebier    | iBook PPC 750lx (G3) 600Mhz          | OpenFirmware            | Sieve Bench  | 0.031            |
| Norbert Kehrer    | Mupid II (BTX Decoder)               | FIG-Forth 1.1           | Sieve        | 22s              |
| Norbert Kehrer    | Mupid II (BTX Decoder)               | Camel Forth 1.01        | Sieve        | 15s              |

### FILLIN

Fill the screen with pixels, and set all attributes to 255.

[Performance of Forth](https://spectrumcomputing.co.uk/forums/viewtopic.php?f=6&t=3487 "Spectrum Computing Forums")

In my opinion, using a loop is not the best way to write the solution, because the loop has its own overhead.
We say to make a new variable on the side, and then we copy that into the TOS. So using `BEGIN ... flag UNTIL` I see as exactly what we want.

For best results, I try to limit movement on the stack, such as inserting or removing values.
That is, words that change the total number of values on the stack.
That's why I use words or word combination like `DROP_I`, which overrides TOS, but I also show the worst `DROP I` variant, which moves the stack twice.

Here I copy the results listed in the forum, with an assembler with essentially the same code as my measurement instead of the 0.04 seconds measured by 0.07 seconds.
Plus or minus 0.01 makes an interruption. What causes the rest of the difference I have no idea.
Maybe I'm doing the measurements through POKE in BASIC and that has some small constant overhead.

    Results (Time taken):
    basic : 72.50secs
    Abersoft forth : 1.50secs
    assembly: 0.04secs

| M4 Forth                                                                                                                                                                                                                             | Bytes |  Time  |
| :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---: |:-----: |
|[PUSH2(23296,16384)<br /> DO<br />&nbsp; &nbsp; PUSH(255)<br />&nbsp; &nbsp; I<br />&nbsp; &nbsp; STORE <br />LOOP                                                                                               ](./fillin_v00.asm)  |   82  | 0.36s  |
|[PUSH2(23296,16384)<br /> DO<br />&nbsp; &nbsp; PUSH(255)<br />&nbsp; &nbsp; I<br />&nbsp; &nbsp; CSTORE <br />LOOP                                                                                              ](./fillin_v01.asm)  |   80  | 0.31s  |
|[PUSH2(23296,16384)<br /> DO<br />&nbsp; &nbsp; PUSH(65535)<br />&nbsp; &nbsp; I<br />&nbsp; &nbsp; STORE <br />PUSH_ADDLOOP(2)                                                                                  ](./fillin_v02.asm)  |   85  | 0.19s  |
|[XDO(23296,16384)<br />&nbsp; &nbsp; PUSH(65535) XI STORE <br />PUSH_ADDXLOOP(2)                                                                                                                                 ](./fillin_v03.asm)  |   58  | 0.19s  |
|[PUSH2(65535,0)<br /> XDO(23296,16384)<br />&nbsp; &nbsp; DROP<br />&nbsp; &nbsp; XI<br />&nbsp; &nbsp; _2DUP<br />&nbsp; &nbsp; STORE <br />XLOOP <br />DROP                                                    ](./fillin_v04.asm)  |   66  | 0.36s  |
|[PUSH2(65535,0)<br /> XDO(23296,16384)<br />&nbsp; &nbsp; DROP_XI<br />&nbsp; &nbsp; _2DUP_STORE <br />XLOOP <br />_2DROP                                                                                        ](./fillin_v05.asm)  |   59  | 0.24s  |
|[PUSH(0)<br /> XDO_DROP_XI(23296,16384<br />&nbsp; &nbsp; PUSH_OVER_CSTORE(255) <br />XLOOP <br />DROP                                                                                                           ](./fillin_v06.asm)  |   53  | 0.18s  |
|[PUSH(0)<br /> XDO_DROP_XI(23296,16384)<br />&nbsp; &nbsp; PUSH_OVER_STORE(65535) <br />PUSH_ADDXLOOP(2) <br />DROP                                                                                              ](./fillin_v07.asm)  |   58  | 0.14s  |
|[PUSH2(65535,0)<br /> XDO(23296,16384)<br />&nbsp; &nbsp; DROP_XI<br />&nbsp; &nbsp; _2DUP_STORE <br />PUSH_ADDXLOOP(2) <br />_2DROP                                                                             ](./fillin_v08.asm)  |   60  | 0.14s  |
|[PUSH(0x4000)<br /> BEGIN<br />&nbsp; &nbsp; DUP<br />&nbsp; &nbsp; PUSH(255)<br />&nbsp; &nbsp; SWAP<br />&nbsp; &nbsp; CSTORE<br />&nbsp; &nbsp; _1ADD<br />&nbsp; &nbsp; DUP<br />&nbsp; &nbsp; PUSH(0x5B00)<br />&nbsp; &nbsp; EQ <br />UNTIL <br />DROP](./fillin_v09.asm)  |   71  | 0.46s  |
|[PUSH(0x4000)<br /> BEGIN<br />&nbsp; &nbsp; PUSH_OVER_CSTORE_1ADD(255)<br />&nbsp; &nbsp; define({_TYP_SINGLE},{L_first})<br />DUP_PUSH_EQ_UNTIL(0x5B00)<br />DROP                                         ](./fillin_v10.asm)  |   46  | 0.09s  |
|[PUSH(0x4000)<br /> BEGIN<br />&nbsp; &nbsp; PUSH_OVER_STORE_2ADD(65535) <br />DUP_PUSH_HI_EQ_UNTIL(0x5B00) <br />DROP                                                                                    _      ](./fillin_v11.asm)  |   44  | 0.07s  |
|[PUSH2(65535,0x4000)<br /> BEGIN<br />&nbsp; &nbsp; _2DUP<br />&nbsp; &nbsp; STORE<br />&nbsp; &nbsp; _2ADD<br />&nbsp; &nbsp; DUP<br />&nbsp; &nbsp; PUSH(0x5B00)<br />&nbsp; &nbsp; EQ <br />UNTIL <br />_2DROP](./fillin_v12.asm)  |   69  | 0.24s  |
|[PUSH2(65535,0x4000)<br /> BEGIN<br />&nbsp; &nbsp; _2DUP_STORE_2ADD <br />DUP_PUSH_EQ_UNTIL(0x5B00) <br />_2DROP                                                                                                ](./fillin_v13.asm)  |   50  | 0.07s  |
|[PUSH2(65535,0x4000)<br /> BEGIN<br />&nbsp; &nbsp; _2DUP_STORE_2ADD<br />&nbsp; &nbsp; _2DUP_STORE_2ADD<br />&nbsp; &nbsp; _2DUP_STORE_2ADD<br /> DUP_PUSH_EQ_UNTIL(0x5B00) <br />_2DROP                        ](./fillin_v14.asm)  |   58  | 0.06s  |
|[PUSH3_FILL(0x4000,6912,255)                                                                                                                                                                                     ](./fillin_v15.asm)  |   42  | 0.07s  |
|[push HL<br />ld   HL, 0xFFFF<br />ld    B, 216<br />di<br />ld  ($+7+16+3),SP<br />ld   SP, 0x5B00<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />push HL<br />djnz $-16<br />ld   SP, 0x0000<br />ei<br />pop  HL](./fillin_v16.asm)  |   58  | 0.01s  |

### Pangram Benchmark

    : pangram? ( addr len -- ? )
      0 -rot bounds do
        i c@ 32 or [char] a -
        dup 0 26 within if
          1 swap lshift or
        else drop then
      loop
      1 26 lshift 1- = ;
     
    s" The five boxing wizards jump quickly." pangram? .   \ -1

10000x + 1x with print output

#### Forth from Rosettacode

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/Pangram_rosettacode.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/Pangram_rosettacode.asm

But this code from rosettacode has one trick. The cell is assumed to be 32 bits.
When rewriting into double cells, we get into a non-standard area. There is no word for double OR - DOR. There is no word for a double logical left shift - DLSHIFT.

    COLON(_pangram_,( addr len -- ? )) 
      PUSHDOT_2SWAP(0) OVER_ADD SWAP DO
        I CFETCH PUSH_OR(32) PUSH_SUB('a')
        DUP_PUSH2_WITHIN_IF(0,26)
          PUSHDOT(1) ROT_DLSHIFT DOR
        ELSE DROP THEN
      LOOP
      PUSHDOT_DEQ(0x3FFFFFF) SEMICOLON

#### Double BITSET version

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/Pangram_dbitset.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/Pangram_dbitset.asm

Since `1. ROT DLSHIFT DOR` is actually just a bit setting, I wrote an optimized `DSETBIT` word for it.

And replaced the DO LOOP loop with the more efficient `BEGIN WHILE REPEAT`. 

That crazy combination of words just says that it should increase the pointer by one and load the character, if it is zero then jump out of the loop, otherwise save a copy of the character in TOS.

The `ROT` moves the third cell to the TOS. So it's a `SWAP` between a 16-bit and a 32-bit number.

`NROT` moves TOS to third position. So it's a `SWAP` between a 16-bit and a 32-bit number.

`ROT ... NROT` temporarily moves NNOS (third cell) to TOS. Similar to repeated `SWAP`, but between 16-bit and 32-bit.

`_2OVER_NIP` creates a copy of NNOS (third cell) to TOS. Similar to `OVER`, but between 16-bit and 32-bit. It seems that there are no standard word for this.

The less the data stack moves up and down between words, the faster and more efficient the program is. 
Most compound words use this. 
Like for example `SWAP_1ADD_SWAP` does not need to move the stack internally.
It's easy to check this in the console using the check_word.sh script.

    COLON(_pangram_,( addr -- ? )) 
      _1SUB
      PUSHDOT(0) 
      BEGIN
        ROT_1ADD_NROT_2OVER_NIP_CFETCH_0CNE_WHILE_2OVER_NIP_CFETCH
        PUSH_OR(32) PUSH_SUB('a')
        DUP_PUSH2_WITHIN_IF(0,26)
          DBITSET
    dnl #  _2OVER_NIP_CFETCH EMIT SPACE_2DUP_HEX_UDDOT CR
        ELSE DROP THEN
      REPEAT
      PUSHDOT_DEQ(0x3FFFFFF) NIP SEMICOLON

#### Double BITSET inline version
      
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/Pangram_dbitset_inline.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/Pangram_dbitset_inline.asm

I only defined at the beginning define({_TYP_DOUBLE},{fast})

In this case, it changed the DBITSET function to inline, so it shortened it because it was only called from one place.

#### C version

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/Pangram.c
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/Pangram.asm
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/Pangram.lst

This is really scary if you look at what kind of code it is. That would be worth writing a whole article about.
It's hard just figuring out how to compile it and I had to help with the asm function to print the number anyway. 
Because printf("%i\n") reboots the ZX Spectrum.

It took me a while to figure out how to write it without mistakes. Because it requires a different notation than pasmo.
It requires a destination registry, where pasmo only wants the source registry, because there is no other option to confuse it with. 
Maybe it's a consequence that it's not only targeted at the Z80, but also at other processors or more modern variants that can also do other instructions.

    xor   a, a          ; 1:4       prt_s16   neg
    sub   a, l          ; 1:4       prt_s16   neg

It didn't take decimal numbers or 'a' characters, just this format and it reported a completely different error.

    ld   bc, #0xD8F0    ; 3:10      prt_u16   -10000
    or    a, #0x30      ; 2:7       bin16_dec   1..9 --> '1'..'9', unchanged '0'..'9'

But he doesn't mind this.

    rst   0x10          ; 1:11      bin16_dec   putchar with ZX 48K ROM in, this will print char in A
    
Labels must only have this numeric format.

    jr   nc, 00001$     ; 2:7/12    prt_s16



|       Name        |              System              |         Forth / C         |           Benchmark         | Time (sec/round) | Scale |
| :---------------: | :------------------------------: | :-----------------------: | :-------------------------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.7 Ubuntu    | M4_FORTH                  | Pangram do loop             | 52.04s
| Dw0rkin           | ZX Spectrum Fuse 1.5.7 Ubuntu    | M4_FORTH                  | Pangram begin bitset repeat | 32.26s
| Dw0rkin           | ZX Spectrum Fuse 1.5.7 Ubuntu    | M4_FORTH _TYP_DOUBLE:fast | Pangram begin bitset repeat | 27.58s
| Dw0rkin           | ZX Spectrum Fuse 1.5.7 Ubuntu    | sdcc 3.8.0 #10562 (Linux) | Pangram                     | 2m 51.61s

