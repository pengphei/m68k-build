/* Linker script for Freescale M5249C3 Eval
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
GROUP(-lgcc -lc -lcs3 -lcs3unhosted -lcs3coldfire)

MEMORY
{
  ram (rwx) : ORIGIN = 0x00000000, LENGTH = 4M
  rambar0 (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
  rambar1 (rwx) : ORIGIN = 0x20010000, LENGTH = 32K
  rom (rx) : ORIGIN = 0xFFE00000, LENGTH = 2M
  mbar (rw) : ORIGIN = 0x10000000, LENGTH = 0x500
  mbar2 (rw) : ORIGIN = 0x80000000, LENGTH = 0x500
}

/* These force the linker to search for particular symbols from
 * the start of the link process and thus ensure the user's
 * overrides are picked up
 */
EXTERN(__cs3_reset __cs3_reset_m5249c3_ram)
EXTERN(__cs3_start_asm _start)
/* Bring in the interrupt routines & vector */
INCLUDE coldfire-names.inc
EXTERN(__cs3_interrupt_vector_coldfire)
EXTERN(__cs3_start_c main __cs3_stack __cs3_heap_end)

/* Provide fall-back values */
PROVIDE(__cs3_heap_start = _end);
PROVIDE(__cs3_heap_end = __cs3_region_start_ram + __cs3_region_size_ram);
PROVIDE(__cs3_region_num = (__cs3_regions_end - __cs3_regions) / 20);
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

    PROVIDE(__cs3_reset = __cs3_reset_m5249c3_ram);
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
    LONG (__cs3_region_init_ram)
    LONG (__cs3_region_start_ram)
    LONG (__cs3_region_init_size_ram)
    LONG (__cs3_region_zero_size_ram)
    LONG (0)
    LONG (__cs3_region_init_rambar0)
    LONG (__cs3_region_start_rambar0)
    LONG (__cs3_region_init_size_rambar0)
    LONG (__cs3_region_zero_size_rambar0)
    LONG (0)
    LONG (__cs3_region_init_rambar1)
    LONG (__cs3_region_start_rambar1)
    LONG (__cs3_region_init_size_rambar1)
    LONG (__cs3_region_zero_size_rambar1)
    __cs3_regions_end = .;
    . = ALIGN (8);
    _etext = .;
  } >ram

  ASSERT (!(__cs3_region_init_ram & 7), "__cs3_region_init_ram not aligned")
  ASSERT (!(__cs3_region_start_ram & 7), "__cs3_region_start_ram not aligned")
  ASSERT (!(__cs3_region_init_size_ram & 7), "__cs3_region_init_size_ram not aligned")
  ASSERT (!(__cs3_region_zero_size_ram & 7), "__cs3_region_zero_size_ram not aligned")
  ASSERT (!(__cs3_region_init_rambar0 & 7), "__cs3_region_init_rambar0 not aligned")
  ASSERT (!(__cs3_region_start_rambar0 & 7), "__cs3_region_start_rambar0 not aligned")
  ASSERT (!(__cs3_region_init_size_rambar0 & 7), "__cs3_region_init_size_rambar0 not aligned")
  ASSERT (!(__cs3_region_zero_size_rambar0 & 7), "__cs3_region_zero_size_rambar0 not aligned")
  ASSERT (!(__cs3_region_init_rambar1 & 7), "__cs3_region_init_rambar1 not aligned")
  ASSERT (!(__cs3_region_start_rambar1 & 7), "__cs3_region_start_rambar1 not aligned")
  ASSERT (!(__cs3_region_init_size_rambar1 & 7), "__cs3_region_init_size_rambar1 not aligned")
  ASSERT (!(__cs3_region_zero_size_rambar1 & 7), "__cs3_region_zero_size_rambar1 not aligned")
  .cs3.rambar0 : ALIGN (8)
  {
    __cs3_region_start_rambar0 = .;
    *(.cs3.region-head.rambar0)
    *(.rambar0)
    . = ALIGN (8);
  } >rambar0
  .cs3.rambar0.bss :
  {
    *(.rambar0.b .bss.rambar0)
    . = ALIGN (8);
  } >rambar0
  /* __cs3_region_end_rambar0 is deprecated */
  __cs3_region_end_rambar0 = __cs3_region_start_rambar0 + LENGTH(rambar0);
  __cs3_region_size_rambar0 = LENGTH(rambar0);
  __cs3_region_init_rambar0 = LOADADDR (.cs3.rambar0);
  __cs3_region_init_size_rambar0 = LOADADDR (.cs3.rambar0.bss) - LOADADDR (.cs3.rambar0);
  __cs3_region_zero_size_rambar0 = SIZEOF(.cs3.rambar0.bss);

  .cs3.rambar1 : ALIGN (8)
  {
    __cs3_region_start_rambar1 = .;
    *(.cs3.region-head.rambar1)
    *(.rambar1)
    . = ALIGN (8);
  } >rambar1
  .cs3.rambar1.bss :
  {
    *(.rambar1.b .bss.rambar1)
    . = ALIGN (8);
  } >rambar1
  /* __cs3_region_end_rambar1 is deprecated */
  __cs3_region_end_rambar1 = __cs3_region_start_rambar1 + LENGTH(rambar1);
  __cs3_region_size_rambar1 = LENGTH(rambar1);
  __cs3_region_init_rambar1 = LOADADDR (.cs3.rambar1);
  __cs3_region_init_size_rambar1 = LOADADDR (.cs3.rambar1.bss) - LOADADDR (.cs3.rambar1);
  __cs3_region_zero_size_rambar1 = SIZEOF(.cs3.rambar1.bss);

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

  .cs3.mbar :
  {
    __cs3_region_start_mbar = .;
    *(.cs3.region-head.mbar)
    . = ALIGN (8);
  } >mbar
  /* __cs3_region_end_mbar is deprecated */
  __cs3_region_end_mbar = __cs3_region_start_mbar + LENGTH(mbar);
  __cs3_region_size_mbar = LENGTH(mbar);

  .cs3.mbar2 :
  {
    __cs3_region_start_mbar2 = .;
    *(.cs3.region-head.mbar2)
    . = ALIGN (8);
  } >mbar2
  /* __cs3_region_end_mbar2 is deprecated */
  __cs3_region_end_mbar2 = __cs3_region_start_mbar2 + LENGTH(mbar2);
  __cs3_region_size_mbar2 = LENGTH(mbar2);

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
/* checksum: 5640d3041f521c6724874478 */
