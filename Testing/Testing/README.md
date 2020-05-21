# M4 FORTH (ZX Spectrum, Z80)

## Testing

There are examples of small benchmarks on the https://theultimatebenchmark.org/ website. Including speeds on individual platforms.

### Gcd 1

https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/gcd1.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/gcd1.asm

| Name              |   System                         |  Forth                 | Benchmark | Time (sec/round) | Scale |
| :---------------: | :------------------------------: | :---------------------: | :-------: | :-------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu    | M4_FORTH                |  GCD1  | 0m9.86s
| Ben               | IBM PS/2 L40SX                   | DX-Forth                |  GCD1  | 0m29s   | 10x
| Thunder.Bird      | Amstrad PPC 512                  | DX-Forth                |  GCD1  | 0m48s   | 5x
| Alexander Muller  | IBM PS/2 L40SX                   | DX-Forth                |  gcd1  | 0m15s   | 5x
| Alexander Muller  | Raspberry Pi ARM 700Mhz          | Gforth 0.7.0            |  gcd1  | 0m04s   | 100x
| Thorsten Schoeler | Sinclair Spectrum+               | Aber Forth (FIG-Forth)  |  GCD1  | 2m14s
| Wolfgang Stief    | SUN SparcStation 10 TI TMS390255 | OpenFirmware            |  GCD1  | 0,51s
| Wolfgang Stief    | SUN Ultra 1 200 Mhz UltraSprac   | OpenBoot 3.25           |  GCD1  | 0,08s
| Stefan Niestegge  | Atari Falcon 68060               | f68kans                 |  GCD1  | 0,063s
| Herbert Lange     | Compaq Deskpro P166              | pForth V27              |  GCD1  | 0,002s
| Herbert Lange     | Apple iMac G3 400Mhz             | pForth V27              |  GCD1  | 0,063s
| Herbert Lange     | DEC 3000 400s                    | pForth V27              |  GCD1  | 0,483
| Herbert Lange     | SUN Ultra 1 Creator 3D           | pForth V27              |  GCD1  | 0,022s
| Johan Kotlinski   | C64                              | DurexForth 1.6.1 (STC)  |  GCD 1 | 60s     | 1x
| Carsten Fulde     | Amiga 500 mit ACA1233n-Turbokarte (68030 @ 40 MHz) | JForth 3.1 Delta Research (Phil Burk) | GCD 1 | 0.4s | 1x
| Carsten Fulde     | Enterprise 128                   | IS-Forth von B. Tanner  |  GCD 1 | 78s     | 1x
| Carsten Fulde     | Sinclair QL M68008 7,5 Mhz       | Forth79 (G.W.Jackson)   |  GCD 1 | 21
| Carsten Strotmann | Nixdorf 8810 M15 (8Mhz i286)     | L.O.V.E. Forth          |  GCD 1 | 6
| Enrico/Dirk       | Robotron A 7150 i8086/8087 Multibus ~5Mhz | VolksForth MS-DOS (ITC) | GCD 1 | 25
| Ralf Neumann      | Yodabashi Formula 1 Z80 4Mhz   | VolksForth CP/M (ITC)     |  GCD 1 | 42
| Carsten Strotmann | Scheider Tower AT 220 i286 10Mhz | VolksForth MS-DOS (ITC) |  GCD 1 | 5
| Martin Metz       | Amstrad NC100 Z80 4.606Mhz       | VolksForth CP/M (ITC)   |  GCD 1 | 38.1
| Andreas Boehm     | Commodore C64 6510               | Audiogenic Forth-64     |  GCD 1 | 215.52
| Thorsten Kuphaldt | Amiga 3000 68030 25Mhz           | jforth                  |  GCD 1 | 0.64
| Ingo Soetebier    | iBook PPC 750lx (G3) 600Mhz      | OpenFirmware            |  GCD 1 | 0.024
| Matthias Trute    | Atmega16 8MHz                    | amForth 4.4             |  GCD 1 | 7.12
| Norbert Kehrer    | Mupid II (BTX Decoder)           | FIG-Forth 1.1           |  GCD 1 | 205s
| Norbert Kehrer    | Mupid II (BTX Decoder)           | Camel Forth 1.01        |  GCD 1 | 116s

### Gcd 2

https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/gcd2.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/gcd2.asm


| Name              |   System                         |  Forth                 | Benchmark | Time (sec/round) | Scale |
| :---------------: | :------------------------------: | :---------------------: | :-------: | :-------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu    | M4_FORTH                |  GCD2  | 0m11.76s
| Ben               | IBM PS/2 L40SX                   | DX-Forth                |  GCD2  | 0m42s    | 10x
| Wolfgang Stief    | SUN SparcStation 10 TI TMS390255 | OpenFirmware            |  GCD2  | 0,65s    | 
| Wolfgang Stief    | SUN Ultra 1 200 Mhz UltraSprac   | OpenBoot 3.25           |  GCD2  | 0,11s    | 
| Stefan Niestegge  | Atari Falcon 68060               | f68kans                 |  GCD2  | 0,067s   | 
| Martin Neitzel    | Asus EeePC 1000h (Atom N270 1.6Ghz) | FreeBSD 9 FICL Bootloader | GCD2 | 0.57s | 
| Johan Kotlinski   | C64                              | DurexForth 1.6.1 (STC)  |  GCD 2 | 70s      | 1x
| Carsten Strotmann | A-ONE (Apple 1 Clone) mit 65C02  | TaliForth 2 (STC)       |  GCD 2 | 1m25s    | 1x
| Thomas Woinke     | Steckschwein 8MHz 65c02          | TaliForth 2 (STC)       |  GCD 2 | 11.75s   | 1x
| Enrico/Dirk       | Robotron A 7150 i8086/8087 Multibus ~5Mhz | VolksForth MS-DOS (ITC) | GCD 2 | 30 | 
| Andreas Boehm     | Commodore C64 6510               | Audiogenic Forth-64     |  GCD 2 | 84.84    | 
| Matthias Trute    | Atmega16 8MHz                    | amForth 4.4             |  GCD 2 | 10.5     | 
| Norbert Kehrer    | Mupid II (BTX Decoder)           | FIG-Forth 1.1           |  GCD 2 | 188s     | 
| Norbert Kehrer    | Mupid II (BTX Decoder)           | Camel Forth 1.01        |  GCD 2 | 135s     | 


### Fib 1

https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/fib1.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/fib1.asm


| Name              |   System                             |  Forth            |  Benchmark  | Time (sec/round) | Scale |
| :---------------: | :----------------------------------: | :---------------: | :---------: | :--------------- | :---: |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu        | M4_FORTH          | Fib1        | 48m14.51s
| Johan Kotlinski   | DEC 3000-600 Alpha 21064 175Mhz      | pForth            | Fibonacci 1 | 0.0038
| Ingo Soetebier    | iBook PPC 750lx (G3) 600Mhz          | OpenFirmware      | Fibonacci 1 | 0.0026
| Michael Kalus     | Rockwell R1200-14, 2Mhz 65F12        | RSC-Forth         | Fibonacci 1 | 16.09
| Matthias Trute    | Atmega16 8MHz                        | amForth 4.4       | Fibonacci 1 | 1.46
| Carsten Strotmann | IBM L40X (386SX)                     | VolksForth MS-DOS | Fibonacci 1 | 0.36s
| Wolfgang Stief    | SUN SparcStation 10 TI TMS390255     | OpenFirmware      | Fib1        | 0,005s
| Wolfgang Stief    | SUN Ultra 1 200 Mhz UltraSprac       | OpenBoot 3.25     | Fib1        | 0,014s
| Herbert Lange     | Compaq Deskpro P166                  | pForth V27        | Fib1        | 0,061s
| Herbert Lange     | Apple iMac G3 400Mhz                 | pForth V27        | Fib1        | 0,015s
| Herbert Lange     | DEC 3000 400s                        | pForth V27        | Fib1        | 0,098s
| Herbert Lange     | SUN Ultra 1 Creator 3D               | pForth V27        | Fib1        | 0,052s
| Thorsten Schoeler | NCR 3150 486SX/25Mhz+FPU=Linux 2.0.0 | gforth 0.3.0      | Fib1        | 1m79s
| Thorsten Schoeler | MSP430FR5739, 8Mhz DCO intern MSP-EXP430FR5739 Experimenter Board | CamelForth | FIB1 | 00'46':39 | 100x
