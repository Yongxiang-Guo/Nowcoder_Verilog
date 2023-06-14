// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-10 14:41:51
// Revise Date  : 2023-06-10 14:41:52
// File Name    : ali16.v
// Description  : VL74 on nowcoder
// ======================================================================

module ali16 (
  input  wire clk,
  input  wire rst_n,
  input  wire d,
  output wire dout
);

  reg       dout_reg;
  reg [1:0] rst_n_sync;
  wire      rst_n_sync_release;

  assign rst_n_sync_release = rst_n_sync[1];
  assign dout = dout_reg;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      rst_n_sync <= 2'b00;
    end else begin
      rst_n_sync <= {rst_n_sync[0], rst_n};
    end
  end

  always @(posedge clk or negedge rst_n_sync_release) begin
    if (~rst_n_sync_release) begin
      dout_reg <= 1'b0;
    end else begin
      dout_reg <= d;
    end
  end

endmodule