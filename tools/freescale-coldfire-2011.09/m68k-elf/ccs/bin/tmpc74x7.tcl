set ppc_core_regs(core) {{r0 2000}  {r1 2001} {r2 2002} {r3 2003} {r4 2004} {r5 2005} {r6 2006} {r7 2007} {r8 2008} {r9 2009} {r10 2010} {r11 2011} {r12 2012} {r13 2013} {r14 2014} {r15 2015} {r16 2016} {r17 2017} {r18 2018} {r19 2019} {r20 2020} {r21 2021} {r22 2022} {r23 2023} {r24 2024} {r25 2025} {r26 2026} {r27 2027} {r28 2028} {r29 2029} {r30 2030} {r31 2031} {ibat0u 528} {ibat0l 529} {ibat1u 530} {ibat1l 531} {ibat2u 532} {ibat2l 533} {ibat3u 534} {ibat3l 535} {ibat4u 560} {ibat4l 561} {ibat5u 562} {ibat5l 563} {ibat6u 564} {ibat6l 565} {ibat7u 566} {ibat7l 567} {dbat0u 536} {dbat0l 537} {dbat1u 538} {dbat1l 539} {dbat2u 540} {dbat2l 541} {dbat3u 542} {dbat3l 543} {dbat4u 568} {dbat4l 569} {dbat5u 570} {dbat5l 571} {dbat6u 572} {dbat6l 573} {dbat7u 574} {dbat7l 575} {fpscr 3032} {iar 2032} {msr 2034} {cr 2033} {pvr 287} {xer 1} {lr 8} {ctr 9} {dsisr 18} {dar 19} {dec 22} {sdr1 25} {srr0 26} {srr1 27} {vrsave 256} {tbl 268} {tbu 269} {sprg0 272} {sprg1 273} {sprg2 274} {sprg3 275} {sprg4 276} {sprg5 277} {sprg6 278} {sprg7 279} {ear 282} {tlbdmiss 980} {ptehi 981} {ptelo 982} {l3pm 983} {l3itcr0 984} {l3ohcr 1000} {l3itcr1 1001} {l3itcr2 1002} {l3itcr3 1003} {hid0 1008} {hid1 1009} {iabr 1010} {ictrl 1011} {dabr 1013} {msscr0 1014} {msssr0 1015} {ldstcr 1016} {l2cr 1017} {l3cr 1018} {ictc 1019} {pir 1023} {sr0 1100} {sr1 1101} {sr2 1102} {sr3 1103} {sr4 1104} {sr5 1105} {sr6 1106} {sr7 1107} {sr8 1108} {sr9 1109} {sr10 1110} {sr11 1111} {sr12 1112} {sr13 1113} {sr14 1114} {sr15 1115}}

set core_regs(core) {}

foreach mreg $ppc_core_regs(core) {
	addreg [lindex $mreg 0] [lindex $mreg 1]
	lappend core_regs(core) [lindex $mreg 0]
}

set Stat(inst) 2
set Stat(icnt) 6
set Stat(vname) ppc
set Stat(core) "PowerPc"
set Stat(reg)  {iar msr srr0 srr1 iabr}
set Stat(size) {8  8  8  8  8}
set    Stat(fmt) { iar $fmt(iar)\t  msr $fmt(msr)\t  srr0 $fmt(srr0)\t  srr1 $fmt(srr1)\n}
append Stat(fmt) { iabr $fmt(iabr)}
