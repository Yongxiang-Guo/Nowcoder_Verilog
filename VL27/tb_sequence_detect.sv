// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 25, 2022
// Module Name:			tb_sequence_detect
// Description:			testbench for sequence detect
// Additional Comments:	VL27 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_sequence_detect ();

logic				rst_n;
logic				clk;
logic				data;
logic				match;
logic				not_match;

initial begin
	#600ns;
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
	data = 1'b0;
	#8ns;
	rst_n = 1'b1;
	#10ns;
	data = 1'b1;
	#20ns;
	data = 1'b1;
	#20ns;
	data = 1'b1;
	#20ns;
	data = 1'b0;
	#20ns;
	data = 1'b0;

	#20ns;
	data = 1'b1;
	#20ns;
	data = 1'b1;
	#20ns;
	data = 1'b1;
	#20ns;
	data = 1'b0;
	#20ns;
	data = 1'b0;
end

sequence_detect u_sequence_detect (
	.rst_n        ( rst_n     ),
	.clk          ( clk       ),
	.data         ( data      ),
	.match        ( match     ),
	.not_match    ( not_match )
);

endmodule

