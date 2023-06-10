// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-08 12:55:26
// Revise Date  : 2023-06-08 12:55:26
// File Name    : data_driver.v
// Description  : VL60 on nowcoder
// ======================================================================

module sync #(
  parameter DATA_WIDTH = 8,
  parameter SYNC_STAGE = 2,
  parameter RST_VALUE  = {DATA_WIDTH{1'b0}}
) (
  input  wire                  sync_clk,
  input  wire                  sync_rstn,
  input  wire [DATA_WIDTH-1:0] data_in,
  output wire [DATA_WIDTH-1:0] sync_data_out,
  output wire                  rise_edge,
  output wire                  fall_edge,
  output wire                  both_edge
);
  
  integer i;
  reg [SYNC_STAGE:0][DATA_WIDTH-1:0] data_sync;
  always @(posedge sync_clk or negedge sync_rstn) begin
    if (~sync_rstn) begin
      data_sync <= {(SYNC_STAGE+1){RST_VALUE}};
    end else begin
      data_sync[0] <= data_in;
      for (i = 1; i < (SYNC_STAGE + 1); i = i + 1) begin
        data_sync[i] <= data_sync[i-1];
      end
    end
  end
  assign sync_data_out = data_sync[SYNC_STAGE-1];
  assign rise_edge = ~data_sync[SYNC_STAGE] & data_sync[SYNC_STAGE-1];
  assign fall_edge = data_sync[SYNC_STAGE] & ~data_sync[SYNC_STAGE-1];
  assign both_edge = data_sync[SYNC_STAGE] ^ data_sync[SYNC_STAGE-1];

endmodule


module data_driver (
  input  wire       clk_a,
  input  wire       rst_n,
  input  wire       data_ack,
  output wire [3:0] data,
  output reg        data_req
);
  
  reg [2:0] cnt;
  reg [2:0] data_reg;

  assign data = {1'b0, data_reg};

  wire data_ack_sync;

  sync #(
    .DATA_WIDTH ( 1    ),
    .SYNC_STAGE ( 2    ),
    .RST_VALUE  ( 1'b0 )
  ) ack_sync (
    .sync_clk      ( clk_a         ),
    .sync_rstn     ( rst_n         ),
    .data_in       ( data_ack      ),
    .sync_data_out (               ),
    .rise_edge     ( data_ack_sync ),
    .fall_edge     (               ),
    .both_edge     (               )
  );

  always @(posedge clk_a or negedge rst_n) begin
    if(~rst_n) begin
      data_reg <= 3'd0;
      data_req <= 1'b0;
      cnt <= 3'd0;
    end else begin
      if (data_req) begin
        if (data_ack_sync) begin
          data_req <= 1'b0;
          data_reg <= data_reg + 3'd1;
        end
      end else if (cnt == 3'd4) begin
        cnt <= 3'd0;
        data_req <= 1'b1;
      end else begin
        cnt <= cnt + 3'd1;
      end
    end
  end

endmodule


module data_receiver (
  input  wire       clk_b,
  input  wire       rst_n,
  input  wire       data_req,
  input  wire [3:0] data,
  output reg        data_ack
);
  
  wire data_req_sync;

  sync #(
    .DATA_WIDTH ( 1    ),
    .SYNC_STAGE ( 2    ),
    .RST_VALUE  ( 1'b0 )
  ) req_sync (
    .sync_clk      ( clk_b         ),
    .sync_rstn     ( rst_n         ),
    .data_in       ( data_req      ),
    .sync_data_out (               ),
    .rise_edge     ( data_req_sync ),
    .fall_edge     (               ),
    .both_edge     (               )
  );

  always @(posedge clk_b or negedge rst_n) begin
    if(~rst_n) begin
      data_ack <= 1'b0;
    end else if (data_req_sync) begin
      data_ack <= 1'b1;
    end else begin
      data_ack <= 1'b0;
    end
  end

endmodule