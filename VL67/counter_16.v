// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-09 13:29:03
// Revise Date  : 2023-06-09 13:29:04
// File Name    : counter_16.v
// Description  : VL67 on nowcoder
// ======================================================================

module counter_16 (
  input  wire       clk,
  input  wire       rst_n,
  output reg  [3:0] Q
);

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      Q <= 4'd0;
    end else begin
      Q <= Q + 4'd1;
    end
  end

endmodule