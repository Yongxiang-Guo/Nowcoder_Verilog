// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 25, 2022
// Module Name:			tb_edge_detect
// Description:			testbench for edge detect
// Additional Comments:	VL24 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_edge_detect ();

logic				rst_n;
logic				clk;
logic				a;
logic				rise;
logic				down;

initial begin
	#200ns;
	$finish();
end

initial begin
	clk = 1'b0;
	forever begin
		#10ns;
		clk = ~clk;
	end
end

initial begin
	rst_n = 1'b0;
	a = 1'b1;
	#8ns;
	rst_n = 1'b1;
	#100ns;
	a = 1'b0;
	#50ns;
	a = 1'b1;
end

edge_detect u_edge_detect (
	.rst_n    ( rst_n ),
	.clk      ( clk   ),
	.a        ( a     ),
	.rise     ( rise  ),
	.down     ( down  )
);

endmodule

