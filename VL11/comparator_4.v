// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 17, 2022
// Module Name:			comparator_4
// Description:			4bit data comparator
// Additional Comments:	VL11 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module comparator_4 (
	input	wire	[3: 0]		A,
	input	wire	[3: 0]		B,
	output	wire				Y0,	// A < B
	output	wire				Y1,	// A = B
	output	wire				Y2	// A > B
);

assign	Y0  =  (A < B);
assign	Y1  =  (A == B);
assign	Y2  =  (A > B);

endmodule

