// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 17, 2022
// Module Name:			tb_comparator_4
// Description:			testbench for 4bit data comparator
// Additional Comments:	VL11 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_comparator_4 ();

logic	[3: 0]		A;
logic	[3: 0]		B;
logic				Y0;
logic				Y1;
logic				Y2;

initial begin
	#200ns;
	$finish();
end

initial begin
	A = 4'd10;
	B = 4'd9;
	#50ns;
	A = 4'd8;
	B = 4'd12;
	#50ns;
	A = 4'd5;
	B = 4'd5;
	#50ns;
	A = 4'd12;
	B = 4'd11;
end

comparator_4 u_comparator_4 (
	.A     ( A  ),
	.B     ( B  ),
	.Y0    ( Y0 ),
	.Y1    ( Y1 ),
	.Y2    ( Y2 )
);

endmodule

