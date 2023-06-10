// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-08 15:31:34
// Revise Date  : 2023-06-08 15:44:10
// File Name    : huawei5.v
// Description  : VL63 on nowcoder
// ======================================================================

module huawei5 (
  input  wire       clk,
  input  wire       rst,
  input  wire [3:0] d,
  output wire       valid_in,
  output wire       dout
);

  reg [3:0] din_reg;
  reg       valid_reg;
  reg [1:0] out_cnt;

  assign dout = din_reg[3-out_cnt];
  assign valid_in = valid_reg;

  always @(posedge clk or negedge rst) begin
    if (~rst) begin
      din_reg <= 4'd0;
      valid_reg <= 1'b0;
      out_cnt <= 2'd0;
    end else begin
      if (out_cnt == 2'd3) begin
        out_cnt <= 2'd0;
        din_reg <= d;
        valid_reg <= 1'b1;
      end else begin
        out_cnt <= out_cnt + 2'd1;
        valid_reg <= 1'b0;
      end
    end
  end

endmodule