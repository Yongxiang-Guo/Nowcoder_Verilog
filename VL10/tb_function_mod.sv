// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 17, 2022
// Module Name:			tb_function_mod
// Description:			testbench for "function" statement
// Additional Comments:	VL10 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_function_mod ();

logic	[3: 0]		a;
logic	[3: 0]		b;
logic	[3: 0]		c;
logic	[3: 0]		d;

initial begin
	#200ns;
	$finish();
end

initial begin
	a = 4'b1010;
	b = 4'b0101;
	#50ns;
	a = ~a;
	b = ~b;
	#50ns;
	a = a + 4'd1;
	b = b + 4'd1;
	#50ns;
	a = a + 4'd1;
	b = b + 4'd1;
end

function_mod u_function_mod (
	.a    ( a ),
	.b    ( b ),
	.c    ( c ),
	.d    ( d )
);

endmodule

