// ======================================================================
// Copyright (c) 2022-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-01-17
// Revise Date  : 2023-01-17
// File Name    : fsm2.v
// Description  : VL44 on nowcoder
// ======================================================================

module fsm2 (
  input  wire clk,
  input  wire rst,
  input  wire data,
  output reg  flag
);

parameter s0 = 3'd0;
parameter s1 = 3'd1;
parameter s2 = 3'd2;
parameter s3 = 3'd3;
parameter s4 = 3'd4;

reg [2:0] state;
reg [2:0] state_next;

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
  flag <= 1'b0;
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
        state_next <= s4;
      end
    end
    s4: begin
      flag <= 1'b1;
      if (data) begin
        state_next <= s1;
      end
      else begin
        state_next <= s0;
      end
    end
  endcase
end

endmodule