// ======================================================================
// Copyright (c) 2022-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-01-16
// Revise Date  : 2023-01-16
// File Name    : tb_seller1.sv
// Description  : Testbench of seller1.v
// ======================================================================

`timescale 1ns/1ns

module tb_seller1 ();

logic clk;
logic rst_n;
logic d1;
logic d2;
logic d3;
logic out1;
logic [1:0] out2;

initial begin
  clk = 1'b0;
  forever begin
    #10ns;
    clk = ~clk;
  end
end

initial begin
  rst_n = 1'b0;
  d1 = 1'b0;
  d2 = 1'b0;
  d3 = 1'b0;
  #(28ns);
  rst_n = 1'b1;
  #(20ns);

  @(posedge clk);
  {d1, d2, d3} = 3'b100;
  @(negedge clk);
  {d1, d2, d3} = 3'b000;
  #(50ns);

  @(posedge clk);
  {d1, d2, d3} = 3'b010;
  @(negedge clk);
  {d1, d2, d3} = 3'b000;
  #(30ns);

  @(posedge clk);
  {d1, d2, d3} = 3'b100;
  @(negedge clk);
  {d1, d2, d3} = 3'b000;
  #(60ns);

  @(posedge clk);
  {d1, d2, d3} = 3'b100;
  @(negedge clk);
  {d1, d2, d3} = 3'b000;
  #(50ns);

  @(posedge clk);
  {d1, d2, d3} = 3'b001;
  @(negedge clk);
  {d1, d2, d3} = 3'b000;
  #(50ns);

  @(posedge clk);
  {d1, d2, d3} = 3'b001;
  @(negedge clk);
  {d1, d2, d3} = 3'b000;
  #(30ns);

  @(posedge clk);
  {d1, d2, d3} = 3'b100;
  @(negedge clk);
  {d1, d2, d3} = 3'b000;
  #(60ns);

  @(posedge clk);
  {d1, d2, d3} = 3'b001;
  @(negedge clk);
  {d1, d2, d3} = 3'b000;
  #(50ns);

  @(posedge clk);
  {d1, d2, d3} = 3'b010;
  @(negedge clk);
  {d1, d2, d3} = 3'b000;
  #(60ns);

  @(posedge clk);
  {d1, d2, d3} = 3'b010;
  @(negedge clk);
  {d1, d2, d3} = 3'b000;
  #(50ns);

  $finish;
end

seller1 i_seller1 (
  .clk(clk),
  .rst(rst_n),
  .d1(d1),
  .d2(d2),
  .d3(d3),
  .out1(out1),
  .out2(out2)
);


endmodule : tb_seller1