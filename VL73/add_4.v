// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-10 14:08:50
// Revise Date  : 2023-06-10 14:08:55
// File Name    : add_4.v
// Description  : VL73 on nowcoder
// ======================================================================

module add_half (
  input  wire A,
  input  wire B,
  output wire S,
  output wire C
);

  assign S = A ^ B;
  assign C = A & B;

endmodule


module add_full (
  input  wire  A,
  input  wire  B,
  input  wire  Ci,
  output wire  S,
  output wire  Co
);

  wire Sum_AB;
  wire C_AB;
  wire C1;

  add_half u1_add_half (.A(A), .B(B), .S(Sum_AB), .C(C_AB));
  add_half u2_add_half (.A(Sum_AB), .B(Ci), .S(S), .C(C1));

  assign Co = C_AB | C1;

endmodule


module add_4 (
  input  wire [3:0] A,
  input  wire [3:0] B,
  input  wire       Ci,
  output wire [3:0] S,
  output wire       Co
);

  wire [4:0] C_line;
  assign C_line[0] = Ci;
  assign Co = C_line[4];

  generate
    genvar i;
    for (i = 0; i < 4; i = i + 1) begin : gen_add_full
      add_full u_add_full (.A(A[i]), .B(B[i]), .Ci(C_line[i]), .S(S[i]), .Co(C_line[i + 1]));
    end
  endgenerate

endmodule