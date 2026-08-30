[![GDS](https://github.com/DavidSaharat/tt_um_davidza_fa_dft/actions/workflows/gds.yaml/badge.svg)](https://github.com/DavidSaharat/tt_um_davidza_fa_dft/actions/workflows/gds.yaml)
[![Docs](https://github.com/DavidSaharat/tt_um_davidza_fa_dft/actions/workflows/docs.yaml/badge.svg)](https://github.com/DavidSaharat/tt_um_davidza_fa_dft/actions/workflows/docs.yaml)
[![Test](https://github.com/DavidSaharat/tt_um_davidza_fa_dft/actions/workflows/test.yaml/badge.svg)](https://github.com/DavidSaharat/tt_um_davidza_fa_dft/actions/workflows/test.yaml)

# Full Adder with Design for Testability (DFT)

- [Read the documentation for project](docs/info.md)

## How it works

This project implements a standard Full Adder circuit integrated with Design for Testability (DFT) features. A Full Adder computes the sum of three bits (two significant bits and a carry-in bit). The addition of DFT modes (`tmode` and `tin`) allows the internal logic to be tested directly for manufacturing faults, bypassing standard operational logic when activated.

## How to test

You can verify the circuit's logic by setting the input pins according to a standard Full Adder truth table.

**Input Pin Mapping:**
- `ui_in[0]` : a
- `ui_in[1]` : b
- `ui_in[2]` : cin
- `ui_in[3]` : tmode (Test Mode Enable)
- `ui_in[4]` : tin (Test Input)

**Output Pin Mapping:**
- `uo_out[0]` : sum
- `uo_out[1]` : cout (Carry Out)

To test the normal addition logic, keep `tmode` (`ui_in[3]`) at `0` and toggle `a`, `b`, and `cin`. Observe the `sum` and `cout` outputs:
- `a=0, b=0, cin=0` ➔ `sum=0, cout=0`
- `a=1, b=0, cin=0` ➔ `sum=1, cout=0`
- `a=0, b=1, cin=1` ➔ `sum=0, cout=1`
- `a=1, b=1, cin=1` ➔ `sum=1, cout=1`

## What is Tiny Tapeout?

Tiny Tapeout is an educational project that aims to make it easier and cheaper than ever to get your digital and analog designs manufactured on a real chip.

To learn more and get started, visit https://tinytapeout.com.