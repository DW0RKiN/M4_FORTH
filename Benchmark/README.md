# M4 FORTH (ZX Spectrum, Z80)

## Testing

There are examples of small benchmarks on the https://theultimatebenchmark.org/ website. Including speeds on individual platforms.

### Factorization

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/decomp.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/decomp.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/decomp_fast.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/decomp_fast.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/decomp.c

|       Name        |                System                |        Forth / C        |  Benchmark   | Time (sec/round) | Scale |
| :---------------: | :----------------------------------: | :---------------------: | :----------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH                | Decompose    | 1m8.86s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH old div        | Decompose    | 1m0.1s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH fast mul & div | Decompose    | 45.24s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | zcc z88dk v16209        | Decompose    | 1m40.47s

### Gcd 1

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd1.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd1.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd1.c

|        Name       |             System               |       Forth / C         | Benchmark | Time (sec/round) | Scale |
| :---------------: | :------------------------------: | :---------------------: | :-------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu    | M4_FORTH                |    GCD1   | 3.77s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu    | zcc z88dk v16209        |    GCD1   | 31.72s
| Ben               | IBM PS/2 L40SX                   | DX-Forth                |    GCD1   | 0m29s            | 10x
| Thunder.Bird      | Amstrad PPC 512                  | DX-Forth                |    GCD1   | 0m48s            | 5x
| Alexander Muller  | IBM PS/2 L40SX                   | DX-Forth                |    gcd1   | 0m15s            | 5x
| Alexander Muller  | Raspberry Pi ARM 700Mhz          | Gforth 0.7.0            |    gcd1   | 0m04s            | 100x
| Thorsten Schoeler | Sinclair Spectrum+               | Aber Forth (FIG-Forth)  |    GCD1   | 2m14s
| Wolfgang Stief    | SUN SparcStation 10 TI TMS390255 | OpenFirmware            |    GCD1   | 0,51s
| Wolfgang Stief    | SUN Ultra 1 200 Mhz UltraSprac   | OpenBoot 3.25           |    GCD1   | 0,08s
| Stefan Niestegge  | Atari Falcon 68060               | f68kans                 |    GCD1   | 0,063s
| Herbert Lange     | Compaq Deskpro P166              | pForth V27              |    GCD1   | 0,002s
| Herbert Lange     | Apple iMac G3 400Mhz             | pForth V27              |    GCD1   | 0,063s
| Herbert Lange     | DEC 3000 400s                    | pForth V27              |    GCD1   | 0,483
| Herbert Lange     | SUN Ultra 1 Creator 3D           | pForth V27              |    GCD1   | 0,022s
| Johan Kotlinski   | C64                              | DurexForth 1.6.1 (STC)  |    GCD 1  | 60s               | 1x
| Carsten Fulde     | Amiga 500 mit ACA1233n-Turbokarte (68030 @ 40 MHz) | JForth 3.1 Delta Research (Phil Burk) | GCD 1 | 0.4s | 1x
| Carsten Fulde     | Enterprise 128                   | IS-Forth von B. Tanner  |    GCD 1  | 78s     | 1x
| Carsten Fulde     | Sinclair QL M68008 7,5 Mhz       | Forth79 (G.W.Jackson)   |    GCD 1  | 21
| Carsten Strotmann | Nixdorf 8810 M15 (8Mhz i286)     | L.O.V.E. Forth          |    GCD 1  | 6
| Enrico/Dirk       | Robotron A 7150 i8086/8087 Multibus ~5Mhz | VolksForth MS-DOS (ITC) | GCD 1 | 25
| Ralf Neumann      | Yodabashi Formula 1 Z80 4Mhz     | VolksForth CP/M (ITC)   |    GCD 1  | 42
| Carsten Strotmann | Scheider Tower AT 220 i286 10Mhz | VolksForth MS-DOS (ITC) |    GCD 1  | 5
| Martin Metz       | Amstrad NC100 Z80 4.606Mhz       | VolksForth CP/M (ITC)   |    GCD 1  | 38.1
| Andreas Boehm     | Commodore C64 6510               | Audiogenic Forth-64     |    GCD 1  | 215.52
| Thorsten Kuphaldt | Amiga 3000 68030 25Mhz           | jforth                  |    GCD 1  | 0.64
| Ingo Soetebier    | iBook PPC 750lx (G3) 600Mhz      | OpenFirmware            |    GCD 1  | 0.024
| Matthias Trute    | Atmega16 8MHz                    | amForth 4.4             |    GCD 1  | 7.12
| Norbert Kehrer    | Mupid II (BTX Decoder)           | FIG-Forth 1.1           |    GCD 1  | 205s
| Norbert Kehrer    | Mupid II (BTX Decoder)           | Camel Forth 1.01        |    GCD 1  | 116s

### Gcd 2

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd2.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd2.asm

https://github.com/DW0RKiN/M4_FORTH/blob/master/Benchmark/gcd2.c

|       Name        |             System               |        Forth / C        | Benchmark | Time (sec/round) | Scale |
| :---------------: | :------------------------------: | :---------------------: | :-------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu    | M4_FORTH                |    GCD2   | 4.53s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu    | zcc z88dk v16209        |    GCD2   | 35.31s
| Ben               | IBM PS/2 L40SX                   | DX-Forth                |    GCD2   | 42s              | 10x
| Wolfgang Stief    | SUN SparcStation 10 TI TMS390255 | OpenFirmware            |    GCD2   | 0,65s            | 
| Wolfgang Stief    | SUN Ultra 1 200 Mhz UltraSprac   | OpenBoot 3.25           |    GCD2   | 0,11s            | 
| Stefan Niestegge  | Atari Falcon 68060               | f68kans                 |    GCD2   | 0,067s           | 
| Martin Neitzel    | Asus EeePC 1000h (Atom N270 1.6Ghz) | FreeBSD 9 FICL Bootloader | GCD2 | 0.57s            | 
| Johan Kotlinski   | C64                              | DurexForth 1.6.1 (STC)  |    GCD 2  | 70s              | 1x
| Carsten Strotmann | A-ONE (Apple 1 Clone) mit 65C02  | TaliForth 2 (STC)       |    GCD 2  | 1m25s            | 1x
| Thomas Woinke     | Steckschwein 8MHz 65c02          | TaliForth 2 (STC)       |    GCD 2  | 11.75s           | 1x
| Enrico/Dirk       | Robotron A 7150 i8086/8087 Multibus ~5Mhz | VolksForth MS-DOS (ITC) | GCD 2 | 30          | 
| Andreas Boehm     | Commodore C64 6510               | Audiogenic Forth-64     |    GCD 2  | 84.84            | 
| Matthias Trute    | Atmega16 8MHz                    | amForth 4.4             |    GCD 2  | 10.5             | 
| Norbert Kehrer    | Mupid II (BTX Decoder)           | FIG-Forth 1.1           |    GCD 2  | 188s             | 
| Norbert Kehrer    | Mupid II (BTX Decoder)           | Camel Forth 1.01        |    GCD 2  | 135s             | 


### Fib 1

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

|       Name        |               System                 |        Forth / C        |  Benchmark  | Time (sec/round) | Scale |
| :---------------: | :----------------------------------: | :---------------------: | :---------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH                | Fib2        | 0m6.39s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH use data stack | Fib2s       | 0m5.23s
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH use assembler  | Fib2a       | 0m2.98s
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

