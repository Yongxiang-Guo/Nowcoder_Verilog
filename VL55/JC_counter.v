// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-07 17:18:44
// Revise Date  : 2023-06-07 17:18:44
// File Name    : JC_counter.v
// Description  : VL55 on nowcoder
// ======================================================================

module JC_counter (
  input  wire      clk ,
  input  wire      rst_n,
  output reg [3:0] Q  
);

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      Q <= 4'd0;
    end else begin
      Q <= {~Q[0], Q[3:1]};
    end
  end

endmodule