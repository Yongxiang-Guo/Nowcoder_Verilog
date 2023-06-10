// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-08 15:57:21
// Revise Date  : 2023-06-08 15:57:24
// File Name    : huawei6.v
// Description  : VL64 on nowcoder
// ======================================================================

module huawei6 (
  input  wire clk0,
  input  wire clk1,
  input  wire rst,
  input  wire sel,
  output wire clk_out
);

  parameter GLITCH_FREE_METHOD = 0;

  wire clk0_cg;
  wire clk1_cg;
  reg  clk0_en;
  reg  clk1_en;

  generate

    if (GLITCH_FREE_METHOD == 0) begin : gen_method0
      // =============================================
      // Method 0: using clk negedge to sync clk_en
      //           CLKOUT idle state = 0
      // =============================================

      assign clk_out = clk0_cg | clk1_cg;
      assign clk0_cg = clk0_en & clk0;
      assign clk1_cg = clk1_en & clk1;

      always @(negedge clk0 or negedge rst) begin
        if (~rst) begin
          clk0_en <= 1'b0;
        end else begin
          clk0_en <= ~sel & ~clk1_en;
        end
      end

      always @(negedge clk1 or negedge rst) begin
        if (~rst) begin
          clk1_en <= 1'b0;
        end else begin
          clk1_en <= sel & ~clk0_en;
        end
      end
    end

    else begin : gen_method1
      // =============================================
      // Method 1: using clk posedge to sync clk_en
      //           CLKOUT idle state = 1
      // =============================================

      assign clk_out = clk0_cg & clk1_cg;
      assign clk0_cg = ~clk0_en | clk0;
      assign clk1_cg = ~clk1_en | clk1;

      always @(posedge clk0 or negedge rst) begin
        if (~rst) begin
          clk0_en <= 1'b0;
        end else begin
          clk0_en <= ~sel & ~clk1_en;
        end
      end

      always @(posedge clk1 or negedge rst) begin
        if (~rst) begin
          clk1_en <= 1'b0;
        end else begin
          clk1_en <= sel & ~clk0_en;
        end
      end
    end

  endgenerate

endmodule