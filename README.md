# RISC-V CPU

32-bit RISC-V CPU written in SystemVerilog.

The design currently uses a 5-stage pipeline:

```text
IF → ID → EX → MEM → WB
```

Pipeline registers are used between each stage:

- `IF_ID_Register.sv`
- `ID_EX_Register.sv`
- `EX_MEM_Register.sv`
- `MEM_WB_Register.sv`

With a forwarding unit which is used to handle RAW dependencies by forwarding values from the MEM and WB stages back to the EX stage.

## Supported Instructions

### Arithmetic / Logic

`ADD`, `SUB`, `XOR`, `OR`, `AND`, `SLL`, `SRL`, `SRA`, `SLT`, `SLTU`

### Immediate

`ADDI`, `XORI`, `ORI`, `ANDI`, `SLLI`, `SRLI`, `SRAI`, `SLTI`, `SLTIU`

### Loads

`LB`, `LH`, `LW`, `LBU`, `LHU`

### Stores

`SB`, `SH`, `SW`

### Branches

`BEQ`, `BNE`, `BLT`, `BGE`, `BLTU`, `BGEU`

### Other

`JAL`, `JALR`, `LUI`, `AUIPC`, `ECALL`, `EBREAK`

## Main Files

- `Datapath.sv` - main CPU datapath
- `ControlUnit.sv` - instruction decoding and control signals
- `ALU.sv` - arithmetic, logic, shifts, and comparisons
- `RegisterFile.sv` - general-purpose registers
- `InstructionMemory.sv` - instruction memory
- `DataMemory.sv` - load/store memory
- `ImmediateGenerator.sv` - immediate generation
- `ForwardingUnit.sv` - RAW hazard forwarding logic
- `cpu_defs.sv` - shared constants and instruction definitions
- `Instruction_Encoder.py` - converts instructions into machine code for testing
- `Datapath_tb.sv` - ModelSim testbench

## Simulation

The CPU was tested using ModelSim by loading machine code programs into instruction memory and checking the register file, data memory, pipeline signals, ALU results, and forwarding signals in the waveform viewer.
