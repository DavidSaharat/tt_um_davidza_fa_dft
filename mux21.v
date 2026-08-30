module mux21 (
    input wire A,
    input wire B,
    input wire sel,
    output wire C
);
    assign C = sel ? B : A;
endmodule