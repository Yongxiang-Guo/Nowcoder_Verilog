// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 18, 2022
// Module Name:			tb_encoder_83
// Description:			testbench for 83 encoder
// Additional Comments:	VL15 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_encoder_83 ();

logic	[7: 0]		I;
logic				EI;
logic	[2: 0]		Y;
logic				GS;
logic				EO;

initial begin
	#200ns;
	$finish();
end

initial begin
	I = 8'b01000010;
	EI = 1'b1;
	#50ns;
	I = 8'b01000010;
	EI = 1'b0;
	#50ns;
	I = 8'b00001010;
	EI = 1'b1;
	#50ns;
	I = 8'b00000000;
	EI = 1'b1;
end

encoder_83 u_encoder_83 (
	.I     ( I  ),
	.EI    ( EI ),
	.Y     ( Y  ),
	.GS    ( GS ),
	.EO    ( EO )
);

endmodule

