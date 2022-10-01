// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			tb_Tff_2
// Description:			testbench for two TFF with async reset
// Additional Comments:	VL2 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_Tff_2 ();

logic				rst;
logic				clk;
logic				data;
logic				q;

initial begin
	rst		= 1'b0;
	#10ns;
	rst		= 1'b1;
	#100ns;
	$finish();
end

initial begin
	clk		= 1'b0;
	forever begin
		#3ns
		clk		= ~clk;
		#2ns
		clk		= ~clk;
	end
end

initial begin
	data	= 1'b1;
	#40ns;
	data	= 1'b0;
	#20ns;
	data	= 1'b1;
	#20ns;
	data	= 1'b0;
end

Tff_2 u_Tff_2 (
	.rst     ( rst  ),
	.clk     ( clk  ),
	.data    ( data ),
	.q       ( q    )
);

endmodule : tb_Tff_2

