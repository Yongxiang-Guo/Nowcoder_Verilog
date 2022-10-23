// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 23, 2022
// Module Name:			decoder0
// Description:			decoder
// Additional Comments:	VL19 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module decoder0 (
	input	wire				A,
	input	wire				B,
	input	wire				C,
	output	wire				L
);

wire	Y0_n;
wire	Y1_n;
wire	Y2_n;
wire	Y3_n;
wire	Y4_n;
wire	Y5_n;
wire	Y6_n;
wire	Y7_n;

assign L = ~(Y1_n & Y3_n & Y6_n & Y7_n);

decoder_38 u_decoder_38 (
	.E1_n    ( 1'b0 ),
	.E2_n    ( 1'b0 ),
	.E3      ( 1'b1 ),
	.A0      ( C    ),
	.A1      ( B    ),
	.A2      ( A    ),
	.Y0_n    ( Y0_n ),
	.Y1_n    ( Y1_n ),
	.Y2_n    ( Y2_n ),
	.Y3_n    ( Y3_n ),
	.Y4_n    ( Y4_n ),
	.Y5_n    ( Y5_n ),
	.Y6_n    ( Y6_n ),
	.Y7_n    ( Y7_n )
);

endmodule


module decoder_38(
   input             E1_n   ,
   input             E2_n   ,
   input             E3     ,
   input             A0     ,
   input             A1     ,
   input             A2     ,
   
   output wire       Y0_n   ,  
   output wire       Y1_n   , 
   output wire       Y2_n   , 
   output wire       Y3_n   , 
   output wire       Y4_n   , 
   output wire       Y5_n   , 
   output wire       Y6_n   , 
   output wire       Y7_n   
);
wire E;
assign E = E3 & ~E2_n & ~E1_n;
assign  Y0_n = ~(E & ~A2 & ~A1 & ~A0);
assign  Y1_n = ~(E & ~A2 & ~A1 &  A0);
assign  Y2_n = ~(E & ~A2 &  A1 & ~A0);
assign  Y3_n = ~(E & ~A2 &  A1 &  A0);
assign  Y4_n = ~(E &  A2 & ~A1 & ~A0);
assign  Y5_n = ~(E &  A2 & ~A1 &  A0);
assign  Y6_n = ~(E &  A2 &  A1 & ~A0);
assign  Y7_n = ~(E &  A2 &  A1 &  A0);

endmodule

