// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-04-18 22:03:08
// Revise Date  : 2023-04-18 22:03:36
// File Name    : tb_asyn_fifo.sv
// Description  : Testbench for VL45 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_asyn_fifo ();

  localparam DEPTH = 16;
  localparam WIDTH = 8;

  logic             wclk  ;
  logic             rclk  ;
  logic             wrstn ;
  logic             rrstn ;
  logic             winc  ;
  logic             rinc  ;
  logic [WIDTH-1:0] wdata ;
  logic             wfull ;
  logic             rempty;
  logic [WIDTH-1:0] rdata ;

  initial begin
    #1000ns;
    $finish();
  end

  initial begin
    wrstn = 1'b0;
    #16ns;
    wrstn = 1'b1;
  end

  initial begin
    wclk = 1'b0;
    forever begin
      #5ns;
      wclk = ~wclk;
    end
  end

  initial begin
    rrstn = 1'b0;
    #33ns;
    rrstn = 1'b1;
  end

  initial begin
    rclk = 1'b0;
    forever begin
      #8ns;
      rclk = ~rclk;
    end
  end

  initial begin
    winc = 1'b0;
    rinc = 1'b0;
    wdata = 0;
    # 50ns;

    wait(wclk);
    wait(~wclk);
    winc = 1'b1;
    wdata = 1;

  end

  asyn_fifo #(
    .DEPTH  (DEPTH),
    .WIDTH  (WIDTH)
  ) i_asyn_fifo (
    .wclk   (wclk),
    .rclk   (rclk),
    .wrstn  (wrstn),
    .rrstn  (rrstn),
    .winc   (winc),
    .rinc   (rinc),
    .wdata  (wdata),
    .wfull  (wfull),
    .rempty (rempty),
    .rdata  (rdata)
  );

endmodule : tb_asyn_fifo