// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 23, 2022
// Module Name:			tb_decoder0
// Description:			testbench for decoder
// Additional Comments:	VL19 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_decoder0 ();

logic				A;
logic				B;
logic				C;
logic				L;

initial begin
	#200ns;
	$finish();
end

initial begin
	A = 1'b0;
	B = 1'b1;
	C = 1'b0;
	#50ns;
	A = 1'b0;
	B = 1'b1;
	C = 1'b1;
	#50ns;
	A = 1'b1;
	B = 1'b1;
	C = 1'b0;
	#50ns;
	A = 1'b1;
	B = 1'b0;
	C = 1'b0;
end

decoder0 u_decoder0 (
	.A    ( A ),
	.B    ( B ),
	.C    ( C ),
	.L    ( L )
);

endmodule

