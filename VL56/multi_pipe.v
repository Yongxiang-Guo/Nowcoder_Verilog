// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-07 17:33:54
// Revise Date  : 2023-06-07 17:33:54
// File Name    : multi_pipe.v
// Description  : VL56 on nowcoder
// ======================================================================

module multi_pipe #(
  parameter SIZE = 4
) (
  input  wire              clk,
  input  wire              rst_n,
  input  wire [SIZE-1:0]   mul_a,
  input  wire [SIZE-1:0]   mul_b,
  output wire [SIZE*2-1:0] mul_out
);

  wire [SIZE-1:0] [SIZE*2-1:0] mulb_shift;
  reg  [SIZE*2-1:0]            add01_reg;
  reg  [SIZE*2-1:0]            add23_reg;
  reg  [SIZE*2-1:0]            mul_out_reg;

  generate
    genvar i;
    for (i = 0; i < SIZE; i = i + 1) begin : gen_mulb_shift
      assign mulb_shift[i] = mul_a[i] ? (mul_b << i) : {(SIZE*2){1'b0}};
    end
  endgenerate

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      add01_reg <= {(SIZE*2){1'b0}};
      add23_reg <= {(SIZE*2){1'b0}};
      mul_out_reg <= {(SIZE*2){1'b0}};
    end else begin
      add01_reg <= mulb_shift[0] + mulb_shift[1];
      add23_reg <= mulb_shift[2] + mulb_shift[3];
      mul_out_reg <= add01_reg + add23_reg;
    end
  end

  assign mul_out = mul_out_reg;

endmodule