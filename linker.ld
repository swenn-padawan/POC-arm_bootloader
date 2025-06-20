/*Little Explanation of all the sections:
 * - .text for code & constants
 * - .bss for unitialized data
 * - .stack for our stack
 * - .data for initialized data
 * */

ENTRY(Reset_Handler)

MEMORY
{
	FLASH	(rx)	: ORIGIN = 0x08000000, LENGTH = 64K /* change the size by 512K if NUCLEO-F446RE */
	RAM		(rwx)	: ORIGIN = 0x20000000, LENGTH = 20K	/* same but by 128K */
}

SECTIONS
{
	.text : ALIGN(4)
	{
		KEEP(*(.vector*))			/*KEEP is here to say: "keep this sections even if nobody use it" *(.vector) to select all the sections starting with .vector*/
		*(.text*)
	} > FLASH

	.bss (NOLOAD) :					/*NOLOAD to tell to not load the data (because it's all empty)*/
	{
		*(.bss*)
		*(COMMON)					/*COMMON is where the compiler put global*/
	} > RAM

	.stack (NOLOAD) :
	{
		. = ALIGN(8);
		_stack_start = .;
		. += 0x1000; /* 4ko */
		_stack_end = .;
	} > RAM

	.data :
	{
		*(.data*);
	} > RAM AT > FLASH				/* "> ram" is the VMA, "> rom" is the LMA */
}
