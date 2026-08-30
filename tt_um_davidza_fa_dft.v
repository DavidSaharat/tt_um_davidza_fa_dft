`default_nettype none

module tt_um_davidza_fa_dft (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire sum, cout;
fa_dft fa_dft_inst (
    .a(ui_in[0]),
    .b(ui_in[1]),
    .cin(ui_in[2]),
    .tmode(ui_in[3]),
    .tin(ui_in[4]),
    .sum(sum),
    .cout(cout)
);


  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = {6'b0,cout, sum};  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{uio_in,ena, clk, rst_n, 1'b0};

endmodule