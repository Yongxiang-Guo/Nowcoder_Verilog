// ======================================================================
// Copyright (c) 2023-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-06-09 13:37:48
// Revise Date  : 2023-06-09 13:37:50
// File Name    : pulse_detect.v
// Description  : VL69 on nowcoder
// ======================================================================

module sync #(
  parameter DATA_WIDTH = 8,
  parameter SYNC_STAGE = 2,
  parameter RST_VALUE  = {DATA_WIDTH{1'b0}}
) (
  input  wire                  sync_clk,
  input  wire                  sync_rstn,
  input  wire [DATA_WIDTH-1:0] data_in,
  output wire [DATA_WIDTH-1:0] sync_data_out
);
  
  integer i;
  reg [SYNC_STAGE-1:0][DATA_WIDTH-1:0] data_sync;
  always @(posedge sync_clk or negedge sync_rstn) begin
    if (~sync_rstn) begin
      data_sync <= {SYNC_STAGE{RST_VALUE}};
    end else begin
      data_sync[0] <= data_in;
      for (i = 1; i < SYNC_STAGE; i = i + 1) begin
        data_sync[i] <= data_sync[i-1];
      end
    end
  end
  assign sync_data_out = data_sync[SYNC_STAGE-1];

endmodule


module pulse_detect (
  input  wire clka, 
  input  wire clkb,   
  input  wire rst_n,
  input  wire sig_a,
  output wire sig_b
);

  reg  pulse_flag;
  wire pulse_flag_ssync0;
  wire pulse_flag_ssync1;
  wire pulse_flag_fsync;

  always @(posedge clka or negedge rst_n) begin
    if(~rst_n) begin
      pulse_flag <= 1'b0;
    end else begin
      if (sig_a) begin
        pulse_flag <= 1'b1;
      end else if (pulse_flag_fsync) begin
        pulse_flag <= 1'b0;
      end
    end
  end

  sync #(
    .DATA_WIDTH ( 1    ),
    .SYNC_STAGE ( 1    ),
    .RST_VALUE  ( 1'b0 )
  ) pulse_flag_sclk_sync0 (
    .sync_clk      ( clkb              ),
    .sync_rstn     ( rst_n             ),
    .data_in       ( pulse_flag        ),
    .sync_data_out ( pulse_flag_ssync0 )
  );

  sync #(
    .DATA_WIDTH ( 1    ),
    .SYNC_STAGE ( 1    ),
    .RST_VALUE  ( 1'b0 )
  ) pulse_flag_sclk_sync1 (
    .sync_clk      ( clkb              ),
    .sync_rstn     ( rst_n             ),
    .data_in       ( pulse_flag_ssync0 ),
    .sync_data_out ( pulse_flag_ssync1 )
  );

  sync #(
    .DATA_WIDTH ( 1    ),
    .SYNC_STAGE ( 2    ),
    .RST_VALUE  ( 1'b0 )
  ) pulse_flag_fclk_sync (
    .sync_clk      ( clka              ),
    .sync_rstn     ( rst_n             ),
    .data_in       ( pulse_flag_ssync0 ),
    .sync_data_out ( pulse_flag_fsync  )
  );

  assign sig_b = pulse_flag_ssync1;

endmodule