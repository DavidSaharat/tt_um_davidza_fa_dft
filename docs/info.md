<!---
This file is used to generate your project datasheet. Please fill in the information below and delete any unused sections.
-->

## How it works

This project implements a 1-bit Full Adder integrated with a Design-for-Testability (DFT) multiplexer. 
The standard Full Adder logic computes Sum and Cout. To enable DFT capabilities, a 2-to-1 multiplexer is embedded within the logic path. During normal operation (`tmode = 0`), the multiplexer passes the original signal. When test mode is enabled (`tmode = 1`), the multiplexer overrides the internal node with the value of the `tin` input.

## How to test

Set the input values on the `ui_in` pins:
* `ui_in[0]` : A
* `ui_in[1]` : B
* `ui_in[2]` : Cin
* `ui_in[3]` : tmode (Test Mode Enable)
* `ui_in[4]` : tin (Test Input)

Read the output values on the `uo_out` pins:
* `uo_out[0]` : Sum
* `uo_out[1]` : Cout (Carry Out)

**Normal Mode (`tmode = 0`)**: The circuit operates as a standard 1-bit Full Adder.
**Test Mode (`tmode = 1`)**: The internal test point is overridden by the value of `tin`.