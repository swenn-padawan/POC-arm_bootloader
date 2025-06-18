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











