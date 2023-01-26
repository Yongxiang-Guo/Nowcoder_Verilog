// ======================================================================
// Copyright (c) 2022-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-01-16
// Revise Date  : 2023-01-16
// File Name    : div_M_N.v
// Description  : VL41 on nowcoder
// ======================================================================

module div_M_N (
  input  wire clk_in,
  input  wire rst,
  output wire clk_out
);
parameter M_N = 8'd87; 
parameter c89 = 8'd24;
parameter div_e = 5'd8;
parameter div_o = 5'd9;

reg [7:0] cnt;
reg [4:0] cnt_e;
reg [4:0] cnt_o;
reg       clk_div_e;
reg       clk_div_o;
reg       clk_sel;

assign clk_out = clk_div_e | clk_div_o;

always @(posedge clk_in or negedge rst) begin
  if (~rst) begin
    cnt <= 8'd0;
  end
  else begin
    if (cnt == M_N - 8'd1) begin
      cnt <= 8'd0;
    end
    else begin
      cnt <= cnt + 8'd1;
    end
  end
end

always @(posedge clk_in or negedge rst) begin
  if (~rst) begin
    clk_sel <= 1'b0;
  end
  else begin
    if (cnt == c89 - 8'd1) begin
      clk_sel <= 1'b1;
    end
    else if (cnt == M_N - 8'd1) begin
      clk_sel <= 1'b0;
    end
  end
end

always @(posedge clk_in or negedge rst) begin
  if (~rst) begin
    cnt_e <= 5'd0;
  end
  else if (~clk_sel) begin
    if (cnt_e == div_e - 5'd1) begin
      cnt_e <= 5'd0;
    end
    else begin
      cnt_e <= cnt_e + 5'd1;
    end
  end
end

always @(posedge clk_in or negedge rst) begin
  if (~rst) begin
    clk_div_e <= 1'b0;
  end
  else if (~clk_sel) begin
    if (cnt_e == (div_e >> 1)) begin
      clk_div_e <= 1'b0;
    end
    else if (cnt_e == 5'd0) begin
      clk_div_e <= 1'b1;
    end
  end
end

always @(posedge clk_in or negedge rst) begin
  if (~rst) begin
    cnt_o <= 5'd0;
  end
  else if (clk_sel) begin
    if (cnt_o == div_o - 5'd1) begin
      cnt_o <= 5'd0;
    end
    else begin
      cnt_o <= cnt_o + 5'd1;
    end
  end
end

always @(posedge clk_in or negedge rst) begin
  if (~rst) begin
    clk_div_o <= 1'b0;
  end
  else if (clk_sel) begin
    if (cnt_o == (div_o >> 1)) begin
      clk_div_o <= 1'b0;
    end
    else if (cnt_o == 5'd0) begin
      clk_div_o <= 1'b1;
    end
  end
end

endmodule