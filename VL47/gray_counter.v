// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-07 14:22:40
// Revise Date  : 2023-06-07 14:22:43
// File Name    : gray_counter.v
// Description  : VL47 on nowcoder
// ======================================================================

module bin2gray #(
  parameter WIDTH = 8
) (
  input  wire [WIDTH-1:0] bin_value,
  output wire [WIDTH-1:0] gray_value
);

  assign gray_value = bin_value ^ (bin_value >> 1);

endmodule


module gray2bin #(
  parameter WIDTH = 8
) (
  input  wire [WIDTH-1:0] gray_value,
  output wire [WIDTH-1:0] bin_value
);

  assign bin_value = gray_value ^ (bin_value >> 1);

endmodule


module gray_counter (
  input  wire       clk,
  input  wire       rst_n,
  output wire [3:0] gray_out
);

  reg        count_flag;
  reg  [3:0] count_num;
  wire [3:0] count_num_gray;
  reg  [3:0] count_num_gray_reg;

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      count_flag <= 1'b0;
      count_num  <= 4'd0;
    end else begin
      count_flag <= ~count_flag;
      if (count_flag == 1'b0) begin
        count_num <= count_num + 4'd1;
      end
    end
  end

  bin2gray #(
    .WIDTH ( 4 )
  ) u_bin2gray (
    .bin_value  ( count_num      ),
    .gray_value ( count_num_gray )
  );

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      count_num_gray_reg <= 4'd0;
    end else begin
      count_num_gray_reg <= count_num_gray;
    end
  end

  assign gray_out = count_num_gray_reg;

endmodule