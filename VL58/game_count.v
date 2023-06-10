// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-08 11:35:35
// Revise Date  : 2023-06-08 11:35:35
// File Name    : game_count.v
// Description  : VL58 on nowcoder
// ======================================================================

module game_count (
  input  wire       rst_n,
  input  wire       clk,
  input  wire [9:0] money,
  input  wire       set,
  input  wire       boost,
  output reg  [9:0] remain,
  output wire       yellow,
  output reg        red
);

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      remain <= 10'd0;
      red <= 1'b0;
    end else if (set) begin
      remain <= remain + money;
      red <= (remain == 10'd0);
    end else begin
      remain <= (remain == 10'd0) ? 10'd0 : (remain - {8'd0, boost, ~boost});
      red <= (remain == 10'd0);
    end
  end

  assign yellow = (remain < 10'd10) && (remain > 10'd1);

endmodule