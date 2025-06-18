#-------------------------------------------------------------------------------#
#																			    #
#							POC-arm_bootloader								    #
#																			    #
#-------------------------------------------------------------------------------#

#-Variables---------------------------------------------------------------------#

TARGET			:= boot
BIN				:= $(TARGET).bin
ELF				:= $(TARGET).elf

ASM_SRC			:= $(TARGET).s

LINKER			:= arm-none-eabi-ld
LD_SCRIPT		:= linker.ld

ASM_OBJ			:= $(ASM_SRC:.s=.o)

CC				:= arm-none-eabi-gcc

OBJCOPY			:= arm-none-eabi-objcopy

OBJCOPY_FLAGS 	:= -O binary	
																			
CFLAGS			:= -ffreestanding -nostdlib -g

QEMU			:= qemu-system-arm

QEMU_FLAGS 		:= -M stm32-p103 -nographic -serial stdio -bios

#-Rules------------------------------------------------------------------------#

all:$(BIN)

$(ASM_OBJ): $(ASM_SRC)
	$(CC) $(CFLAGS) -c $< -o $@

$(ELF): $(ASM_OBJ)
	$(LINKER) -T $(LD_SCRIPT) -o $@ $(ASM_OBJ)

$(BIN): $(ELF)
	$(OBJCOPY) $(OBJCOPY_FLAGS) $< $@

run: $(BIN)
	$(QEMU) $(QEMU_FLAGS) $< -D qemu.log

clean:
	rm -f $(ASM_OBJ) $(ELF) $(BIN)

#------------------------------------------------------------------------------#
