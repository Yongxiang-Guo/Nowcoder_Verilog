// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-08 12:37:18
// Revise Date  : 2023-06-08 12:37:18
// File Name    : RTL.v
// Description  : VL59 on nowcoder
// ======================================================================

module RTL (
  input  wire clk,
  input  wire rst_n,
  input  wire data_in,
  output wire data_out
);

  reg data_in_reg;
  reg data_out_reg;
  wire data_out_in;

  assign data_out_in = data_in & ~data_in_reg;
  assign data_out = data_out_reg;

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      data_in_reg <= 1'b0;
      data_out_reg <= 1'b0;
    end else begin
      data_in_reg <= data_in;
      data_out_reg <= data_out_in;
    end
  end

endmodule