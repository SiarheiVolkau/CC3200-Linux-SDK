/*****************************************************************************
*
* cc3200r1m2.ld
*
* GCC Linker script for cc3200 chips with 256k SRAM.
*
******************************************************************************/

/* Used by bootloader, can be used after load finished i.e. for heap */
BOOTLOADER_SIZE = 16K;

MEMORY
{
	SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 256K
}

SECTIONS
{
	.bootloader :
	{
		_heap2 = .;
		. = . + BOOTLOADER_SIZE;
		. = ALIGN(8);
		_eheap2 = .;
	} > SRAM

	.text :
	{
		_text = .;
		KEEP(*(.intvecs))
		*(.text*)
		*(.rodata*)
		*(.ARM.extab* .gnu.linkonce.armextab.*)
		. = ALIGN(8);
		_etext = .;
	} > SRAM

	.ARM : {
		__exidx_start = .;
		*(.ARM.exidx*)
		__exidx_end = .;
	} > SRAM

	__init_data = .;

	.data : AT(__init_data)
	{
		_data = .;
		*(.data*)
		. = ALIGN (8);
		_edata = .;
	} > SRAM

	.bss :
	{
		_bss = .;
		*(.bss*)
		*(COMMON)
		_ebss = .;
	} > SRAM

	.heap :
	{
		_heap = .;
		. = . +LENGTH(SRAM) - SIZEOF(.bss)
							- SIZEOF(.data)
							- SIZEOF(.ARM)
							- SIZEOF(.text)
							- SIZEOF(.bootloader);
		_eheap = .;
	} > SRAM
}

