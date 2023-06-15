// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-15 11:08:17
// Revise Date  : 2023-06-15 11:08:19
// File Name    : clk_divider.v
// Description  : VL76 on nowcoder
// ======================================================================

module clk_divider #(
  parameter dividor = 5
) (
  input  wire clk_in,
  input  wire rst_n,
  output wire clk_out
);

  localparam rise_edge_cnt = (dividor - 1) >> 1;

  reg clk_div_pos;
  reg clk_div_neg;
  reg [$clog2(dividor)-1:0] clk_cnt;

  assign clk_out = clk_div_pos | clk_div_neg;

  always @(posedge clk_in or negedge rst_n) begin
    if(~rst_n) begin
      clk_div_pos <= 1'b0;
      clk_cnt <= '0;
    end else begin
      if (clk_cnt == rise_edge_cnt) begin
        clk_div_pos <= 1'b1;
        clk_cnt <= clk_cnt + 1'b1;
      end else if (clk_cnt == dividor - 1) begin
        clk_div_pos <= 1'b0;
        clk_cnt <= '0;
      end else begin
        clk_cnt <= clk_cnt + 1'b1;
      end
    end
  end

  always @(negedge clk_in or negedge rst_n) begin
    if(~rst_n) begin
      clk_div_neg <= 1'b0;
    end else begin
      if (clk_cnt == rise_edge_cnt) begin
        clk_div_neg <= 1'b1;
      end else if (clk_cnt == dividor - 1) begin
        clk_div_neg <= 1'b0;
      end
    end
  end

endmodule