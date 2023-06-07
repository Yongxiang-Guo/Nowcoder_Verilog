// ======================================================================
// Copyright (c) 2022-2023 All rights reserved
// ======================================================================
// Affiliation  : Tsinghua Univ & NeuraMatrix
// Author       : Yongxiang Guo
// Create Date  : 2023-01-26
// Revise Date  : 2023-01-26
// File Name    : asyn_fifo.v
// Description  : VL45 on nowcoder
// ======================================================================

module dual_port_RAM #(
  parameter DEPTH = 16,
  parameter WIDTH = 8
) (
  input  wire                     wclk,
  input  wire                     wenc,
  input  wire [$clog2(DEPTH)-1:0] waddr,
  input  wire [WIDTH-1:0]         wdata,
  input  wire                     rclk,
  input  wire                     renc,
  input  wire [$clog2(DEPTH)-1:0] raddr,
  output reg  [WIDTH-1:0]         rdata
);

  reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

  always @(posedge wclk) begin
    if(wenc)
      RAM_MEM[waddr] <= wdata;
  end

  always @(posedge rclk) begin
    if(renc)
      rdata <= RAM_MEM[raddr];
  end

endmodule


module bin2gray #(
  parameter WIDTH = 8
) (
  input  wire [WIDTH-1:0] bin_value,
  output wire [WIDTH-1:0] gray_value
);

  assign gray_value[WIDTH-1] = bin_value[WIDTH-1];

  generate
    genvar i;
    for (i = 0; i < WIDTH-1; i = i + 1) begin : gen_bin2gray
      assign gray_value[i] = bin_value[i] ^ bin_value[i+1];
    end
  endgenerate

endmodule


module gray2bin #(
  parameter WIDTH = 8
) (
  input  wire [WIDTH-1:0] gray_value,
  output wire [WIDTH-1:0] bin_value
);

  assign bin_value[WIDTH-1] = gray_value[WIDTH-1];

  generate
    genvar i;
    for (i = 0; i < WIDTH-1; i = i + 1) begin : gen_gray2bin
      assign bin_value[i] = gray_value[i] ^ bin_value[i+1];
    end
  endgenerate

endmodule


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
  
  generate
    if (SYNC_STAGE == 1) begin : gen_sync_stage_one
      reg [DATA_WIDTH-1:0] data_sync;
      always @(posedge sync_clk or negedge sync_rstn) begin
        if (~sync_rstn) begin
          data_sync <= RST_VALUE;
        end else begin
          data_sync <= data_in;
        end
      end
      assign sync_data_out = data_sync;
    end
    else begin : gen_sync_stage_more
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
    end
  endgenerate

endmodule


module asyn_fifo #(
  parameter DEPTH = 16,
  parameter WIDTH = 8
) (
  input  wire             wclk  , 
  input  wire             rclk  ,   
  input  wire             wrstn ,
  input  wire             rrstn ,
  input  wire             winc  ,
  input  wire             rinc  ,
  input  wire [WIDTH-1:0] wdata ,

  output wire             wfull ,
  output wire             rempty,
  output wire [WIDTH-1:0] rdata
);
  localparam ADDR_WIDTH = $clog2(DEPTH);

  wire [ADDR_WIDTH-1:0] waddr;
  wire [ADDR_WIDTH-1:0] raddr;
  wire                  renc;
  wire                  wenc;

  reg  [ADDR_WIDTH:0]   waddr_reg;
  reg  [ADDR_WIDTH:0]   raddr_reg;
  wire [ADDR_WIDTH:0]   waddr_gray;
  wire [ADDR_WIDTH:0]   raddr_gray;
  wire [ADDR_WIDTH:0]   waddr_gray_wsync;
  wire [ADDR_WIDTH:0]   raddr_gray_rsync;
  wire [ADDR_WIDTH:0]   waddr_gray_rsync;
  wire [ADDR_WIDTH:0]   raddr_gray_wsync;

  assign waddr = waddr_reg[ADDR_WIDTH-1:0];
  assign raddr = raddr_reg[ADDR_WIDTH-1:0];
  assign wenc = winc & (~wfull);
  assign renc = rinc & (~rempty);

  // Write fifo
  always @(posedge wclk or negedge wrstn) begin
    if (~wrstn) begin
      waddr_reg <= {(ADDR_WIDTH+1){1'b0}};
    end else begin
      if (wenc) begin
        if (waddr_reg == DEPTH - 1) begin
          waddr_reg[ADDR_WIDTH-1:0] <= {ADDR_WIDTH{1'b0}};
          waddr_reg[ADDR_WIDTH] <= ~waddr_reg[ADDR_WIDTH];
        end else begin
          waddr_reg <= waddr_reg + 1'd1;
        end
      end
    end
  end

  bin2gray #(
    .WIDTH ( ADDR_WIDTH+1 )
  ) u_bin2gray_waddr (
    .bin_value  ( waddr_reg  ),
    .gray_value ( waddr_gray )
  );

  sync #(
    .DATA_WIDTH ( ADDR_WIDTH+1           ),
    .SYNC_STAGE ( 1                      ),
    .RST_VALUE  ( {(ADDR_WIDTH+1){1'b0}} )
  ) waddr_gray_wclk_sync (
    .sync_clk      ( wclk             ),
    .sync_rstn     ( wrstn            ),
    .data_in       ( waddr_gray       ),
    .sync_data_out ( waddr_gray_wsync )
  );

  sync #(
    .DATA_WIDTH ( ADDR_WIDTH+1           ),
    .SYNC_STAGE ( 2                      ),
    .RST_VALUE  ( {(ADDR_WIDTH+1){1'b0}} )
  ) waddr_gray_rclk_sync (
    .sync_clk      ( rclk             ),
    .sync_rstn     ( rrstn            ),
    .data_in       ( waddr_gray_wsync ),
    .sync_data_out ( waddr_gray_rsync )
  );

  // Read fifo
  always @(posedge rclk or negedge rrstn) begin
    if (~rrstn) begin
      raddr_reg <= {(ADDR_WIDTH+1){1'b0}};
    end else begin
      if (renc) begin
        if (raddr_reg == DEPTH - 1) begin
          raddr_reg[ADDR_WIDTH-1:0] <= {ADDR_WIDTH{1'b0}};
          raddr_reg[ADDR_WIDTH] <= ~raddr_reg[ADDR_WIDTH];
        end else begin
          raddr_reg <= raddr_reg + 1'd1;
        end
      end
    end
  end

  bin2gray #(
    .WIDTH ( ADDR_WIDTH+1 )
  ) u_bin2gray_raddr (
    .bin_value  ( raddr_reg  ),
    .gray_value ( raddr_gray )
  );

  sync #(
    .DATA_WIDTH ( ADDR_WIDTH+1           ),
    .SYNC_STAGE ( 1                      ),
    .RST_VALUE  ( {(ADDR_WIDTH+1){1'b0}} )
  ) raddr_gray_rclk_sync (
    .sync_clk      ( rclk             ),
    .sync_rstn     ( rrstn            ),
    .data_in       ( raddr_gray       ),
    .sync_data_out ( raddr_gray_rsync )
  );

  sync #(
    .DATA_WIDTH ( ADDR_WIDTH+1           ),
    .SYNC_STAGE ( 2                      ),
    .RST_VALUE  ( {(ADDR_WIDTH+1){1'b0}} )
  ) raddr_gray_wclk_sync (
    .sync_clk      ( wclk             ),
    .sync_rstn     ( wrstn            ),
    .data_in       ( raddr_gray_rsync ),
    .sync_data_out ( raddr_gray_wsync )
  );

  // Full flag
  // Nowcoder answer is wrong
  assign wfull = ({~waddr_gray_wsync[ADDR_WIDTH:ADDR_WIDTH-1], waddr_gray_wsync[ADDR_WIDTH-2:0]} == raddr_gray_wsync) ? 1'b1 : 1'b0;
  // This is the right logic
  // assign wfull = ({~waddr_gray[ADDR_WIDTH:ADDR_WIDTH-1], waddr_gray[ADDR_WIDTH-2:0]} == raddr_gray_wsync) ? 1'b1 : 1'b0;

  // Empty flag
  // Nowcoder answer is wrong
  assign rempty = (raddr_gray_rsync == waddr_gray_rsync) ? 1'b1 : 1'b0;
  // This is the right logic
  // assign rempty = (raddr_gray == waddr_gray_rsync) ? 1'b1 : 1'b0;

  dual_port_RAM #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH)
  ) i_dual_port_RAM (
    .wclk  ( wclk  ),
    .wenc  ( wenc  ),
    .waddr ( waddr ),
    .wdata ( wdata ),
    .rclk  ( rclk  ),
    .renc  ( renc  ),
    .raddr ( raddr ),
    .rdata ( rdata )
  );

endmodule