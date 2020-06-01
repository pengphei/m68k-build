project (m5282lite)

cmake_minimum_required (VERSION 3.1)
set(target m5282lite)

# 添加link script
set(TOOLDIR /home/kurain/build/m68k-build/tools/m68k-elf/bin)
set(LDSCRIPT "m5282evb-ram.ld")
set(MCUFLAGS -m528x)
set(OPTFLAGS -O0)
set(LIBDIR )

#######################################
# 设置编译器
#######################################
# 开启汇编
ENABLE_LANGUAGE(ASM C CXX)

# 设置目标平台系统
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR m68k)

# 设置交叉编译器
set(CMAKE_C_COMPILER ${TOOLDIR}/m68k-elf-gcc)
set(CMAKE_ASM_COMPILER ${TOOLDIR}/mm68k-elf-gcc -x assembler-with-cpp)
set(CMAKE_CXX_COMPILER ${TOOLDIR}/mm68k-elf-g++)
#SET(CMAKE_FIND_ROOT_PATH "/opt/gccStm32/")
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

SET(CMAKE_CXX_FLAGS "-O3 -Wall -Wunused-function -fpermissive")
SET(CMAKE_C_FLAGS "-O3 -Wall -Wunused-function --std=gnu99")

include_directories(inc)

aux_source_directory(src mainsrc)

set(CMAKE_C_EXTENSIONS 
    $(MCUFLAGS)
    -fno-builtin
    $(OPTFLAGS)
    -Wall
    -std=gnu99
    -g
    -fomit-frame-pointer 
    -fdata-sections
    -ffreestanding
    -ffunction-sections
    -Wstrict-prototypes
    -fverbose-asm	
    )
set(CMAKE_CXX_EXTENSIONS 
    $(MCUFLAGS)
    -fno-builtin
    $(OPTFLAGS)
    -Wall
    -std=c++11
    -fdata-sections
    -ffunction-sections
    )
set(CMAKE_ASM_FLAGS 
    $(MCUFLAGS)
    )

# 这是LDFLAGS
set(CMAKE_EXE_LINKER_FLAGS 
    ${MCUFLAGS}
    -T$(LDSCRIPT)
    -fno-builtin
    -ffreestanding
    -nostdinc
    -Wl,-Map=$(PROJECT).map,--cref,--no-warn-mismatch
    ${LIBDIR}
    )


# 添加可执行文件（可执行文件名 [配置] 源文件）
add_executable(${target} ${mainsrc})