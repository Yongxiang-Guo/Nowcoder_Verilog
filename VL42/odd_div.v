// ======================================================================
// Copyright (c) 2022-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-01-17
// Revise Date  : 2023-01-17
// File Name    : odd_div.v
// Description  : VL42 on nowcoder
// ======================================================================

module odd_div (
  input  wire rst,
  input  wire clk_in,
  output reg  clk_out5
);

reg [2:0] cnt;

always @(posedge clk_in or negedge rst) begin
  if (~rst) begin
    cnt <= 3'd0;
  end
  else begin
    if (cnt == 3'd4) begin
      cnt <= 3'd0;
    end
    else begin
      cnt <= cnt + 3'd1;
    end
  end
end

always @(posedge clk_in or negedge rst) begin
  if (~rst) begin
    clk_out5 <= 1'b0;
  end
  else begin
    if (cnt == 3'd0) begin
      clk_out5 <= 1'b1;
    end
    else if (cnt == 3'd2) begin
      clk_out5 <= 1'b0;
    end
  end
end

endmodule