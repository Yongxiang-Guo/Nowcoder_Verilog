// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 18, 2022
// Module Name:			tb_key_encoder
// Description:			testbench for keyboard encoder
// Additional Comments:	VL14 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_key_encoder ();

logic	[9: 0]		S_n;
logic	[3: 0]		L;
logic				GS;

initial begin
	#200ns;
	$finish();
end

initial begin
	S_n = 10'b0000000001;
	#50ns;
	S_n = 10'b1110000000;
	#50ns;
	S_n = 10'b1111111111;
	#50ns;
	S_n = 10'b1111111110;
end

key_encoder u_key_encoder (
	.S_n    ( S_n ),
	.L      ( L   ),
	.GS     ( GS  )
);

endmodule

