_estack = 0x20002000;

MEMORY
{
	rom (rx) : ORIGIN = 0x08000000, LENGTH = 1024K
	ram (rwx) : ORIGIN = 0x20000000, LENGTH = 128K
}
/* dont use ccmram */

SECTIONS
{
    .text : 				/* Define output file TEXT section */
    {
        *(.vectors) 			/* Vector table */
        *(.text)      			/* Program code */
		. = ALIGN(4);		/* Make sure data that follows are aligned to 4 byte boundary */
		*(.rodata)		/* Read only, section set asside for constants */
    } >rom
	
	
	.data :				/* Define output file DATA section */
	{
		_data_start = .;	/* Get the memory address (VMA) for start of section .data */
		*(.data)		/* Initialized static and global variable values */
		. = ALIGN(4); 
		_data_end = .;		/* Get the memory address (VMA) for end of section .data */
	} >ram AT >rom			/* After AT we specify the load-time location */
	
	_data_load = LOADADDR(.data);	/* Get the load memory address (LMA) for section .data */
	
	
	.bss :				/* Define output file BSS section */
	{
		_bss_start = .;		/* Get memory address of start of bss section */
		*(.bss)			/* Uninitialized static and global variables */
		*(COMMON)		/* Uninitialized variables are placed in COMMON section for object files */
		. = ALIGN(4);	
		_bss_end = .;		/* Get memory address of end of bss section */
	} >ram
}  