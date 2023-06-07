// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-07 17:10:17
// Revise Date  : 2023-06-07 17:10:17
// File Name    : ram_mod.v
// Description  : VL54 on nowcoder
// ======================================================================

module ram_mod (
  input  wire       clk,
  input  wire       rst_n,
  
  input  wire       write_en,
  input  wire [7:0] write_addr,
  input  wire [3:0] write_data,
  
  input  wire       read_en,
  input  wire [7:0] read_addr,
  output reg  [3:0] read_data
);

  localparam DATA_WIDTH = 4;
  localparam RAM_DEPTH  = 8;

  reg [RAM_DEPTH-1:0] [DATA_WIDTH-1:0] ram;

  integer i;
  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      for (i = 0; i < RAM_DEPTH; i++) begin
        ram[i] <= {DATA_WIDTH{1'b0}};
      end
    end else if (write_en) begin
      ram[write_addr] <= write_data;
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      read_data <= {DATA_WIDTH{1'b0}};
    end else if (read_en) begin
      read_data <= ram[read_addr];
    end
  end

endmodule