# Custom 8-bit Processor in Verilog

This project implements a basic 8-bit processor architecture from scratch using Verilog. It includes a program counter, instruction memory, control unit, register file, ALU, and key registers like the accumulator and carry/borrow register. This design is distinct from other public implementations and is specifically tailored as per our assignment specification.

## Simulation Results
![Screenshot 2025-04-19 202123](https://github.com/user-attachments/assets/b3dba057-fec5-4106-b7d5-19ec0bf38ac3)
![Screenshot 2025-04-19 202138](https://github.com/user-attachments/assets/e400d1da-894f-47a0-abb6-bd60faab9509)
![Screenshot 2025-04-19 202144](https://github.com/user-attachments/assets/3c4fabe7-69da-4c12-a6f7-194bd6137e62)

## Block Diagram
![image](https://github.com/user-attachments/assets/1a13a563-ced4-47e9-913f-eaecd4af320b)

## Schematic
![Screenshot 2025-04-19 190512](https://github.com/user-attachments/assets/4d15abd6-f243-472f-84ca-d2e927adce98)


##  Architecture Overview

### Key Components:
- **Program Counter (PC):** Fetches the address of the current instruction.
- **Memory:** ROM storing a predefined instruction set.
- **Control Unit (CU):** Decodes instructions and generates control signals.
- **Register File (RF):** A bank of 16 8-bit registers.
- **Accumulator (ACC):** Main register for arithmetic/logic results.
- **CB Register:** Stores carry/borrow or flag bits from ALU.
- **EXT Register:** Holds overflow bits from multiplication.
- **ALU:** Performs arithmetic and logic operations based on decoded instructions.

### Control Flow:
1. Instruction is fetched using PC and passed to the CU.
2. CU decodes and activates relevant control signals.
3. Data flows through the ALU and results update ACC, EXT, or CB.
4. PC is either incremented or branched based on instruction and flags.
5. Processor halts on HLT instruction (`0xFF`), triggering `halt_out`.

## 📁 Module List

| File               | Description                            |
|--------------------|----------------------------------------|
| `processor_top.v`  | Top module connecting all components   |
| `program_counter.v`| Address increment/load logic           |
| `memory.v`         | Read-only instruction memory (ROM)     |
| `register_file.v`  | General-purpose register bank          |
| `alu.v`            | Core logic for arithmetic & logic ops  |
| `control_unit.v`   | Instruction decoder & signal generator |
| `tb_processor.v`   | Testbench for simulating full processor|

## 🧪 Simulation

The simulation in `tb_processor.v` toggles clock and reset, then waits until the processor executes a `HALT` instruction. During this time, instructions such as arithmetic, bitwise operations, and jumps are executed as coded in the ROM.

