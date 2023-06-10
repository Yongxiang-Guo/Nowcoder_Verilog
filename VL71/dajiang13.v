// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-09 15:02:31
// Revise Date  : 2023-06-09 15:02:34
// File Name    : dajiang13.v
// Description  : VL71 on nowcoder
// ======================================================================

module dajiang13(
  input  wire [7:0]  A,
  output wire [15:0] B
);

  assign B = (A << 7) + (A << 6) + (A << 5) + (A << 4) + (A << 3) + (A << 1) + A;

endmodule