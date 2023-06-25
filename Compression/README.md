## Interlaced_Elias_gamma_coding

Used by ZX0 compressor

`?` is a flag bit
`-` is a flag bit with a value of `0` meaning the continuation of the bit stream
`+` is a flag bit with a value of `1` meaning the end of the bit stream

                                                                              output with input _1_
                     ?a?b?c?d?e?f?g?h? = ? a ? b ? c ? d ? e ? f ? g ? h ? -> _input_abcdefgh
    input ×  1 + 0 = 1                 = +                                 ->     _1_
    input ×  2 + 0 = 001               = - 0 +                             ->     _1_0
    input ×  2 + 1 = 011               = - 1 +                             ->     _1_1
    input ×  4 + 0 = 00001             = - 0 - 0 +                         ->     _1_00
    input ×  4 + 1 = 00011             = - 0 - 1 +                         ->     _1_01
    input ×  4 + 2 = 01001             = - 1 - 0 +                         ->     _1_10
    input ×  4 + 3 = 01011             = - 1 - 1 +                         ->     _1_11
    input ×  8 + 0 = 0000001           = - 0 - 0 - 0 +                     ->     _1_000
    input ×  8 + 1 = 0000011           = - 0 - 0 - 1 +                     ->     _1_001
    input ×  8 + 2 = 0000101           = - 0 - 1 - 0 +                     ->     _1_010
    input ×  8 + 3 = 0001011           = - 0 - 1 - 1 +                     ->     _1_011
    input ×  8 + 4 = 0100001           = - 1 - 0 - 0 +                     ->     _1_100
    input ×  8 + 5 = 0100011           = - 1 - 0 - 1 +                     ->     _1_101
    input ×  8 + 6 = 0101001           = - 1 - 1 - 0 +                     ->     _1_110
    input ×  8 + 7 = 0101011           = - 1 - 1 - 1 +                     ->     _1_111
    input × 16 + 0 = 000000001         = - 0 - 0 - 0 - 0 +                 ->     _1_0000
    ...                                                                           _1_
    input × 16 + 15= 010101011         = - 1 - 1 - 1 - 1 +                 ->     _1_1111
    input × 32 + 0 = 00000000001       = - 0 - 0 - 0 - 0 - 0 +             ->     _1_00000
    ...                                                                           _1_
    input × 32 + 31= 01010101011       = - 1 - 1 - 1 - 1 - 1 +             ->     _1_11111
    input × 64 + 0 = 0000000000001     = - 0 - 0 - 0 - 0 - 0 - 0 +         ->     _1_000000
    input ×...                                                                    _1_
    input × 64 + 63= 0101010101011     = - 1 - 1 - 1 - 1 - 1 - 1 +         ->     _1_111111
    input ×128 + 0 = 000000000000001   = - 0 - 0 - 0 - 0 - 0 - 0 - 0 +     ->     _1_0000000
    ...                                                                           _1_
    input ×128 +127= 010101010101011   = - 1 - 1 - 1 - 1 - 1 - 1 - 1 +     ->     _1_1111111
    input ×256 + 0 = 00000000000000001 = - 0 - 0 - 0 - 0 - 0 - 0 - 0 - 0 + ->     _1_00000000
    ...                                                                           _1_
    input ×256 +255= 01010101010101011 = - 1 - 1 - 1 - 1 - 1 - 1 - 1 - 1 + ->     _1_11111111
                     ?a?b?c?d?e?f?g?h? = ? a ? b ? c ? d ? e ? f ? g ? h ? ->     _1_abcdefgh
          

Reading from the bit stream is always 2 bits apart, so even. This makes it possible to solve the test whether the buffer in `A` is empty only in odd reading.

A stop bit with a value of 1 is loaded into the accumulator, indicating the end of the data in the buffer.

Each read means moving a bit from `A` to the carry register.

In the case of an odd reading, before using the carry, it is checked whether the accumulator is empty. 
If there is, then there is no data in the carry, but a bit stop. 
So, a new byte is read into the accumulator and a new bit is read rotation "rla"  or "adc A,A" load a new bit and at the same time set the stop bit.

So `A` looks like this:
```
???????s
?????s00
???s0000
?s000000
```
Where `?` is waiting data, `s` is stop bit and `0` is filled.

So another even read is sure that there is data in the accumulator.

All values stored in Elias gamma coding have an odd number of bits. 
This, together with one bit specifying the type of the literal, means that the total read is always an even number of bits.

The only exception is the second read of the literal for the new offset.

So reading the length is called after the test of the first bit. This means that the stored value must be greater than 1.

That wouldn't be a problem, because the literal is effective from length 2...

But the author decided to reduce this value by 1 when saving to possibly save space.
So it is solved in such a way that to solve the problem that the length is equal to two, one bit is added. 
It is placed in the LSB offset so that it does not add space. 
If the lowest bit is non-zero then Elias is not read and the length is set to 2.

The offset is then calculated as `(256 * MSB + LSB)>>1`. So there are 15 bits.

The actual stored value for EOF is `input×256 + 255` = 511 if input is 1. Not 256 as described.

The offset is stored as a negative number, for easier calculation.
In addition, the upper byte is decremented by 1 for a quick EOF test. So it cannot be zero, because the stored 255 is understood as EOF.
