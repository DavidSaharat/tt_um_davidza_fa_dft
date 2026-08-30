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


