// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			tb_gen_for_module
// Description:			testbench for test for generate-for function
// Additional Comments:	VL8 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_gen_for_module ();

logic	[7: 0]		data_in;
logic	[7: 0]		data_out;

initial begin
	#200ns;
	$finish();
end

initial begin
	data_in = 8'd100;
	#100ns;
	data_in = 8'd200;
end

gen_for_module u_gen_for_module (
	.data_in     ( data_in  ),
	.data_out    ( data_out )
);

endmodule

