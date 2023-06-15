// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-15 12:35:52
// Revise Date  : 2023-06-15 12:35:54
// File Name    : calculation.v
// Description  : VL77 on nowcoder
// ======================================================================

module multiply (
  input  wire [3:0] din_a,
  input  wire [3:0] din_b,
  output wire [7:0] dout
);

  wire [3:0] [7:0] dcal;

  generate
    genvar i;
    for (i = 0; i < 4; i = i + 1) begin
      assign dcal[i] = (din_a[i] == 1'b1) ? (din_b << i) : 8'd0;
    end
  endgenerate

  assign dout = dcal[0] + dcal[1] + dcal[2] + dcal[3];

endmodule


module calculation (
  input  wire       clk,
  input  wire       rst_n,
  input  wire [3:0] a,
  input  wire [3:0] b,
  output wire [8:0] c
);
  
  reg  [3:0] a_reg0;
  reg  [3:0] b_reg0;
  reg  [3:0] a_reg1;
  reg  [3:0] b_reg1;
  wire [7:0] a_part;
  wire [7:0] b_part;

  assign c = a_part + b_part;

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      a_reg0 <= 4'd0;
      b_reg0 <= 4'd0;
      a_reg1 <= 4'd0;
      b_reg1 <= 4'd0;
    end else begin
      a_reg0 <= a;
      b_reg0 <= b;
      a_reg1 <= a_reg0;
      b_reg1 <= b_reg0;
    end
  end

  multiply u1_multiply (.din_a(4'd12), .din_b(a_reg1), .dout(a_part));
  multiply u2_multiply (.din_a(4'd5), .din_b(b_reg1), .dout(b_part));

endmodule