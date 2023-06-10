// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-09 11:12:45
// Revise Date  : 2023-06-09 11:12:45
// File Name    : huawei7.v
// Description  : VL65 on nowcoder
// ======================================================================

module huawei7 (
  input  wire clk,
  input  wire rst,
  output reg  clk_out
);

  // Use standard 3-stage state machine

  reg [1:0] cs;
  reg [1:0] ns;

  // First stage: state register transition
  always @(posedge clk or negedge rst) begin
    if(~rst) begin
      cs <= 2'd0;
    end else begin
      cs <= ns;
    end
  end

  // Second stage: next state transition condition
  always @(*) begin
    case (cs)
      2'd0: ns = 2'd1;
      2'd1: ns = 2'd2;
      2'd2: ns = 2'd3;
      2'd3: ns = 2'd0;
    endcase
  end

  // Third stage: output change dependent on state
  always @(posedge clk or negedge rst) begin
    if(~rst) begin
      clk_out <= 1'b0;
    end else begin
      case (cs)
        2'd0: clk_out <= 1'b1;
        2'd1: clk_out <= 1'b0;
        2'd2: clk_out <= 1'b0;
        2'd3: clk_out <= 1'b0;
      endcase
    end
  end

endmodule