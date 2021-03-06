/* Linker script for Freescale M5275EVB
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
  ram (rwx) : ORIGIN = 0x00000000, LENGTH = 16M
  rambar (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
  rom (rx) : ORIGIN = 0xFFE00000, LENGTH = 2M
  ipsbar (rw) : ORIGIN = 0x40000000, LENGTH = 0x200000
}

/* These force the linker to search for particular symbols from
 * the start of the link process and thus ensure the user's
 * overrides are picked up
 */
EXTERN(__cs3_reset __cs3_reset_m5275evb)
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
    __cs3_region_start_rom = .;
    _ftext = .;
    *(.cs3.region-head.rom)
    ASSERT (. == __cs3_region_start_rom, ".cs3.region-head.rom not permitted");
    __cs3_interrupt_vector = __cs3_interrupt_vector_coldfire;
    *(.cs3.interrupt_vector)
    /* Make sure we pulled in an interrupt vector.  */
    ASSERT (. != __cs3_interrupt_vector_coldfire, "No interrupt vector");

    PROVIDE(__cs3_reset = __cs3_reset_m5275evb);
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
  } >rom
  .eh_frame_hdr : ALIGN (4)
  {
    KEEP (*(.eh_frame_hdr))
  } >rom
  .eh_frame : ALIGN (4)
  {
    KEEP (*(.eh_frame))
  } >rom
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
    LONG (__cs3_region_init_rambar)
    LONG (__cs3_region_start_rambar)
    LONG (__cs3_region_init_size_rambar)
    LONG (__cs3_region_zero_size_rambar)
    __cs3_regions_end = .;
    . = ALIGN (8);
    *(.rom)
    *(.rom.b .bss.rom)
    _etext = .;
  } >rom
  /* __cs3_region_end_rom is deprecated */
  __cs3_region_end_rom = __cs3_region_start_rom + LENGTH(rom);
  __cs3_region_size_rom = LENGTH(rom);

  ASSERT (!(__cs3_region_init_ram & 7), "__cs3_region_init_ram not aligned")
  ASSERT (!(__cs3_region_start_ram & 7), "__cs3_region_start_ram not aligned")
  ASSERT (!(__cs3_region_init_size_ram & 7), "__cs3_region_init_size_ram not aligned")
  ASSERT (!(__cs3_region_zero_size_ram & 7), "__cs3_region_zero_size_ram not aligned")
  ASSERT (!(__cs3_region_init_rambar & 7), "__cs3_region_init_rambar not aligned")
  ASSERT (!(__cs3_region_start_rambar & 7), "__cs3_region_start_rambar not aligned")
  ASSERT (!(__cs3_region_init_size_rambar & 7), "__cs3_region_init_size_rambar not aligned")
  ASSERT (!(__cs3_region_zero_size_rambar & 7), "__cs3_region_zero_size_rambar not aligned")
  .cs3.rambar : ALIGN (8)
  {
    __cs3_region_start_rambar = .;
    *(.cs3.region-head.rambar)
    *(.rambar)
    . = ALIGN (8);
  } >rambar AT>rom
  .cs3.rambar.bss :
  {
    *(.rambar.b .bss.rambar)
    . = ALIGN (8);
  } >rambar AT>rom
  /* __cs3_region_end_rambar is deprecated */
  __cs3_region_end_rambar = __cs3_region_start_rambar + LENGTH(rambar);
  __cs3_region_size_rambar = LENGTH(rambar);
  __cs3_region_init_rambar = LOADADDR (.cs3.rambar);
  __cs3_region_init_size_rambar = LOADADDR (.cs3.rambar.bss) - LOADADDR (.cs3.rambar);
  __cs3_region_zero_size_rambar = SIZEOF(.cs3.rambar.bss);

  .cs3.ipsbar :
  {
    __cs3_region_start_ipsbar = .;
    *(.cs3.region-head.ipsbar)
    . = ALIGN (8);
  } >ipsbar
  /* __cs3_region_end_ipsbar is deprecated */
  __cs3_region_end_ipsbar = __cs3_region_start_ipsbar + LENGTH(ipsbar);
  __cs3_region_size_ipsbar = LENGTH(ipsbar);

  .data : ALIGN (8)
  {
    __cs3_region_start_ram = .;
    *(.cs3.region-head.ram)
    *(.got.plt) *(.got)
    *(.shdata)
    *(.data .data.* .gnu.linkonce.d.*)
    . = ALIGN (8);
    *(.ram)
    . = ALIGN (8);
    _edata = .;
  } >ram AT>rom
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
  } >ram AT>rom
  /* __cs3_region_end_ram is deprecated */
  __cs3_region_end_ram = __cs3_region_start_ram + LENGTH(ram);
  __cs3_region_size_ram = LENGTH(ram);
  __cs3_region_init_ram = LOADADDR (.data);
  __cs3_region_init_size_ram = _edata - ADDR (.data);
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
/* checksum: 512a63466955ec556e65a4 */
