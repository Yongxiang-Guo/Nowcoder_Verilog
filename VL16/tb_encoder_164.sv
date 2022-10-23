// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 23, 2022
// Module Name:			tb_encoder_164
// Description:			testbench for 16-4 encoder
// Additional Comments:	VL16 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_encoder_164 ();

logic	[15: 0]		A;
logic				EI;
logic	[3: 0]		L;
logic				GS;
logic				EO;

initial begin
	#200ns;
	$finish();
end

initial begin
	A = 16'd0;
	EI = 1'b1;
	#50ns;
	A = 16'd1;
	EI = 1'b1;
	#50ns;
	A = 16'd1028;
	EI = 1'b1;
	#50ns;
	A = 16'd256;
	EI = 1'b0;
end

encoder_164 u_encoder_164 (
	.A     ( A  ),
	.EI    ( EI ),
	.L     ( L  ),
	.GS    ( GS ),
	.EO    ( EO )
);

endmodule

