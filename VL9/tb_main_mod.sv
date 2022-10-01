// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			tb_main_mod
// Description:			testbench for input data compare
// Additional Comments:	VL9 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_main_mod ();

logic				clk;
logic				rst_n;
logic	[7: 0]		a;
logic	[7: 0]		b;
logic	[7: 0]		c;
logic	[7: 0]		d;

initial begin
	#200ns;
	$finish();
end

initial begin
	rst_n = 1'b0;
	#11ns;
	rst_n = 1'b1;
end

initial begin
	clk = 1'b0;
	forever begin
		#5ns;
		clk = ~clk;
	end
end

initial begin
	a = 10;
	b = 15;
	c = 35;
	#21ns;
	a = 50;
	#20ns;
	b = 44;
	#20ns;
	c = 45;
	#20ns;
	b = 10;
end

main_mod u_main_mod (
	.clk      ( clk   ),
	.rst_n    ( rst_n ),
	.a        ( a     ),
	.b        ( b     ),
	.c        ( c     ),
	.d        ( d     )
);

endmodule

