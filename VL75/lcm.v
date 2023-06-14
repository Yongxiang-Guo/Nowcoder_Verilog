// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-10 15:04:34
// Revise Date  : 2023-06-10 15:04:35
// File Name    : lcm.v
// Description  : VL75 on nowcoder
// ======================================================================

module lcm #(
  parameter DATA_W = 8
) (
  input  wire [DATA_W-1:0]   A,
  input  wire [DATA_W-1:0]   B,
  input  wire                vld_in,
  input  wire                rst_n,
  input  wire                clk,
  output wire [DATA_W*2-1:0] lcm_out,
  output wire [DATA_W-1:0]   mcd_out,
  output wire                vld_out
);

  reg  [DATA_W-1:0] A_reg;
  reg  [DATA_W-1:0] B_reg;
  reg               cal_en;
  reg               cal_done;
  reg  [DATA_W-1:0] mcd_result;

  wire [DATA_W-1:0] A_last_one;
  wire [DATA_W-1:0] B_last_one;
  wire [$clog2(DATA_W)-1:0] mcd_con;

  wire [DATA_W-1:0] A_cal_init;
  wire [DATA_W-1:0] B_cal_init;
  reg  [DATA_W-1:0] A_cal;
  reg  [DATA_W-1:0] B_cal;

  wire [DATA_W-1:0] Acal_last_one;
  wire [DATA_W-1:0] Bcal_last_one;
  wire [DATA_W-1:0] Acal_odd;
  wire [DATA_W-1:0] Bcal_odd;

  reg  [1:0] cal_cs;
  reg  [1:0] cal_ns;

  localparam S_IDLE = 2'd0;
  localparam S_INIT = 2'd1;
  localparam S_CAL0 = 2'd2;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      A_reg <= {DATA_W{1'b0}};
      B_reg <= {DATA_W{1'b0}};
      cal_en <= 1'b0;
    end else if (vld_in) begin
      A_reg <= A;
      B_reg <= B;
      cal_en <= 1'b1;
    end else if (vld_out) begin
      cal_en <= 1'b0;
    end
  end

  assign A_last_one = ~(A_reg - 1'b1) & A_reg;
  assign B_last_one = ~(B_reg - 1'b1) & B_reg;
  assign mcd_con = (A_last_one > B_last_one) ? $clog2(B_last_one) : $clog2(A_last_one);
  assign A_cal_init = A_reg >> $clog2(A_last_one);
  assign B_cal_init = B_reg >> $clog2(B_last_one);

  assign Acal_last_one = ~(A_cal - 1'b1) & A_cal;
  assign Bcal_last_one = ~(B_cal - 1'b1) & B_cal;
  assign Acal_odd = A_cal >> $clog2(Acal_last_one);
  assign Bcal_odd = B_cal >> $clog2(Bcal_last_one);

  assign vld_out = cal_done;
  assign mcd_out = mcd_result;
  assign lcm_out = A_reg * B_reg / mcd_out;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      cal_cs <= S_IDLE;
    end else begin
      cal_cs <= cal_ns;
    end
  end

  always @(*) begin
    cal_ns = cal_cs;
    case (cal_cs)
      S_IDLE: begin
        if (vld_in) begin
          cal_ns = S_INIT;
        end
      end
      S_INIT: begin
        cal_ns = S_CAL0;
      end
      S_CAL0: begin
        if (vld_out) begin
          cal_ns = S_IDLE;
        end
      end
    endcase
  end

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      A_cal <= {DATA_W{1'b0}};
      B_cal <= {DATA_W{1'b0}};
      cal_done <= 1'b0;
      mcd_result <= {DATA_W{1'b0}};
    end else begin
      case (cal_cs)
      S_IDLE: begin
        cal_done <= 1'b0;
      end
        S_INIT: begin
          A_cal <= A_cal_init;
          B_cal <= B_cal_init;
        end
        S_CAL0: begin
          if (Acal_odd == Bcal_odd) begin
            cal_done <= 1'b1;
            mcd_result <= Acal_odd << mcd_con;
          end else begin
            A_cal <= (Acal_odd > Bcal_odd) ? (Acal_odd - Bcal_odd) : (Bcal_odd - Acal_odd);
            B_cal <= (Acal_odd > Bcal_odd) ? Bcal_odd : Acal_odd;
          end
        end
      endcase
    end
  end

endmodule