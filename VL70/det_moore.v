// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-09 13:47:20
// Revise Date  : 2023-06-09 13:47:22
// File Name    : det_moore.v
// Description  : VL70 on nowcoder
// ======================================================================

module det_moore (
  input  wire clk,
  input  wire rst_n,
  input  wire din,
  output reg  Y
);

  // Use standard 3-stage state machine

  reg [2:0] cs;
  reg [2:0] ns;

  localparam S_IDLE  = 3'd0;
  localparam S_BIT2  = 3'd1;
  localparam S_BIT3  = 3'd2;
  localparam S_BIT4  = 3'd3;
  localparam S_VALID = 3'd4;

  // First stage: state register transition
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      cs <= S_IDLE;
    end else begin
      cs <= ns;
    end
  end

  // Second stage: next state transition condition
  always @(*) begin
    case (cs)
      S_IDLE: begin
        if (din == 1'b1) begin
          ns = S_BIT2;
        end else begin
          ns = S_IDLE;
        end
      end
      S_BIT2: begin
        if (din == 1'b1) begin
          ns = S_BIT3;
        end else begin
          ns = S_IDLE;
        end
      end
      S_BIT3: begin
        if (din == 1'b0) begin
          ns = S_BIT4;
        end else begin
          ns = S_IDLE;
        end
      end
      S_BIT4: begin
        if (din == 1'b1) begin
          ns = S_VALID;
        end else begin
          ns = S_IDLE;
        end
      end
      S_VALID: begin
        if (din == 1'b1) begin
          ns = S_BIT2;
        end else begin
          ns = S_IDLE;
        end
      end
    endcase
  end

  // Third stage: output change dependent on state
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      Y <= 1'b0;
    end else begin
      Y <= (cs == S_VALID);
    end
  end

endmodule