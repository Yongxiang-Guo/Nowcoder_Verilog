// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-08 10:38:09
// Revise Date  : 2023-06-08 10:38:09
// File Name    : triffic_light.v
// Description  : VL57 on nowcoder
// ======================================================================

module triffic_light (
  input  wire       rst_n,
  input  wire       clk,
  input  wire       pass_request,
  output wire [7:0] clock,
  output reg        red,
  output reg        yellow,
  output reg        green
);

  // Requirement: 60 cycles green, 5 cycles yellow, 10 cycles red.
  // When pass_request = 1, if green light time > 10 cycles, turn it to 10 cycles.

  reg [5:0] cnt;

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      cnt <= 6'd63;
      red <= 1'b0;
      yellow <= 1'b0;
      green <= 1'b0;
    end else if (pass_request) begin
      cnt <= (cnt > 6'd10) ? 6'd10 : cnt;
    end else begin
      if (cnt == 6'd61) begin
        red <= 1'b1;
        cnt <= 6'd10;
      end else if (cnt == 6'd1) begin
        red <= ~yellow & green;
        yellow <= ~green & red;
        green <= ~red & yellow;
        cnt <= red ? 6'd5 : (yellow ? 6'd60 : (green ? 6'd10 : cnt));
      end else begin
        cnt <= cnt - 6'd1;
      end
    end
  end

  assign clock = (cnt > 6'd60) ? {2'd0, cnt - 6'd53} : {2'd0, cnt};

endmodule