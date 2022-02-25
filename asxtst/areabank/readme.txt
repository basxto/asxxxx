This is Patch_01 for the ASxxxx Assembler and Linker Version 4.10

   During testing of the BANK/AREA relocation I have
found a coding error which affects BANKS containing
multiple ABS areas or mixed AREA types.  I have
updated the relevant file (lkbank.c) to fix this error.
You must recompile aslink to incorporate the fix.

   Merge the patch asxv4pxx directory and subdirectories
with the V4.10 distribution. (Note: file lkbank.c will
be overwritten.)

   The directory asxv4pxx\asxtst\areabank contains
several test programs: ts.asm (single file - multiple
areas), tm1.asm and tm2.asm (multiple file - multiple
areas), and tbm.asm, tbm1.asm, and tbm2.asm ( multiple
file - multiple areas within a bank) and several other
files which verify the correct operation of the linker
when used with a single linked file,  multiple linked
files having no banking, and multiple linked files with
banking.  These reference files show in detail how the
.area and .bank directives work together.

