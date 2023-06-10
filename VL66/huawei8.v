// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-09 11:34:46
// Revise Date  : 2023-06-09 11:36:45
// File Name    : huawei8.v
// Description  : VL66 on nowcoder
// ======================================================================

module Add1 (
  input  wire a,
  input  wire b,
  input  wire C_in,
  output wire f,
  output wire g,
  output wire p
);

  assign g = a & b;
  assign p = a | b;
  assign f = a ^ b ^ C_in;

endmodule


module CLA_4 (
  input  wire [3:0] P,
  input  wire [3:0] G,
  input  wire       C_in,
  output wire [4:1] Ci
);

  assign Ci[1] = G[0] | (P[0] & C_in);
  assign Ci[2] = G[1] | (P[1] & (G[0] | (P[0] & C_in)));
  assign Ci[3] = G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & C_in)))));
  assign Ci[4] = G[3] | (P[3] & (G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & C_in)))))));

endmodule


module huawei8 (
  input  wire [3:0] A,
  input  wire [3:0] B,
  output wire [4:0] OUT
);

  wire [3:0] P;
  wire [3:0] G;
  wire [4:1] C;
  wire [3:0] Sum;
  wire [3:0] C_in;

  assign C_in = {C[3:1], 1'b0};
  assign OUT = {C[4], Sum};

  generate
    genvar i;
    for (i = 0; i < 4; i = i + 1) begin : gen_add1
      Add1 u_Add1 (
        .a    ( A[i]    ),
        .b    ( B[i]    ),
        .C_in ( C_in[i] ),
        .f    ( Sum[i]  ),
        .g    ( G[i]    ),
        .p    ( P[i]    )
      );
    end
  endgenerate

  CLA_4 u_CLA_4 (
    .P    ( P    ),
    .G    ( G    ),
    .C_in ( 1'b0 ),
    .Ci   ( C    )
  );

endmodule