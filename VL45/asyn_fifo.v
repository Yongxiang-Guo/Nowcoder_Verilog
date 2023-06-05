// ======================================================================
// Copyright (c) 2022-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-01-26
// Revise Date  : 2023-01-26
// File Name    : asyn_fifo.v
// Description  : VL45 on nowcoder
// ======================================================================

module dual_port_RAM #(
  parameter DEPTH = 16,
  parameter WIDTH = 8
) (
  input  wire                     wclk,
  input  wire                     wenc,
  input  wire [$clog2(DEPTH)-1:0] waddr,
  input  wire [WIDTH-1:0]         wdata,
  input  wire                     rclk,
  input  wire                     renc,
  input  wire [$clog2(DEPTH)-1:0] raddr,
  output reg  [WIDTH-1:0]         rdata
);

  reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

  always @(posedge wclk) begin
    if(wenc)
      RAM_MEM[waddr] <= wdata;
  end

  always @(posedge rclk) begin
    if(renc)
      rdata <= RAM_MEM[raddr];
  end

endmodule


module asyn_fifo #(
  parameter DEPTH = 16,
  parameter WIDTH = 8
) (
  input  wire             wclk  , 
  input  wire             rclk  ,   
  input  wire             wrstn ,
  input  wire             rrstn ,
  input  wire             winc  ,
  input  wire             rinc  ,
  input  wire [WIDTH-1:0] wdata ,

  output wire             wfull ,
  output wire             rempty,
  output wire [WIDTH-1:0] rdata
);

  wire [$clog2(DEPTH)-1:0] waddr;
  wire [$clog2(DEPTH)-1:0] raddr;
  wire                     renc;
  wire                     wenc;

  reg  [$clog2(DEPTH)-1:0] waddr_reg;
  reg  [$clog2(DEPTH)-1:0] raddr_reg;

  reg  [1:0]               wfull_rclk_sync;
  reg  [1:0]               rempty_wclk_sync;

  assign waddr = waddr_reg;
  assign raddr = raddr_reg;

  assign wenc = winc & (~wfull_rclk_sync[1]);
  assign renc = rinc & (~rempty_wclk_sync[1]);

  // Write fifo
  always @(posedge wclk or negedge wrstn) begin
    if (~wrstn) begin
      waddr_reg <= 0;
    end else begin
      if (wenc) begin
        if (waddr_reg == DEPTH - 1) begin
          waddr_reg <= 0;
        end else begin
          waddr_reg <= waddr_reg + 1;
        end
      end
    end
  end

  // Read fifo
  always @(posedge rclk or negedge rrstn) begin
    if (~rrstn) begin
      raddr_reg <= 0;
    end else begin
      if (renc) begin
        if (raddr_reg == DEPTH - 1) begin
          raddr_reg <= 0;
        end else begin
          raddr_reg <= raddr_reg + 1;
        end
      end
    end
  end

  // Full flag
  assign wfull = (waddr_reg == raddr_reg) & (~rempty_wclk_sync[1]);

  // Empty flag
  assign rempty = (waddr_reg == raddr_reg) & (~wfull_rclk_sync[1]);

  // sync
  always @(posedge wclk or negedge wrstn) begin
    if (~wrstn) begin
      rempty_wclk_sync <= 2'b11;
    end else begin
      rempty_wclk_sync <= {rempty_wclk_sync[0], rempty};
    end
  end

  always @(posedge rclk or negedge rrstn) begin
    if (~rrstn) begin
      wfull_rclk_sync <= 2'b00;
    end else begin
      wfull_rclk_sync <= {wfull_rclk_sync[0], wfull};
    end
  end

  dual_port_RAM #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH)
  ) i_dual_port_RAM (
    .wclk  ( wclk  ),
    .wenc  ( wenc  ),
    .waddr ( waddr ),
    .wdata ( wdata ),
    .rclk  ( rclk  ),
    .renc  ( renc  ),
    .raddr ( raddr ),
    .rdata ( rdata )
  );

endmodule