// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 23, 2022
// Module Name:			tb_decoder1
// Description:			testbench for full subtractor
// Additional Comments:	VL17 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_decoder1 ();

logic				A;
logic				B;
logic				Ci;
logic				D;
logic				Co;

initial begin
	#200ns;
	$finish();
end

initial begin
	A = 0;
	B = 1;
	Ci = 0;
	#50ns;
	A = 1;
	B = 1;
	Ci = 0;
	#50ns;
	A = 1;
	B = 1;
	Ci = 1;
	#50ns;
	A = 1;
	B = 0;
	Ci = 0;
end

decoder1 u_decoder1 (
	.A     ( A  ),
	.B     ( B  ),
	.Ci    ( Ci ),
	.D     ( D  ),
	.Co    ( Co )
);

endmodule

