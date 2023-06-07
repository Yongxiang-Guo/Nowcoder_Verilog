// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-07 14:42:03
// Revise Date  : 2023-06-07 14:42:03
// File Name    : mux.v
// Description  : VL48 on nowcoder
// ======================================================================

module sync_with_en #(
  parameter DATA_WIDTH = 8,
  parameter SYNC_STAGE = 2,
  parameter RST_VALUE  = {DATA_WIDTH{1'b0}}
) (
  input  wire                  sync_clk,
  input  wire                  sync_rstn,
  input  wire                  sync_en,
  input  wire [DATA_WIDTH-1:0] data_in,
  output wire [DATA_WIDTH-1:0] sync_data_out
);
  
  integer i;
  reg [SYNC_STAGE-1:0][DATA_WIDTH-1:0] data_sync;
  always @(posedge sync_clk or negedge sync_rstn) begin
    if (~sync_rstn) begin
      data_sync <= {SYNC_STAGE{RST_VALUE}};
    end else if (sync_en) begin
      data_sync[0] <= data_in;
      for (i = 1; i < SYNC_STAGE; i = i + 1) begin
        data_sync[i] <= data_sync[i-1];
      end
    end
  end
  assign sync_data_out = data_sync[SYNC_STAGE-1];

endmodule


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


module mux (
  input  wire       clk_a, 
  input  wire       clk_b,   
  input  wire       arstn,
  input  wire       brstn,
  input  wire [3:0] data_in,
  input  wire       data_en,
  output wire [3:0] dataout
);

  wire data_en_async;
  wire data_en_bsync;

  sync_with_en #(
    .DATA_WIDTH ( 1    ),
    .SYNC_STAGE ( 1    ),
    .RST_VALUE  ( 1'b0 )
  ) data_en_aclk_sync (
    .sync_clk      ( clk_a         ),
    .sync_rstn     ( arstn         ),
    .sync_en       ( 1'b1          ),
    .data_in       ( data_en       ),
    .sync_data_out ( data_en_async )
  );

  sync_with_en #(
    .DATA_WIDTH ( 1    ),
    .SYNC_STAGE ( 2    ),
    .RST_VALUE  ( 1'b0 )
  ) data_en_bclk_sync (
    .sync_clk      ( clk_b         ),
    .sync_rstn     ( brstn         ),
    .sync_en       ( 1'b1          ),
    .data_in       ( data_en_async ),
    .sync_data_out ( data_en_bsync )
  );

  wire [3:0] data_in_gray;
  wire [3:0] dataout_gray;

  // Multi-bit signal sync should use gray code
  bin2gray #(
    .WIDTH ( 4 )
  ) u_bin2gray (
    .bin_value  ( data_in      ),
    .gray_value ( data_in_gray )
  );

  // There should exist data_in_gray aclk sync module, while Nowcoder answer is not perfect

  sync_with_en #(
    .DATA_WIDTH ( 4    ),
    // Sync stage should be 2 at least, while Nowcoder answer is not perfect
    .SYNC_STAGE ( 1    ),
    .RST_VALUE  ( 4'd0 )
  ) data_in_sync (
    .sync_clk      ( clk_b         ),
    .sync_rstn     ( brstn         ),
    .sync_en       ( data_en_bsync ),
    .data_in       ( data_in_gray  ),
    .sync_data_out ( dataout_gray  )
  );

  gray2bin #(
    .WIDTH ( 4 )
  ) u_gray2bin (
    .gray_value ( dataout_gray ),
    .bin_value  ( dataout      )
  );

  // There should exist dataout bclk sync module, while Nowcoder answer is not perfect

endmodule