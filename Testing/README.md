# M4 FORTH (ZX Spectrum, Z80)

## Testing

There are examples of small benchmarks on the https://theultimatebenchmark.org/ website. Including speeds on individual platforms.

### Gcd 1

https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/gcd1.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/gcd1.asm

| Name              |   System                         |  Forth                  | Benchmark | Time (sec/round) |
| :---------------: | :------------------------------: | :---------------------: | :-------: | :--------------- |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu    | M4_FORTH                | GCD1  | 0m9.86s
| Ben               | IBM PS/2 L40SX                   | DX-Forth                | GCD1  | 0m29s
| Thunder.Bird      | Amstrad PPC 512                  | DX-Forth                | GCD1  | 0m48s
| Alexander Muller  | IBM PS/2 L40SX                   | DX-Forth                | gcd1  | 0m15s
| Alexander Muller  | Raspberry Pi ARM 700Mhz          | Gforth 0.7.0            | gcd1  | 0m04s
| Thorsten Schoeler | Sinclair Spectrum+               | Aber Forth (FIG-Forth)  | GCD1  | 2m14s
| Wolfgang Stief    | SUN SparcStation 10 TI TMS390255 | OpenFirmware            | GCD1  | 0,51s
| Wolfgang Stief    | SUN Ultra 1 200 Mhz UltraSprac   | OpenBoot 3.25           | GCD1  | 0,08s
| Stefan Niestegge  | Atari Falcon 68060               | f68kans                 | GCD1  | 0,063s
| Herbert Lange     | Compaq Deskpro P166              | pForth V27              | GCD1  | 0,002s
| Herbert Lange     | Apple iMac G3 400Mhz             | pForth V27              | GCD1  | 0,063s
| Herbert Lange     | DEC 3000 400s                    | pForth V27              | GCD1  | 0,483
| Herbert Lange     | SUN Ultra 1 Creator 3D           | pForth V27              | GCD1  | 0,022s
| Johan Kotlinski   | C64                              | DurexForth 1.6.1 (STC)  | GCD 1 | 60s
| Carsten Fulde     | Amiga 500 mit ACA1233n-Turbokarte (68030 @ 40 MHz) | JForth 3.1 Delta Research (Phil Burk) | GCD 1 | 0.4s
| Carsten Fulde     | Enterprise 128                   | IS-Forth von B. Tanner  | GCD 1 | 78s
| Carsten Fulde     | Sinclair QL M68008 7,5 Mhz       | Forth79 (G.W.Jackson)   | GCD 1 | 21
| Carsten Strotmann | Nixdorf 8810 M15 (8Mhz i286)     | L.O.V.E. Forth          | GCD 1 | 6
| Enrico/Dirk       | Robotron A 7150 i8086/8087 Multibus ~5Mhz | VolksForth MS-DOS (ITC) | GCD 1 | 25
| Ralf Neumann      | Yodabashi Formula 1 Z80 4Mhz   | VolksForth CP/M (ITC)     | GCD 1 | 42
| Carsten Strotmann | Scheider Tower AT 220 i286 10Mhz | VolksForth MS-DOS (ITC) | GCD 1 | 5
| Martin Metz       | Amstrad NC100 Z80 4.606Mhz       | VolksForth CP/M (ITC)   | GCD 1 | 38.1
| Andreas Boehm     | Commodore C64 6510               | Audiogenic Forth-64     | GCD 1 | 215.52
| Thorsten Kuphaldt | Amiga 3000 68030 25Mhz           | jforth                  | GCD 1 | 0.64
| Ingo Soetebier    | iBook PPC 750lx (G3) 600Mhz      | OpenFirmware            | GCD 1 | 0.024
| Matthias Trute    | Atmega16 8MHz                    | amForth 4.4             | GCD 1 | 7.12
| Norbert Kehrer    | Mupid II (BTX Decoder)           | FIG-Forth 1.1           | GCD 1 | 205s
| Norbert Kehrer    | Mupid II (BTX Decoder)           | Camel Forth 1.01        | GCD 1 | 116s

### Gcd 2

https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/gcd2.m4
https://github.com/DW0RKiN/M4_FORTH/blob/master/Testing/gcd2.asm


| Name              |   System                         |  Forth                  | Benchmark | Time (sec/round) |
| :---------------: | :------------------------------: | :---------------------: | :-------: | :--------------- |
| Dw0rkin           | ZX Spectrum Fuse 1.5.1 Ubuntu    | M4_FORTH                | GCD2 | 0m11.76s

