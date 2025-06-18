#-------------------------------------------------------------------------------#
#																			    #
#							POC-arm_bootloader								    #
#																			    #
#-------------------------------------------------------------------------------#

#-Variables---------------------------------------------------------------------#
                                                                                #
ASM_SRC		:= boot.s														    #
																			    #
LINKER		:= linker.ld                     								    # 
																			    #
ASM_OBJ		:= $(addprefix $(ASM_SRC)/, $(ASM_SRC:%.s=%.o))					    # This line takes all the .s and replace them with .o
																				# and stored them in ASM_OBJ
CC			:= arm-none-eabi-gcc												#
																				#
CFLAGS		:= -ffreestanding -nostdlib -g										# -ffrestanding to indicate that we are not in an OS
																				# -nostdlib indicates tonot link with the standards libs
																				# -g for debug
																				#
QEMU		:= qemu-system-arm													# qemu for ARM system
																				#
QEMU_FLAGS = -M stm32-p103 -nographic -serial stdio -bios #bin					# -M <machine to emulate>
																				# -nographic redirect the output to the terminal
																				# -serial stdio redirect the UART to the terminal 





#-Rules------------------------------------------------------------------------#

