// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-07 16:01:59
// Revise Date  : 2023-06-07 16:02:35
// File Name    : count_module.v
// Description  : VL50 on nowcoder
// ======================================================================

module count_module(
  input  wire       clk,
  input  wire       rst_n,
  output reg  [5:0] second,
  output reg  [5:0] minute
);

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      second <= 6'd0;
      minute <= 6'd0;
    end else if (minute == 6'd60) begin
      second <= 6'd0;
    end else if (second == 6'd60) begin
      second <= 6'd1;
      minute <= minute + 6'd1;
    end else begin
      second <= second + 6'd1;
    end
  end

endmodule