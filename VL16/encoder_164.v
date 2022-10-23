// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 23, 2022
// Module Name:			encoder_164
// Description:			16-4 encoder
// Additional Comments:	VL16 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module encoder_164 (
	input	wire	[15: 0]		A,
	input	wire				EI,
	output	wire	[3: 0]		L,
	output	wire				GS,
	output	wire				EO
);

wire	[2: 0]	Y_out_1;
wire			GS_out_1;
wire			EO_out_1;
wire	[2: 0]	Y_out_2;
wire			GS_out_2;
wire			EO_out_2;

assign L  = (EI == 1'b0) ? 4'b0000 : 
			((GS_out_2 == 1'b1) ? {1'b1, Y_out_2} : 
			((GS_out_1 == 1'b1) ? {1'b0, Y_out_1} : 4'b0000));
assign GS = GS_out_1 | GS_out_2;
assign EO = EO_out_1 & EO_out_2;

encoder_83 u_encoder_83_1 (
	.I     ( A[7: 0]  ),
	.EI    ( EI       ),
	.Y     ( Y_out_1  ),
	.GS    ( GS_out_1 ),
	.EO    ( EO_out_1 )
);

encoder_83 u_encoder_83_2 (
	.I     ( A[15: 8] ),
	.EI    ( EI       ),
	.Y     ( Y_out_2  ),
	.GS    ( GS_out_2 ),
	.EO    ( EO_out_2 )
);

endmodule


module encoder_83(
   input      [7:0]       I   ,
   input                  EI  ,
   
   output wire [2:0]      Y   ,
   output wire            GS  ,
   output wire            EO    
);
assign Y[2] = EI & (I[7] | I[6] | I[5] | I[4]);
assign Y[1] = EI & (I[7] | I[6] | ~I[5]&~I[4]&I[3] | ~I[5]&~I[4]&I[2]);
assign Y[0] = EI & (I[7] | ~I[6]&I[5] | ~I[6]&~I[4]&I[3] | ~I[6]&~I[4]&~I[2]&I[1]);

assign EO = EI&~I[7]&~I[6]&~I[5]&~I[4]&~I[3]&~I[2]&~I[1]&~I[0];

assign GS = EI&(I[7] | I[6] | I[5] | I[4] | I[3] | I[2] | I[1] | I[0]);
//assign GS = EI&(| I);
         
endmodule

