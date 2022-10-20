# baremetal arm
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# compu=iler and utils
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_LINKER arm-none-eabi-ld)
set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP arm-none-eabi-objdump)
set(CMAKE_NM arm-none-eabi-nm)

# test compile fails, so don't even try. Build a static lib instead!
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Remove default static libraries for win32. 
# TODO: is it necessary with -nostdlib?
set(CMAKE_C_STANDARD_LIBRARIES "")

macro(add_arm_executable target_name)

# Output files
set(elf_file ${target_name}.elf)
set(map_file ${target_name}.map)
set(hex_file ${target_name}.hex)
set(bin_file ${target_name}.bin)
set(lss_file ${target_name}.lss)
set(dmp_file ${target_name}.dmp)

add_executable(${elf_file} ${ARGN})

#generate hex file
add_custom_command(
	OUTPUT ${hex_file}

	COMMAND
		${CMAKE_OBJCOPY} -O ihex ${elf_file} ${hex_file}

	DEPENDS ${elf_file}
)

# #generate bin file
add_custom_command(
	OUTPUT ${bin_file}

	COMMAND
		${CMAKE_OBJCOPY} -O binary ${elf_file} ${bin_file}

	DEPENDS ${elf_file}
)

# #generate extended listing
add_custom_command(
	OUTPUT ${lss_file}

	COMMAND
		${CMAKE_OBJDUMP} -h -S ${elf_file} > ${lss_file}

	DEPENDS ${elf_file}
)

# #generate memory dump
add_custom_command(
	OUTPUT ${dmp_file}

	COMMAND
		${CMAKE_OBJDUMP} -x --syms ${elf_file} > ${dmp_file}

	DEPENDS ${elf_file}
)

#postprocessing from elf file - generate hex bin etc.
add_custom_target(
	${CMAKE_PROJECT_NAME}
	ALL
	DEPENDS ${hex_file} ${bin_file} ${lss_file} ${dmp_file}
)

set_target_properties(
	${CMAKE_PROJECT_NAME}

	PROPERTIES
		OUTPUT_NAME ${elf_file}
)

endmacro(add_arm_executable)

macro(arm_link_libraries target_name)

target_link_libraries(${target_name}.elf ${ARGN})

endmacro(arm_link_libraries)