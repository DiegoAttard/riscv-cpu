# riscv-cpu

## A simple RISC-V CPU created in SystemVerilog.

This project is a from-scratch implementation of a 32-bit RISC-V CPU based on the RV32I instruction set architecture. It was made as a personal project to gain a deeper understanding of computer architecture, digital design and hardware description languages.

### Included Modules

* Program Counter (PC)
* Instruction Memory
* Data Memory
* Register File
* ALU (Arithmetic Logic Unit)
* Control Unit
* Immediate Generator
* Datapath
* Testbench for the Datapath

### Features

* RV32I instruction support
* ALU operations (add, sub, and, or, sll, addi, etc.)
* Branch and Jump support
* Load/Store support
* Modular design
* Testbench with waveform output ('.vcd')
* Python instruction encoder included for testing the design

### Definitions File

A definitions file (`cpu_def.sv`) is used to ensure consistency across all modules and stores constants such as:

* Opcode values (`OPCODE_RTYPE`, `OPCODE_ITYPE`, etc.)
* 'funct3' and 'funct7' codes for specific instructions
* ALU operation codes
