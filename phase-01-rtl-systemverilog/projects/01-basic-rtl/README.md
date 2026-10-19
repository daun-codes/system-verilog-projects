# Basic RTL Design and Processor Integration

## Overview

This project demonstrates fundamental Register Transfer Level (RTL) design using SystemVerilog. It progresses from basic combinational and sequential logic to the integration of an Arithmetic Logic Unit (ALU), a register file, and a finite state machine (FSM) controller.

The goal is to develop practical skills in digital hardware design, simulation, functional verification, and waveform-based debugging.

**Project status:** Basic RTL modules and simplified processor integration simulated successfully.

## Learning Objectives

- Implement combinational logic using SystemVerilog.
- Design sequential circuits using clocked logic.
- Develop a 32-bit ALU supporting arithmetic and bitwise operations.
- Implement a 32 × 32 register file with two read ports and one write port.
- Design an FSM controller with FETCH, DECODE, EXECUTE, and WRITE_BACK states.
- Integrate controller and datapath modules.
- Verify behavior using Icarus Verilog and GTKWave.

## Hardware Architecture

The integrated design consists of two main components:

### 1. Processor Controller

The controller manages a simplified four-stage transaction sequence:

1. **FETCH** — Waits for a start request.
2. **DECODE** — Advances to the next stage.
3. **EXECUTE** — Represents the operation stage.
4. **WRITE_BACK** — Enables register-file writes.

After WRITE_BACK, the controller returns to FETCH and waits for another start request.

### 2. Datapath

The datapath contains:

- **Register file:** 32 registers, each 32 bits wide, with two asynchronous read ports and one synchronous write port.
- **ALU:** Performs ADD, SUB, AND, OR, and XOR operations.
- **Write-back multiplexer:** Selects between the ALU result and externally supplied data.
- **Zero flag:** Indicates whether the ALU result equals zero.

The register file follows the RISC-V convention that register x0 always reads as zero and ignores writes to that register.

## Supported ALU Operations

| ALUControl | Operation   |
| ---------- | ----------- |
| `000`      | Addition    |
| `001`      | Subtraction |
| `010`      | Bitwise AND |
| `011`      | Bitwise OR  |
| `100`      | Bitwise XOR |

Unsupported ALU control values produce zero.

## Verification Results

The following behaviors were verified in simulation:

| Test                     | Expected Result                     | Status |
| ------------------------ | ----------------------------------- | ------ |
| Load register R1         | R1 = 10                             | PASS   |
| Load register R2         | R2 = 20                             | PASS   |
| ALU addition             | 10 + 20 = 30                        | PASS   |
| ALU write-back           | R3 = 30                             | PASS   |
| External-data write-back | R4 = 42                             | PASS   |
| Protect register x0      | Write 99; read 0                    | PASS   |
| Controller reset         | FETCH = 1, RegWrite = 0             | PASS   |
| Controller timing        | RegWrite asserted during WRITE_BACK | PASS   |

These results confirm the tested behaviors of the simplified controller-and-datapath integration. They do not establish that the design is a complete instruction-executing processor.

## Tools Used

- **SystemVerilog** — RTL design and testbench development
- **Icarus Verilog** — Compilation and simulation
- **GTKWave** — VCD waveform inspection
- **Visual Studio Code** — Development environment

## Running the Simulation

Run these commands from the `01-basic-rtl` project directory.

Compile using the project's file list:

```powershell
iverilog -g2012 -o processor_core_sim -c processor_core.f
```

Run the simulation:

```powershell
vvp processor_core_sim
```

The testbench generates a VCD waveform at:

```text
wave/processor_core.vcd
```

Open this file in GTKWave to inspect the clock, controller states, write enable, ALU result, and zero flag.

If the simulation output directory does not exist, create it before compiling or generating simulation output.

## Current Limitations

This project is a simplified controller-and-datapath integration, not a complete CPU.

- There is no instruction memory or program counter.
- Instruction fetching and decoding are represented by controller states; no actual instructions are fetched or decoded.
- Inputs such as register addresses and ALU control are supplied externally by the testbench.
- The controller does not implement instruction-dependent control signals.
- The design has not yet been synthesized or tested on an FPGA.

## Future Improvements

- Expand verification to cover every ALU operation.
- Add assertions or systematic test cases for control and datapath behavior.
- Improve the integration testbench to check register contents and edge cases.
- Add instruction decoding and a program counter.
- Progress toward a small instruction-executing RISC-V processor.
- Explore synthesis and FPGA implementation.

## Key Takeaway

This project establishes a foundation in SystemVerilog RTL design, module integration, synchronous control, and simulation-based verification. It is an intermediate milestone toward more complete processor architectures and FPGA-based digital systems.
