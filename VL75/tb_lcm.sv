// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-15 10:13:18
// Revise Date  : 2023-06-15 10:13:18
// File Name    : tb_lcm.sv
// Description  : VL75 on nowcoder
// ======================================================================

module tb_lcm ();

  logic clk;
  initial begin
    clk = 1'b0;
    forever #(5) clk = ~clk;
  end

  logic rst_n;
  initial begin
    rst_n <= 1'b0;
    #12
    rst_n <= 1'b1;
  end

  parameter  DATA_W = 8;

  logic [DATA_W-1:0]   A;
  logic [DATA_W-1:0]   B;
  logic                vld_in;
  logic [DATA_W*2-1:0] lcm_out;
  logic [DATA_W-1:0]   mcd_out;
  logic                vld_out;

  lcm #(
    .DATA_W(DATA_W)
  ) u_lcm (
    .A       (A),
    .B       (B),
    .vld_in  (vld_in),
    .rst_n   (rst_n),
    .clk     (clk),
    .lcm_out (lcm_out),
    .mcd_out (mcd_out),
    .vld_out (vld_out)
  );

  initial begin
    A = 8'd12;
    B = 8'd20;
    vld_in = 1'b0;

    wait(clk);
    wait(~clk);
    vld_in = 1'b1;

    wait(clk);
    wait(~clk);
    vld_in = 1'b0;
    A = 8'd15;
    B = 8'd21;

    #(100);
    wait(clk);
    wait(~clk);
    vld_in = 1'b1;

    wait(clk);
    wait(~clk);
    vld_in = 1'b0;
    #(100);

    $finish;
  end

  initial begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars("+all");
  end
endmodule