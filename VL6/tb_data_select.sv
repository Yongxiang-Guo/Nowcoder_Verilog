// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			tb_data_select
// Description:			testbench for multi-function data calculate
// Additional Comments:	VL6 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_data_select ();

logic						clk;
logic						rst_n;
logic	signed	[7: 0]		a;
logic	signed	[7: 0]		b;
logic			[1: 0]		select;
logic	signed	[8: 0]		c;

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
	a = -20;
	b = 30;
	select = 2'd0;
	#31ns;
	select = 2'd1;
	#30ns;
	select = 2'd2;
	#30ns;
	select = 2'd3;
	#10ns;
	a = 20;
	b = -30;
	#10ns;
	a = 255;
	b = 255;
end

data_select u_data_select (
	.clk       ( clk    ),
	.rst_n     ( rst_n  ),
	.a         ( a      ),
	.b         ( b      ),
	.select    ( select ),
	.c         ( c      )
);

endmodule

