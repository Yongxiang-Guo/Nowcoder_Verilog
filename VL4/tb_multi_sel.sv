// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			tb_multi_sel
// Description:			testbench for multiplier with select
// Additional Comments:	VL4 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_multi_sel ();

logic				clk;
logic				rst;
logic	[7: 0]		d;
logic				input_grant;
logic	[10: 0]		out;

initial begin
	#200ns;
	$finish();
end

initial begin
	rst = 1'b0;
	#16ns;
	rst = 1'b1;
end

initial begin
	clk = 1'b0;
	forever begin
		#5ns;
		clk = ~clk;
	end
end

initial begin
	d = 8'd143;
	#46ns;
	d = 8'd7;
	#50ns;
	d = 8'd6;
	#10ns;
	d = 8'd128;
	#10ns;
	d = 8'd129;
end

multi_sel u_multi_sel (
	.clk            ( clk         ),
	.rst            ( rst         ),
	.d              ( d           ),
	.input_grant    ( input_grant ),
	.out            ( out         )
);

endmodule

