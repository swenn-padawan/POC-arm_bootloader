# POC-arm_bootloader

Minimal AArch32 bootloader for STM32-based embedded systems.  
This Proof of Concept demonstrates low-level bare-metal initialization on a 32-bit ARM Cortex-M microcontroller.  
It sets up the stack, configures hardware peripherals, and executes a basic payload — all without an operating system.

## Setup

Before writing a single line of code, we need to prepare our development environment.

We'll use **QEMU** to emulate the STM32 board and test our bootloader without flashing a physical device — ideal for rapid iteration and debugging.

Additionally, I plan to use **Nix flakes** (with help from ChatGPT) to ensure a reproducible setup across all operating systems and machines, with the necessary toolchains and dependencies installed automatically.

Since most machines aren't ARM-based, we'll need a cross-compiler to run our ARM code on an x86 system. I won't go into the theory behind it...

### 🧰 Why Nix?

Setting up a cross-compilation environment for bare-metal ARM can be a pain — especially when you're working on different machines or in a school environment with missing packages.
Different platforms, toolchain versions, and missing dependencies all add unnecessary friction to the process.

Nix solves that by creating a reproducible, declarative environment.
It ensures that anyone can build and test this bootloader on any machine (Linux, macOS, etc.) with exactly the same tools and versions.

#### 📦 What it does

The Nix setup in this repo:

- Installs an ARM bare-metal cross-compiler (like arm-none-eabi-gcc)
- Installs QEMU to run the bootloader without real hardware
- Installs build tools like make, nasm, or others if needed
- Works with Nix Flakes for better reproducibility

#### 🚀Usage
To launch our setup you just have to copy my flake.nix and run this command:
```bash
nix develop
```

##### Help to install nix
Run this command to install nix
```bash
sh <(curl -L https://nixos.org/nix/install)
```
Once installed, you can restart your session or run:
```bash
. /etc/profile.d/nix.sh
```
When you are going to run `nix develop`, you can encounter an error that tells to enable experimental-features.
To prevent this, you can run:
```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```
It will had the nix-command and flakes features by default.

GG! Now you have a functionnal shell with all the packages required !

### 🛠️ Makefile

A Makefile automates the compilation steps so you don’t have to write long commands every time.
I won’t go into the details of how Makefiles work, but if you’re serious about low-level development, you should definitely learn it.

To build and run the bootloader, simply run:
```bash
make && make run
```

This will:
- assemble the code
- link it using the linker script
- generate a .bin file
- and launch it in QEMU using the make run command

That's all you need to get your bootloader up and running in an emulator.

### 🛠️ Compilation steps

Let’s go through the compilation process — for your understanding and mine.
#### 🔗 Linker

Without an operating system, you must explicitly tell the linker where to place each section of your program (.text, .data, .bss, etc.).

For instance, the .text section might start at 0x08000000 (STM32 flash memory), or at 0x00000000 when running on QEMU.

That means you fully control the memory layout — because there’s no OS to do it for you.
#### 📦 ELF (Executable and Linkable Format)

The compiler first generates an object file (.o). Then the linker uses your .ld script to produce an .elf file — a complete binary with sections, symbols, and metadata.

This .elf file can be used:

- to run the program in QEMU,
- or to inspect it with tools like readelf, objdump, or gdb.

### 💾 .BIN file (raw firmware)

The .bin file is a raw binary image — it contains nothing but the bytes that will be loaded into flash memory.

You generate it from the .elf using objcopy, like so:
```bash
arm-none-eabi-objcopy -O binary boot.elf boot.bin
```
This file is what you'd flash onto real hardware.
You can:

- run the .elf in QEMU (for debugging),
- or flash the .bin to your STM32 board.

We can now code our bootloader (but no ASM yet :) )
















