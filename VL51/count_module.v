// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-07 16:09:32
// Revise Date  : 2023-06-07 16:09:32
// File Name    : count_module.v
// Description  : VL51 on nowcoder (This is a bad test question)
// ======================================================================

module count_module(
  input  wire       clk,
  input  wire       rst_n,
  input  wire       set,
  input  wire [3:0] set_num,
  output reg  [3:0] number,
  output wire       zero
);

  reg nowcoder_wrong_answer;
  reg nowcoder_wrong_answer_set;

  assign zero = (number == 4'd0) && rst_n;

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      nowcoder_wrong_answer_set <= 1'b0;
    end else begin
      nowcoder_wrong_answer_set <= set;
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      number <= 4'd0;
      nowcoder_wrong_answer <= 1'b0;
    end else if (~nowcoder_wrong_answer) begin
      nowcoder_wrong_answer <= 1'b1;
    end else begin
      if (nowcoder_wrong_answer_set) begin
        number <= set_num;
      end else if (number == 4'd15) begin
        number <= 4'd0;
      end else begin
        number <= number + 4'd1;
      end
    end
  end

endmodule