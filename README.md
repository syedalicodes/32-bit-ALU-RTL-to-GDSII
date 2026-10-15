# 32-bit ALU Design — RTL to GDSII

A 32-bit Arithmetic Logic Unit (ALU) designed using Verilog/SystemVerilog and implemented through an RTL-to-GDSII ASIC design flow using Vivado, OpenROAD, and the SKY130 HD standard-cell platform.

## Project Overview

This project demonstrates the digital design and ASIC implementation workflow, from RTL development and functional simulation to synthesis, physical design, routing, and final GDSII layout generation.

**Key Highlights**
- 32-bit ALU with 16 operation codes
- Registered output with active-low reset
- Zero, carry, negative, and overflow flags
- RTL simulation and testbench verification
- ASIC physical design using OpenROAD
- Final GDSII layout generated for the `alu_top` design

## Tools and Technologies

- **HDL:** Verilog, SystemVerilog
- **RTL Simulation:** Vivado Simulator
- **ASIC Flow:** OpenROAD
- **Technology Platform:** SKY130 HD
- **Layout Viewer:** KLayout
- **Constraints:** XDC / timing constraints
- **Version Control:** Git and GitHub

## ALU Operations

The ALU supports 16 operation codes. The operation mapping is defined in the RTL source files.

The design includes arithmetic and logical operations, with the exact operation-to-opcode mapping available in the RTL implementation.

## Design Architecture

The design is organized around the following components:

- **ALU Core:** Implements arithmetic and logical operations.
- **ALU Flags:** Generates status flags for ALU results.
- **ALU Top:** Integrates the design and registered output.
- **Testbench:** Applies test vectors and checks expected results.
- **Reference Model:** Provides expected results for verification.

## Verification Results

The simulation testbench completed its 16 representative result tests successfully.

| Metric | Result |
|---|---|
| Representative result tests passed | 16 |
| Failed tests | 0 |
| Simulation status | PASS |

These results represent the executed test cases and do not imply exhaustive verification of every input combination or every reset and flag corner case.

## ASIC Implementation

The design was taken through the following implementation stages:

1. RTL synthesis
2. Floorplanning
3. Placement
4. Clock-tree synthesis (CTS)
5. Global routing
6. Detailed routing
7. Final GDSII generation

**Implementation summary**

| Parameter | Result |
|---|---|
| Top-level design | `alu_top` |
| Technology platform | SKY130 HD |
| Clock period constraint | 20 ns (50 MHz) |
| Final layout format | GDSII |
| Final layout file | `6_final.gds` |

## Timing Results

The available estimated timing report records the following values:

| Timing metric | Result |
|---|---:|
| Worst setup slack | +10.96 ns |
| Total negative slack | 0.00 ns |

**Note:** These are estimated timing results from the available report, not final routed-parasitics timing sign-off results.

## Design Rule Check (DRC)

The available DRC count report records **0 reported violations**.

This documents the result in the generated report and should not be interpreted as foundry sign-off or proof that every manufacturing rule has been verified.

## Repository Contents

```text
32-bit-ALU-RTL-to-GDSII/
├── alu_core.sv
├── alu_flags.sv
├── alu_top.sv
├── alu_tb.sv
├── alu_reference_model.sv
├── alu_timing.xdc
├── 01_vivado_sources.png
├── 02_rtl_schematic.png
├── 03_simulation_waveform.png
├── 04_synthesis.png
├── 05_utilization.png
├── 07_final_gds.png
├── 08_drc_verification.png
├── 10_final_asic_files.png
├── 6_final.gds
├── 6_final.def
├── 6_final.v
└── README.md
```

*Note: Add the timing screenshot `09_asic_timing_report.png` and any ASIC report files when they are uploaded. The tree above reflects the files currently visible in the repository.*

## Screenshots

The repository includes screenshots documenting:

- RTL sources and design hierarchy
- RTL schematic
- Simulation waveform
- Synthesis results
- FPGA utilization
- Final ASIC layout in KLayout
- DRC count verification
- Final ASIC output files

## Skills Demonstrated

- RTL design and digital logic development
- Functional simulation and testbench development
- Reference-model-based verification
- Synthesis and timing constraints
- ASIC floorplanning, placement, CTS, and routing
- GDSII layout generation and inspection
- Timing-report interpretation
- GitHub project documentation

## Future Improvements

- Expand verification with randomized and corner-case tests.
- Add dedicated assertions for ALU flags and reset behavior.
- Document the complete opcode mapping and interface timing.
- Include detailed area, timing, and routing reports.
- Validate the final implementation with a fully supported parasitic-extraction and sign-off flow.

## Author

**Syed Ali U. Khan**

Integrated M.Tech — Electronics and Communication Engineering  
Specialization: Microelectronic System Design

GitHub: [@syedalicodes](https://github.com/syedalicodes)

---

*This project is intended for educational and portfolio demonstration of RTL design and ASIC implementation workflows.*
