// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 18, 2022
// Module Name:			tb_lca_4
// Description:			testbench for see Verilog VL12 practice on nowcoder.com
// Additional Comments:	VL12 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_lca_4 ();

logic	[3: 0]		A_in;
logic	[3: 0]		B_in;
logic				C_1;
logic				CO;
logic	[3: 0]		S;

initial begin
	#200ns;
	$finish();
end

initial begin
	A_in = 4'd1;
	B_in = 4'd3;
	C_1  = 1'b0;
	#50ns;
	A_in = 4'd11;
	B_in = 4'd3;
	C_1  = 1'b1;
	#50ns;
	A_in = 4'd11;
	B_in = 4'd4;
	C_1  = 1'b1;
	#50ns;
	A_in = 4'd8;
	B_in = 4'd5;
	C_1  = 1'b0;
end

lca_4 u_lca_4 (
	.A_in    ( A_in ),
	.B_in    ( B_in ),
	.C_1     ( C_1  ),
	.CO      ( CO   ),
	.S       ( S    )
);

endmodule

