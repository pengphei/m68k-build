/* Linker script for Freescale MCF51JG256
 *
 * Version: Sourcery CodeBench Lite 2011.09-21
 * Support: https://support.codesourcery.com/GNUToolchain/
 *
 * Copyright (c) 2007, 2008, 2009, 2010 CodeSourcery, Inc.
 *
 * The authors hereby grant permission to use, copy, modify, distribute,
 * and license this software and its documentation for any purpose, provided
 * that existing copyright notices are retained in all copies and that this
 * notice is included verbatim in any distributions.  No written agreement,
 * license, or royalty fee is required for any of the authorized uses.
 * Modifications to this software may be copyrighted by their authors
 * and need not follow the licensing terms described here, provided that
 * the new terms are clearly indicated on the first page of each file where
 * they apply.
 */
OUTPUT_ARCH(m68k)
ENTRY(__cs3_reset)
SEARCH_DIR(.)
GROUP(-lgcc -lc -lcs3 -lcs3hosted -lcs3coldfire)

MEMORY
{
  rom (rx) : ORIGIN = 0x00000000, LENGTH = 256K
  flexnvm (rx) : ORIGIN = 0x00200000, LENGTH = 32K
  flexram (rwx) : ORIGIN = 0x00280000, LENGTH = 2K
  ram (rwx) : ORIGIN = 0x00800000, LENGTH = 64K
  gpio (rw) : ORIGIN = 0x00c00000, LENGTH = 16
  io (rw) : ORIGIN = 0x00ff8000, LENGTH = 32K
}

/* These force the linker to search for particular symbols from
 * the start of the link process and thus ensure the user's
 * overrides are picked up
 */
EXTERN(__cs3_reset __cs3_reset_mcf51jg256_ram)
EXTERN(__cs3_start_asm _start)
/* Bring in the interrupt routines & vector */
INCLUDE coldfire-names.inc
EXTERN(__cs3_interrupt_vector_coldfire)
EXTERN(__cs3_start_c main __cs3_stack __cs3_heap_end)
/* force exit to be picked up in a hosted or os environment */
EXTERN(exit atexit)

/* Provide fall-back values */
PROVIDE(__cs3_heap_start = _end);
PROVIDE(__cs3_heap_end = __cs3_region_start_ram + __cs3_region_size_ram);
PROVIDE(__cs3_region_num = (__cs3_regions_end - __cs3_regions) / 20);
/* Ensure that newlib runs the finalizers */
__libc_fini = _fini;
PROVIDE(__cs3_stack = __cs3_region_start_ram + __cs3_region_size_ram);

SECTIONS
{
  .text :
  {
    CREATE_OBJECT_SYMBOLS
    __cs3_region_start_ram = .;
    _ftext = .;
    *(.cs3.region-head.ram)
    ASSERT (. == __cs3_region_start_ram, ".cs3.region-head.ram not permitted");
    __cs3_interrupt_vector = __cs3_interrupt_vector_coldfire;
    *(.cs3.interrupt_vector)
    /* Make sure we pulled in an interrupt vector.  */
    ASSERT (. != __cs3_interrupt_vector_coldfire, "No interrupt vector");

    PROVIDE(__cs3_reset = __cs3_reset_mcf51jg256_ram);
    *(.cs3.reset)
    _start = DEFINED(__cs3_start_asm) ? __cs3_start_asm : _start;

    *(.text.cs3.init)
    *(.text .text.* .gnu.linkonce.t.*)

    . = ALIGN(0x4);
    KEEP (*crtbegin.o(.jcr))
    KEEP (*(EXCLUDE_FILE (*crtend.o) .jcr))
    KEEP (*crtend.o(.jcr))

    . = ALIGN(0x4);
    *(.gcc_except_table .gcc_except_table.*)
  } >ram
  .eh_frame_hdr : ALIGN (4)
  {
    KEEP (*(.eh_frame_hdr))
  } >ram
  .eh_frame : ALIGN (4)
  {
    KEEP (*(.eh_frame))
  } >ram
  .rodata : ALIGN (4)
  {
    *(.rodata .rodata.* .gnu.linkonce.r.*)

    . = ALIGN(4);
    _init = .;
    LONG (0x4e560000)	/* linkw %fp,#0 */
    KEEP(*(.init))
    SHORT (0x4e5e)	/* unlk %fp */
    SHORT (0x4e75)	/* rts */

    . = ALIGN(4);
    __preinit_array_start = .;
    KEEP (*(.preinit_array))
    __preinit_array_end = .;

    . = ALIGN(4);
    __init_array_start = .;
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array))
    __init_array_end = .;

    . = ALIGN(4);
    _fini = .;
    LONG (0x4e560000)	/* linkw %fp,#0 */
    KEEP(*(.fini))
    SHORT (0x4e5e)	/* unlk %fp */
    SHORT (0x4e75)	/* rts */

    . = ALIGN(4);
    __fini_array_start = .;
    KEEP (*(.fini_array))
    KEEP (*(SORT(.fini_array.*)))
    __fini_array_end = .;

    . = ALIGN(0x4);
    KEEP (*crtbegin.o(.ctors))
    KEEP (*(EXCLUDE_FILE (*crtend.o) .ctors))
    KEEP (*(SORT(.ctors.*)))
    KEEP (*crtend.o(.ctors))

    . = ALIGN(0x4);
    KEEP (*crtbegin.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.o) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*crtend.o(.dtors))

    *(.lit)

    . = ALIGN(4);
    __cs3_regions = .;
    LONG (0)
    LONG (__cs3_region_init_flexnvm)
    LONG (__cs3_region_start_flexnvm)
    LONG (__cs3_region_init_size_flexnvm)
    LONG (__cs3_region_zero_size_flexnvm)
    LONG (0)
    LONG (__cs3_region_init_flexram)
    LONG (__cs3_region_start_flexram)
    LONG (__cs3_region_init_size_flexram)
    LONG (__cs3_region_zero_size_flexram)
    LONG (0)
    LONG (__cs3_region_init_ram)
    LONG (__cs3_region_start_ram)
    LONG (__cs3_region_init_size_ram)
    LONG (__cs3_region_zero_size_ram)
    __cs3_regions_end = .;
    . = ALIGN (8);
    _etext = .;
  } >ram

  ASSERT (!(__cs3_region_init_flexnvm & 7), "__cs3_region_init_flexnvm not aligned")
  ASSERT (!(__cs3_region_start_flexnvm & 7), "__cs3_region_start_flexnvm not aligned")
  ASSERT (!(__cs3_region_init_size_flexnvm & 7), "__cs3_region_init_size_flexnvm not aligned")
  ASSERT (!(__cs3_region_zero_size_flexnvm & 7), "__cs3_region_zero_size_flexnvm not aligned")
  ASSERT (!(__cs3_region_init_flexram & 7), "__cs3_region_init_flexram not aligned")
  ASSERT (!(__cs3_region_start_flexram & 7), "__cs3_region_start_flexram not aligned")
  ASSERT (!(__cs3_region_init_size_flexram & 7), "__cs3_region_init_size_flexram not aligned")
  ASSERT (!(__cs3_region_zero_size_flexram & 7), "__cs3_region_zero_size_flexram not aligned")
  ASSERT (!(__cs3_region_init_ram & 7), "__cs3_region_init_ram not aligned")
  ASSERT (!(__cs3_region_start_ram & 7), "__cs3_region_start_ram not aligned")
  ASSERT (!(__cs3_region_init_size_ram & 7), "__cs3_region_init_size_ram not aligned")
  ASSERT (!(__cs3_region_zero_size_ram & 7), "__cs3_region_zero_size_ram not aligned")
  .cs3.rom : ALIGN (8)
  {
    __cs3_region_start_rom = .;
    *(.cs3.region-head.rom)
    *(.rom)
    . = ALIGN (8);
  } >rom
  .cs3.rom.bss :
  {
    *(.rom.b .bss.rom)
    . = ALIGN (8);
  } >rom
  /* __cs3_region_end_rom is deprecated */
  __cs3_region_end_rom = __cs3_region_start_rom + LENGTH(rom);
  __cs3_region_size_rom = LENGTH(rom);
  __cs3_region_init_rom = LOADADDR (.cs3.rom);
  __cs3_region_init_size_rom = LOADADDR (.cs3.rom.bss) - LOADADDR (.cs3.rom);
  __cs3_region_zero_size_rom = SIZEOF(.cs3.rom.bss);

  .cs3.flexnvm : ALIGN (8)
  {
    __cs3_region_start_flexnvm = .;
    *(.cs3.region-head.flexnvm)
    *(.flexnvm)
    . = ALIGN (8);
  } >flexnvm
  .cs3.flexnvm.bss :
  {
    *(.flexnvm.b .bss.flexnvm)
    . = ALIGN (8);
  } >flexnvm
  /* __cs3_region_end_flexnvm is deprecated */
  __cs3_region_end_flexnvm = __cs3_region_start_flexnvm + LENGTH(flexnvm);
  __cs3_region_size_flexnvm = LENGTH(flexnvm);
  __cs3_region_init_flexnvm = LOADADDR (.cs3.flexnvm);
  __cs3_region_init_size_flexnvm = LOADADDR (.cs3.flexnvm.bss) - LOADADDR (.cs3.flexnvm);
  __cs3_region_zero_size_flexnvm = SIZEOF(.cs3.flexnvm.bss);

  .cs3.flexram : ALIGN (8)
  {
    __cs3_region_start_flexram = .;
    *(.cs3.region-head.flexram)
    *(.flexram)
    . = ALIGN (8);
  } >flexram
  .cs3.flexram.bss :
  {
    *(.flexram.b .bss.flexram)
    . = ALIGN (8);
  } >flexram
  /* __cs3_region_end_flexram is deprecated */
  __cs3_region_end_flexram = __cs3_region_start_flexram + LENGTH(flexram);
  __cs3_region_size_flexram = LENGTH(flexram);
  __cs3_region_init_flexram = LOADADDR (.cs3.flexram);
  __cs3_region_init_size_flexram = LOADADDR (.cs3.flexram.bss) - LOADADDR (.cs3.flexram);
  __cs3_region_zero_size_flexram = SIZEOF(.cs3.flexram.bss);

  .cs3.gpio :
  {
    __cs3_region_start_gpio = .;
    *(.cs3.region-head.gpio)
    . = ALIGN (8);
  } >gpio
  /* __cs3_region_end_gpio is deprecated */
  __cs3_region_end_gpio = __cs3_region_start_gpio + LENGTH(gpio);
  __cs3_region_size_gpio = LENGTH(gpio);

  .cs3.io :
  {
    __cs3_region_start_io = .;
    *(.cs3.region-head.io)
    . = ALIGN (8);
  } >io
  /* __cs3_region_end_io is deprecated */
  __cs3_region_end_io = __cs3_region_start_io + LENGTH(io);
  __cs3_region_size_io = LENGTH(io);

  .data : ALIGN (8)
  {
    *(.got.plt) *(.got)
    *(.shdata)
    *(.data .data.* .gnu.linkonce.d.*)
    . = ALIGN (8);
    *(.ram)
    . = ALIGN (8);
    _edata = .;
  } >ram
  .bss : ALIGN (8)
  {
    *(.shbss)
    *(.bss .bss.* .gnu.linkonce.b.*)
    *(COMMON)
    . = ALIGN (8);
    *(.ram.b .bss.ram)
    . = ALIGN (8);
    _end = .;
    __end = .;
  } >ram
  /* __cs3_region_end_ram is deprecated */
  __cs3_region_end_ram = __cs3_region_start_ram + LENGTH(ram);
  __cs3_region_size_ram = LENGTH(ram);
  __cs3_region_init_ram = LOADADDR (.text);
  __cs3_region_init_size_ram = _edata - ADDR (.text);
  __cs3_region_zero_size_ram = _end - _edata;

  .stab 0 (NOLOAD) : { *(.stab) }
  .stabstr 0 (NOLOAD) : { *(.stabstr) }
  /* DWARF debug sections.
   * Symbols in the DWARF debugging sections are relative to
   * the beginning of the section so we begin them at 0.
   */
  /* DWARF 1 */
  .debug          0 : { *(.debug) }
  .line           0 : { *(.line) }
  /* GNU DWARF 1 extensions */
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  /* DWARF 1.1 and DWARF 2 */
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  /* DWARF 2 */
  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
  .debug_abbrev   0 : { *(.debug_abbrev) }
  .debug_line     0 : { *(.debug_line) }
  .debug_frame    0 : { *(.debug_frame) }
  .debug_str      0 : { *(.debug_str) }
  .debug_loc      0 : { *(.debug_loc) }
  .debug_macinfo  0 : { *(.debug_macinfo) }
  /* DWARF 2.1 */
  .debug_ranges   0 : { *(.debug_ranges) }
  /* SGI/MIPS DWARF 2 extensions */
  .debug_weaknames 0 : { *(.debug_weaknames) }
  .debug_funcnames 0 : { *(.debug_funcnames) }
  .debug_typenames 0 : { *(.debug_typenames) }
  .debug_varnames  0 : { *(.debug_varnames) }
}
/* checksum: fa0754efe7b1dd74e6ae */
