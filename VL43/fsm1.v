// ======================================================================
// Copyright (c) 2022-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-01-17
// Revise Date  : 2023-01-17
// File Name    : fsm1.v
// Description  : VL43 on nowcoder
// ======================================================================

module fsm1 (
  input  wire clk,
  input  wire rst,
  input  wire data,
  output reg  flag
);

parameter s0 = 2'd0;
parameter s1 = 2'd1;
parameter s2 = 2'd2;
parameter s3 = 2'd3;

reg [1:0] state;
reg [1:0] state_next;

always @(posedge clk or negedge rst) begin
  if (~rst) begin
    state <= s0;
  end
  else begin
    state <= state_next;
  end
end

always @(*) begin
  state_next <= state;
  case (state)
    s0: begin
      if (data) begin
        state_next <= s1;
      end
    end
    s1: begin
      if (data) begin
        state_next <= s2;
      end
    end
    s2: begin
      if (data) begin
        state_next <= s3;
      end
    end
    s3: begin
      if (data) begin
        state_next <= s0;
      end
    end
  endcase
end

always @(posedge clk or negedge rst) begin
  if (~rst) begin
    flag <= 1'b0;
  end
  else begin
    if ((state == s3) && (data == 1'b1)) begin
      flag <= 1'b1;
    end
    else begin
      flag <= 1'b0;
    end
  end
end

endmodule