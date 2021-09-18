# VGA-6502
6502+VGA+PS2 project (assembly, PCBs) to output to Ben Eater's "World's worst video card."

** Files are posted as-is. No warranties or guarantees of any sort. All code and PCB designs should be validated prior to use. ***

I've been using these projects to learn 6502 assembly (and assembly in general). While the code is likely far from optimal, possibly, it will be helpful to some people.


vga-text.s        -->   https://www.reddit.com/r/beneater/comments/oxma9w/custom_6502_assembly_code_started_for_bens_vga/

vga-text-2.s      -->   https://www.reddit.com/r/beneater/comments/oyc0oz/making_progress_on_6502_assembly_code_for_driving/

vga-text-3.s      -->   https://www.reddit.com/r/beneater/comments/p2n07u/finally_6502lcdvgaps2_working_video_ps2_keyboard/

                  -->   Also, updated code to use a more dynamic approach to generating character output to VGA.
                        Font data stored in ROM.
                        Added wider ASCII support (numbers, upper, lower, punctuation).
                        Cut code from 4400 lines down to 1730 lines. :)

paint-0.0.0.1     --> https://www.reddit.com/r/beneater/comments/pe1hfx/6502ps2vga_paint_0001/

VGA for 6502 rev1.1 - EasyEDA.zip --> EasyEDA PCB project for VGA card.

6502 VGA PS2 5VIA - rev1.1 - EasyEDA.zip --> EasyEDA PCB project for 6502+VGA+PS2+5VIA. https://www.reddit.com/r/beneater/comments/pqj20i/step_4_everything_working_time_for_a/

PCB_ROM_20210918 --> Version of ROM used in https://www.reddit.com/r/beneater/comments/pqj20i/step_4_everything_working_time_for_a/
