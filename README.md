## Project Overview

This project implements a single-cycle RISC-V processor in Verilog, composed of three main components:

1. Controller  
2. ALU Controller  
3. Processor

The processor takes two inputs—`clk` and `reset`—and outputs a 32-bit `result` computed by the Arithmetic Logic Unit (ALU) based on the executed instruction.

---

## Main Components and Functionality

### 1. Controller

**Purpose:**  
The controller interprets the 7-bit RISC-V opcode and generates the necessary control signals to guide data flow through the datapath and instruct the ALU controller.

**Inputs:**
- `opcode` (7 bits)

**Outputs:**
- 5 control signals for datapath modules
- `ALUop` (2 bits) for the ALU controller

**Implementation Details:**
- Implemented using Verilog `case` statements.
- The controller maps each opcode to its corresponding control signal values, as defined in a truth table.

---

### 2. ALU Controller

**Purpose:**  
The ALU controller decodes the `funct3`, `funct7`, and `ALUop` signals to produce a 4-bit control signal, `ALU_CC`, determining which ALU operation to perform.

**Inputs:**
- `ALUop` (2 bits)
- `funct3` (3 bits)
- `funct7` (7 bits)

**Output:**
- `ALU_CC` (4 bits)

**Implementation Details:**
- Logic designed from a truth table mapping specific combinations of `funct3`, `funct7`, and `ALUop` to ALU operations.
- For example, the fourth bit of `ALU_CC` is set when `funct3 == 3'b100`.

---

### 3. Processor

**Purpose:**  
The processor module integrates the Controller, ALU Controller, and Datapath to execute instructions and compute the final result.

**Inputs:**
- `clk` (clock)
- `reset` (reset signal)

**Output:**
- `result` (32-bit output of ALU computation)

**Design Flow:**
1. Instruction is fetched and decoded.
2. `opcode` is sent to the Controller to generate control signals and `ALUop`.
3. `funct3` and `funct7` (from the instruction) and `ALUop` go to the ALU Controller, which produces `ALU_CC`.
4. All signals are routed into the Datapath, which computes the final `result`.
5. The `result` is monitored over time in the waveform viewer.

---

## Testbench and Simulation

A testbench file (`tb_processor.v`) was written to simulate the processor under various scenarios using the test cases provided in the lab manual.

### Simulation Results:

The simulation produced correct outputs across a range of timestamps, confirming the processor’s expected behavior.

| Time (ns) | Result |
|----------:|--------|
|   10–30   |   0    |
|   30–50   |   1    |
|   50–70   |   2    |
|   70–90   |   4    |
|   90–110  |   5    |
|   ...     |  ...   |
|  370–410  |  48    |
