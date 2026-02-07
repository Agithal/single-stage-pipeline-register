# Single-Stage Pipeline Register (Valid/Ready Handshake)

This repository contains a simple and synthesizable single stage pipeline register implemented in SystemVerilog, using a standard valid/ready handshake protocol.  
The design correctly handles backpressure without data loss or duplication and resets to a clean empty state.


# Module Overview

The pipeline register sits between an input and output interface and:
- Accepts data when 'in_valid' and 'in_ready' are asserted
- Stores one data word internally
- Presents data on the output with 'out_valid'
- Handles backpressure using 'out_ready'
- Clears to an empty state on reset

# Design Details

- Language: SystemVerilog
- Data Width: Parameterized ('WIDTH', default = 32)
- Reset: Active-low asynchronous reset ('rst_n')
- Handshake: Valid–Ready protocol
- Correct backpressure handling


# Files

pipeline_reg.sv - implementation of the pipeline register 
tb_pipeline_reg.sv - Simple directed testbench 
README.md -Project documentation 

# Testbench Coverage

The testbench verifies:
- Reset behavior
- Normal data transfer
- Backpressure handling (out_ready = 0)
- Correct data transfer after backpressure is released


# Simulation 

Using ModelSim :
vlog pipeline_reg.sv tb_pipeline_reg.sv
vsim tb_pipeline_reg
run -all

