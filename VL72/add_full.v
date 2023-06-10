// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-09 15:08:51
// Revise Date  : 2023-06-09 15:08:51
// File Name    : add_full.v
// Description  : VL72 on nowcoder
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

  add_half u_add_half (.A(A), .B(B), .S(Sum_AB), .C(C_AB));
  add_half u_add_half (.A(Sum_AB), .B(Ci), .S(S), .C(C1));

  assign Co = C_AB | C1;

endmodule