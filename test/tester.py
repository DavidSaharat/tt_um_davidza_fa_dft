import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")
    
    # ui_in bit mapping: [4]tin, [3]tmode, [2]cin, [1]b, [0]a
    # uo_out bit mapping: [1]cout, [0]sum

    # Test 1: a=0, b=0, cin=0
    dut.ui_in.value = 0b00000
    await ClockCycles(dut.clk, 1)
    assert (int(dut.uo_out.value) & 0b1) == 0       # sum
    assert ((int(dut.uo_out.value) >> 1) & 0b1) == 0  # cout

    # Test 2: a=1, b=0, cin=0
    dut.ui_in.value = 0b00001
    await ClockCycles(dut.clk, 1)
    assert (int(dut.uo_out.value) & 0b1) == 1
    assert ((int(dut.uo_out.value) >> 1) & 0b1) == 0

    # Test 3: a=0, b=0, cin=1
    dut.ui_in.value = 0b00100
    await ClockCycles(dut.clk, 1)
    assert (int(dut.uo_out.value) & 0b1) == 1
    assert ((int(dut.uo_out.value) >> 1) & 0b1) == 0

    # Test 4: a=0, b=1, cin=1
    dut.ui_in.value = 0b00110
    await ClockCycles(dut.clk, 1)
    assert (int(dut.uo_out.value) & 0b1) == 0
    assert ((int(dut.uo_out.value) >> 1) & 0b1) == 1

    # Test 5: a=0, b=1, cin=0
    dut.ui_in.value = 0b00010
    await ClockCycles(dut.clk, 1)
    assert (int(dut.uo_out.value) & 0b1) == 1
    assert ((int(dut.uo_out.value) >> 1) & 0b1) == 0

    # Test 6: a=1, b=0, cin=1
    dut.ui_in.value = 0b00101
    await ClockCycles(dut.clk, 1)
    assert (int(dut.uo_out.value) & 0b1) == 0
    assert ((int(dut.uo_out.value) >> 1) & 0b1) == 1

    # Test 7: a=1, b=1, cin=0
    dut.ui_in.value = 0b00011
    await ClockCycles(dut.clk, 1)
    assert (int(dut.uo_out.value) & 0b1) == 0
    assert ((int(dut.uo_out.value) >> 1) & 0b1) == 1

    # Test 8: a=1, b=1, cin=1
    dut.ui_in.value = 0b00111
    await ClockCycles(dut.clk, 1)
    assert (int(dut.uo_out.value) & 0b1) == 1
    assert ((int(dut.uo_out.value) >> 1) & 0b1) == 1
    