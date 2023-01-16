// ======================================================================
// Copyright (c) 2022-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-01-16
// Revise Date  : 2023-01-16
// File Name    : odo_div_or.v
// Description  : VL40 on nowcoder
// ======================================================================

module odo_div_or (
  input   wire  rst,
  input   wire  clk_in,
  output  wire  clk_out7
);

reg       clk_out7_pos;
reg       clk_out7_neg;
reg [2:0] cnt;

assign clk_out7 = clk_out7_pos & clk_out7_neg;

always @(posedge clk_in or negedge rst) begin
  if (~rst) begin
    cnt <= 3'd0;
  end
  else begin
    if (cnt == 3'd6) begin
      cnt <= 3'd0;
    end
    else begin
      cnt <= cnt + 3'd1;
    end
  end
end

always @(posedge clk_in or negedge rst) begin
  if (~rst) begin
    clk_out7_pos <= 1'b0;
  end
  else begin
    if (cnt == 3'd2) begin
      clk_out7_pos <= 1'b1;
    end
    else if (cnt == 3'd6) begin
      clk_out7_pos <= 1'b0;
    end
  end
end

always @(negedge clk_in or negedge rst) begin
  if (~rst) begin
    clk_out7_neg <= 1'b0;
  end
  else begin
    if (cnt == 3'd3) begin
      clk_out7_neg <= 1'b1;
    end
    else if (cnt == 3'd0) begin
      clk_out7_neg <= 1'b0;
    end
  end
end

endmodule