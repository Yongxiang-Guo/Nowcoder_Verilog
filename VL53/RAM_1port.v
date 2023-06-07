// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-07 16:58:49
// Revise Date  : 2023-06-07 16:58:52
// File Name    : RAM_1port.v
// Description  : VL53 on nowcoder
// ======================================================================

module RAM_1port (
  input  wire       clk,
  input  wire       rst,
  input  wire       enb,
  input  wire [6:0] addr,
  input  wire [3:0] w_data,
  output reg  [3:0] r_data
);

  localparam DATA_WIDTH = 4;
  localparam RAM_DEPTH  = 128;

  reg [RAM_DEPTH-1:0] [DATA_WIDTH-1:0] ram;

  integer i;
  always @(posedge clk or negedge rst) begin
    if(~rst) begin
      for (i = 0; i < RAM_DEPTH; i++) begin
        ram[i] <= {DATA_WIDTH{1'b0}};
      end
    end else if (enb) begin
      ram[addr] <= w_data;
    end
  end

  always @(negedge clk or negedge rst) begin
    if(~rst) begin
      r_data <= {DATA_WIDTH{1'b0}};
    end else if (~enb) begin
      r_data <= ram[addr];
    end
  end

endmodule