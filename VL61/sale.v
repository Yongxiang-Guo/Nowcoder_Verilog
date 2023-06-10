// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-08 14:26:53
// Revise Date  : 2023-06-08 14:26:53
// File Name    : sale.v
// Description  : VL61 on nowcoder
// ======================================================================

module sale (
  input  wire       clk,
  input  wire       rst_n,
  input  wire       sel,
  input  wire [1:0] din,
  output wire [1:0] drinks_out,
  output wire       change_out
);

  reg [1:0] din_sum;
  reg [1:0] drinks_out_reg;
  reg       change_out_reg;

  assign drinks_out = drinks_out_reg;
  assign change_out = change_out_reg;

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      din_sum <= 2'd0;
      drinks_out_reg <= 2'd0;
      change_out_reg <= 1'b0;
    end else if (sel) begin
      case (din)
        2'd0 : begin
          drinks_out_reg <= 2'd0;
          change_out_reg <= 1'b0;
        end
        2'd1 : begin
          if (din_sum == 2'd0) begin
            din_sum <= 2'd1;
            drinks_out_reg <= 2'd0;
            change_out_reg <= 1'b0;
          end else begin
            din_sum <= 2'd0;
            drinks_out_reg <= 2'd2;
            change_out_reg <= 1'b0;
          end
        end
        2'd2 : begin
          if (din_sum == 2'd0) begin
            din_sum <= 2'd0;
            drinks_out_reg <= 2'd2;
            change_out_reg <= 1'b0;
          end else begin
            din_sum <= 2'd0;
            drinks_out_reg <= 2'd2;
            change_out_reg <= 1'b1;
          end
        end
        default : begin
          din_sum <= 2'd0;
          drinks_out_reg <= 2'd0;
          change_out_reg <= 1'b0;
        end
      endcase
    end else begin
      case (din)
        2'd0 : begin
          drinks_out_reg <= 2'd0;
          change_out_reg <= 1'b0;
        end
        2'd1 : begin
          din_sum <= 2'd0;
          drinks_out_reg <= 2'd1;
          change_out_reg <= 1'b0;
        end
        2'd2 : begin
          din_sum <= 2'd0;
          drinks_out_reg <= 2'd1;
          change_out_reg <= 1'b1;
        end
        default : begin
          din_sum <= 2'd0;
          drinks_out_reg <= 2'd0;
          change_out_reg <= 1'b0;
        end
      endcase
    end
  end

endmodule