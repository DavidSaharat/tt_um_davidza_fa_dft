`default_nettype none

// ---------- โมดูล mux21 ----------
module mux21 (
    input  A, B, sel,
    output C
);
    assign C = sel ? B : A;
endmodule

// ---------- โมดูล fa_dft ----------
module fa_dft(
    input a, 
    input b,
    input cin,
    input tmode,
    input tin,
    output sum,
    output cout
);

wire xorout1;
assign xorout1 = a^b;

// เปลี่ยนชื่อสายไฟเป็น w_mux1 เพื่อไม่ให้ซ้ำกับชื่ออุปกรณ์ mux1
wire w_mux1;
mux21 mux1( .A(xorout1), .B(tin), .sel(tmode), .C(w_mux1));

wire and1;
assign and1 = a&b;

wire xorout2;
assign xorout2 = w_mux1^cin;

wire and2;
assign and2 = w_mux1&cin;

wire or1;
assign or1 = and1|and2;
assign cout = or1;

// เรียกใช้ mux2 และต่อผลลัพธ์ออก sum 
mux21 mux2( .A(xorout2), .B(cin), .sel(tmode), .C(sum));

endmodule

// ---------- Wrapper สำหรับเชื่อมต่อกับชิป Tiny Tapeout ----------
module tt_um_davidza_fa_dft (
    input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
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

    assign uo_out  = {6'b0, cout, sum};
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire _unused = &{ena, clk, rst_n, ui_in[7:5], uio_in, 1'b0};

endmodule