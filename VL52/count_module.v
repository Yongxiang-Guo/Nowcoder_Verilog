// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-07 16:09:32
// Revise Date  : 2023-06-07 16:09:32
// File Name    : count_module.v
// Description  : VL52 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module count_module(
  input  wire      clk,
  input  wire      rst_n,
  input  wire      mode,
  output reg [3:0] number,
  output reg       zero
);

  reg [3:0] num;

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      number <= 4'd0;
      zero   <= 1'b0;
      num    <= 4'd0;
    end else begin
      zero <= (num == 4'd0);
      number <= num;
      case (mode)
          0: num <= (num == 4'd0) ? 9 : (num - 1);
          1: num <= (num == 4'd9) ? 0 : (num + 1);
      endcase
    end
  end

endmodule