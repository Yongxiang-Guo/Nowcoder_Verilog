// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-08 15:22:17
// Revise Date  : 2023-06-08 15:29:27
// File Name    : sequence_generator.v
// Description  : VL62 on nowcoder
// ======================================================================

module sequence_generator (
  input  wire clk,
  input  wire rst_n,
  output reg  data
);

  reg [5:0] code;

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      code <= 6'b001011;
      data <= 1'b0;
    end else begin
      code <= {code[4:0], code[5]};
      data <= code[5];
    end
  end

endmodule