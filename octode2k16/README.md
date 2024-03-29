
# Octode 2k16 beeper routine for ZX Spectrum

    ********************************************************************************
    Octode 2k16 beeper routine for ZX Spectrum
    by utz 05'2016
    original code by Shiru 02'11
    "XL" version by introspec 10'14-04'15
    ********************************************************************************

## About

Octode 2k16 is yet another rewrite of the Octode beeper routine (written by 
Shiru in 2011). More accurately, it is a rewrite of Octode PWM with cleaner
sound and an improved frequency range. However, unlike Octode PWM it does not 
feature variable duty cycles.

- 8 channels with square wave sound
- 16-bit frequency precision
- per-step speed control
- 3 interrupting click drums
- drum volume can be controlled to some extend

Octode 2k16 comes in two versions - for NMOS and CMOS Z80 CPUs. Most original 
ZX models use an NMOS CPU, most clones use a CMOS CPU. It's easy to tell which 
CPU your Spectrum is sporting - if you get no sound and/or white stripes in the 
border area with the NMOS version, you've got a CMOS CPU. For emulators, the 
NMOS version will usually be the right choice.


## Requirements

The following tools are required to use the xm2octode2k16 utility

- an XM tracker, for example Milkytracker (http://milkytracker.org) or OpenMPT
  (http://openmpt.org)
- pasmo or a compatible Z80 assembler (http://pasmo.speccy.org)

pasmo must be installed in your search path, or must reside within the
octode2k16 folder.


## Composing Music

You can compose music for the Octode 2k16 player using the XM template that 
comes bundled with Octode 2k16. However, this will only give a very rough 
estimate of how the music will sound on an actual ZX Spectrum.

When using the XM template, consider the following:

- You may not change the number of channels.
- Tones must be in channel 1-8.
- The note range is limited from C-0 to B-6. Beware that notes above C-5 will
  be aliased.
- Drums should be in channel 9-10, and you can only use one drum per row.
- Drums have a fixed pitch, mapped to C-4 in the template.
- You can use the volume column to set the drum's volume. This is most effective
  on the hihat, it has little effect on the kick.
- Changes to the BPM value or to the instruments have no effect.
- You may change the speed value globally, or at any point by using command Fxx, 
  where xx must be in the range of 0-$1f.
- You may set note detune with command E5x.
- You may set the sequence loop point with command Bxx.
- All other effect commands, including volume settings on tones will be ignored.


By default, Octode 2k16 will loop until a key is pressed. To disable looping `define({__NO_LOOP_MUSIC})`.

When you're done with composing run: 

    ./xm2octode2k16 name.xm 

If xm2octode2k16 not exist, first compile:

    g++ xm2octode2k16.cpp -o xm2octode2k16

## Data Format

Octode 2k16 uses a somewhat unusual data format. It follows the common sequence-
pattern approach, but stores the actual note data in seperate row-length 
buffers.


The song sequence must follow directly after the musicData label (that is, at 
the top of music.asm). It consists of a list of pointers to the actual patterns,
in the order in which they are played. The sequence is terminated by a 0-word. 
At some point in the sequence you must specify the label "loop", which is where 
the player will jump to after it has completed the sequence.


Patterns and row buffers can be located anywhere in the music data. If memory
is sparse, you could even squeeze data into the gaps between the 8 sound cores.

Patters consist of one or more rows, which in turn contain 2-3 word length
entries. The first word is the control word, which is constructed as
(row speed * 256) + drum trigger. Drum triggers are

    0x00 - no drum
    0x01 - hihat
    0x04 - kick
    0x80 - snare

If the drum trigger is not zero, the next word is the drum volume. The high
byte of this is always 0, the low byte can be any value. A value of 0x80 
signifies the highest volume, both lower and higher values signify lower
volumes.

The last word is a pointer to a row buffer, containing the actual note data
for the given pattern row.

Patterns must be terminated with 0x40.

Last but not least, there should be at least one row buffer. Row buffers
consist of 8 words, representing 8 frequency (counter) values. To silence a
channel, simply set it's frequency to 0. Row buffers do not need to be 
terminated.


A minimal song data set would thus look like this:

    loop
         dw pattern
         dw 0
    pattern
         dw #1001,#0080,row
         db #40
    row
         dw #200,#400,#300,#0,#0,#0,#0,#0
         
### Modifications due to M4 FORTH

The original looked something like this:

     loop
           dw ptn0
           dw 0
     ptn0
           dw #300,row0
           dw #380,#0080,row1
           db #40
     row0
           dw #200,#400,#300,#0,#0,#0,#0,#0
     row1
           dw #0,#200,#e41,#0,#0,#0,#0,#0

First, I renamed the labels according to the file name and removed the # character, which is a comment character for M4:


    filename_loop:
          dw filename_ptn0
          dw 0
    filename_ptn0:
          dw 0x300, filename_row0
          dw 0x380,#0080,filename_row1
          db 0x40
    filename_row0:
          dw 0x200,0x400,0x300,0x0,0x0,0x0,0x0,0x0
    filename_row1:
          dw 0x0,0x200,0xe41,0x0,0x0,0x0,0x0,0x0

Then he granted it to reallocators:

       ifndef filename
    filename equ $
       endif
    filename_loop equ filename+0x0
          dw filename_ptn0
          dw 0
    filename_ptn0 equ filename+0x4
          dw 0x300, filename_row0
          dw 0x380,0x0080,filename_row1
          db 0x40
    filename_rows equ filename+0x9
    filename_row0 equ filename_rows+0x0
          dw 0x200,0x400,0x300,0x0,0x0,0x0,0x0,0x0
    filename_row0 equ filename_rows+0x1
          dw 0x0,0x200,0xe41,0x0,0x0,0x0,0x0,0x0

The comma character causes problems when loading with M4, so I removed it everywhere.
But I still had a problem with the fact that I need M4 FORTH to know the size of the file after connection (after compilation) so that I can correctly place it in the VARIABLE_SECTION and know how much space it took.

So I added it in the end

    ; define({filename_size}, 0x29)


I achieved that, except for changing the name "label" to "filename_label", it is backwards compatible and M4 FORTH can work with it as a variable.

       ifndef filename
    filename equ $
       endif
       
    ; loop  
          dw filename_loop
    
    filename_start equ filename+0x2
    ; sequence
    filename_loop equ filename+0x2
          dw filename_ptn0
          dw 0
          
    filename_ptn0 equ filename+0x4
          dw 0x300
          dw filename_row0
          
          dw 0x380
          dw 0x0080
          dw filename_row1
          db 0x40
      
    filename_rows equ filename+0x9
    filename_row0 equ filename_rows+0x0
          dw 0x200
          dw 0x400
          dw 0x300
          dw 0x0
          dw 0x0
          dw 0x0
          dw 0x0
          dw 0x0
          
    filename_row0 equ filename_rows+0x1
          dw 0x0
          dw 0x200
          dw 0xe41
          dw 0x0
          dw 0x0
          dw 0x0
          dw 0x0
          dw 0x0


## FastTracker II

I recommend FastTracker2 for editing music files. You can also find it in repositories along with MilkyTracker and Schismtracker. I recommend that you learn the keyboard shortcuts first, because it may take a while to learn how to work.


[![Fasttracker 2 - Tutorial 1: Basics](https://img.youtube.com/vi/8bBLXfOZ9Kg/0.jpg)](https://www.youtube.com/watch?v=8bBLXfOZ9Kg)


### My procedure is as follows

- I will make a copy of xm. 
You will then return to the original for comparison, because you will have new samples in the edited version that will change the sound.

- I'll look through the used samples and find out which are the drums. Compare drums from loudest to quietest. I'm not interested in the type of punch. 
The loudest beat in the edited file will be sample number 2 `kick`, the middle number 3 `snare` and the least noisy will be number 4 `hihat`.

- All other non-drum samples will be replaced with a regular wave, number 1 `tone`.
If the original sample wave has a highly skewed, asymmetrical course, it may appear to be playing in a different key, it may appear to be playing in a different key. Then all of them have to be moved by the difference in tonnage.

- I delete all samples and upload samples `01_tone.wav`, `02_kick.wav`, `03_snare.wav` and `04_hihat.wav`.

- I will do `Adv. Edit`. The value is set by clicking right on the column of numbers (from) and the number of the row (to).


      Shift+F3 - cut track
      Shift+F4 - copy track
      Shift+F5 - paste track

To edit an item, you must have the "cursor line" set correctly. 
It is the middle row, colored differently, and in it the current Track and the item that can be edited are marked in black.
Cursor movement is by shortcuts or cursor arrows.

You may need to press space first to activate edit mode.
