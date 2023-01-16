// ======================================================================
// Copyright (c) 2022-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-01-16
// Revise Date  : 2023-01-16
// File Name    : seller1.v
// Description  : VL38 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module seller1 (
  input  wire       clk,
  input  wire       rst,
  input  wire       d1,
  input  wire       d2,
  input  wire       d3,
  output wire       out1,
  output wire [1:0] out2
);

reg [2:0] money_in;
reg [2:0] money_out;
wire      money_enough;
reg       drink_out;

assign money_enough = money_in[2] | (money_in[1] & money_in[0]);
assign out1         = drink_out;
assign out2         = money_out[1:0];

always @(posedge clk or negedge rst) begin
  if (~rst) begin
    money_in <= 3'd0;
  end
  else begin
    if (money_enough) begin
      if (d1) begin
        money_in <= 3'd1;
      end
      else if (d2) begin
        money_in <= 3'd2;
      end
      else if (d3) begin
        money_in <= 3'd4;
      end
      else begin
        money_in <= 3'd0;
      end
    end
    else begin
      if (d1) begin
        money_in <= money_in + 3'd1;
      end
      else if (d2) begin
        money_in <= money_in + 3'd2;
      end
      else if (d3) begin
        money_in <= money_in + 3'd4;
      end
    end
  end
end

always @(posedge clk or negedge rst) begin
  if (~rst) begin
    drink_out <= 1'b0;
    money_out <= 2'd0;
  end
  else begin
    if (money_enough) begin
      drink_out <= 1'b1;
      money_out <= money_in - 3'd3;
    end
    else begin
      drink_out <= 1'b0;
      money_out <= 3'd0;
    end
  end
end

endmodule