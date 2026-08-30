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

wire mux1;
mux21 mux1( .A(xorout1), .B(tin), .sel(tmode), .C(mux1));

wire and1;
assign and1 = a&b;

wire xorout2;
assign xorout2 = mux1^cin;

wire and2;
assign and2 = mux1&cin;

wire or1;
assign or1 = and1|and2;
assign cout = or1;

wire mux2;
mux21 mux2( .A(xorout2), .B(cin), .sel(tmode), .C(sum));

endmodule
