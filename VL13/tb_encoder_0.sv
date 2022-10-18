// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 18, 2022
// Module Name:			tb_encoder_0
// Description:			testbench for priority encoder
// Additional Comments:	VL13 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_encoder_0 ();

logic	[8: 0]		I_n;
logic	[3: 0]		Y_n;

initial begin
	#200ns;
	$finish();
end

initial begin
	I_n = 9'b101010000;
	#50ns;
	I_n = 9'b111010000;
	#50ns;
	I_n = 9'b111111100;
	#50ns;
	I_n = 9'b111111111;
end

encoder_0 u_encoder_0 (
	.I_n    ( I_n ),
	.Y_n    ( Y_n )
);

endmodule

