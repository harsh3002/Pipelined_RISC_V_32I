# RISC-V 32I Pipelined Processor
## Overview
This repository contains the Verilog implementation of a pipelined RISC-V 32I processor. The processor supports 31 basic instructions and includes mechanisms for handling data forwarding, stalling, and control hazards.

## Features
Five-stage Pipeline: Implements Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), and Write Back (WB) stages.
Forwarding Unit: Minimizes data hazards by forwarding data from later stages to earlier stages when necessary.
Stalling Unit: Inserts stalls to handle hazards that cannot be resolved by forwarding.
Control Hazard Unit: Manages control hazards to ensure correct instruction execution flow.
Datapath for 31 Instructions: Supports a subset of the RISC-V ISA including arithmetic, logical, load/store, and control flow instructions.

## Usage
Compile the Verilog files using your preferred simulator (e.g., ModelSim, Verilator).
Run the testbench to verify the functionality of the processor.
Analyze the output to ensure the processor behaves as expected.

## Supported Instructions
The processor supports the following 31 instructions:

Arithmetic Instructions: ADD, SUB, etc.
Immediate Instructions: ADDI, SUBI, etc.
Logical Instructions: AND, OR, XOR, etc.
Shift Instructions: SLL, SRL, SRA, etc.
Load/Store Instructions: LW, SW, etc.
Control Flow Instructions: BEQ, BNE, JAL, JALR, etc.

## Pipeline Stages
Instruction Fetch (IF): Fetches the instruction from memory.
Instruction Decode (ID): Decodes the instruction and reads the registers.
Execute (EX): Performs arithmetic or logical operations.
Memory Access (MEM): Accesses data memory for load/store instructions.
Write Back (WB): Writes the result back to the register file.

## Hazard Units
### Forwarding Unit
The forwarding unit detects data hazards and forwards the necessary data from later pipeline stages to earlier stages to avoid stalling.

### Stalling Unit
The stalling unit inserts stalls (NOPs) into the pipeline when hazards cannot be resolved by forwarding, ensuring correct data dependency handling.

### Control Hazard Unit
The control hazard unit manages hazards caused by branch instructions by predicting the branch outcome and flushing the pipeline if the prediction is incorrect.

## Datapath Diagram
![Screenshot 2024-07-06 092447](https://github.com/harsh3002/Pipelined_RISC_V_32I/assets/119344161/0220357c-1661-4727-bdc2-2501b6e8f8b3)
