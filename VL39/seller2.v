// ======================================================================
// Copyright (c) 2022-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-01-16
// Revise Date  : 2023-01-16
// File Name    : seller2.v
// Description  : VL39 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module seller2 (
  input  wire   clk,
  input  wire   rst,
  input  wire   d1,
  input  wire   d2,
  input  wire   sel,
  output wire   out1,
  output wire   out2,
  output wire   out3
);

reg [2:0] money_in;
reg [2:0] money_out;
wire      money_enough1;
wire      money_enough2;
reg       drink_out1;
reg       drink_out2;

assign money_enough1 = (~sel) & (money_in[2] | (money_in[1] & money_in[0]));
assign money_enough2 = sel & money_in[2] & (money_in[1] | money_in[0]);
assign out1          = drink_out1;
assign out2          = drink_out2;
assign out3          = money_out[0];

always @(posedge clk or negedge rst) begin
  if (~rst) begin
    money_in <= 3'd0;
  end
  else begin
    if (money_enough1 | money_enough2) begin
      if (d1) begin
        money_in <= 3'd1;
      end
      else if (d2) begin
        money_in <= 3'd2;
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
    end
  end
end

always @(posedge clk or negedge rst) begin
  if (~rst) begin
    drink_out1 <= 1'b0;
    drink_out2 <= 1'b0;
    money_out  <= 3'd0;
  end
  else begin
    if (money_enough1) begin
      drink_out1 <= 1'b1;
      money_out  <= money_in - 3'd3;
    end
    else if (money_enough2) begin
      drink_out2 <= 1'b1;
      money_out  <= money_in - 3'd5;
    end
    else begin
      drink_out1 <= 1'b0;
      drink_out2 <= 1'b0;
      money_out  <= 3'd0;
    end
  end
end

endmodule