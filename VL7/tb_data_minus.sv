// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			tb_data_minus
// Description:			testbench for Calculate the difference between two numbers
// Additional Comments:	VL7 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_data_minus ();

logic				clk;
logic				rst_n;
logic	[7: 0]		a;
logic	[7: 0]		b;
logic	[8: 0]		c;

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
	a = 100;
	b = 60;
	#100ns;
	b = 120;
end

data_minus u_data_minus (
	.clk      ( clk   ),
	.rst_n    ( rst_n ),
	.a        ( a     ),
	.b        ( b     ),
	.c        ( c     )
);

endmodule

