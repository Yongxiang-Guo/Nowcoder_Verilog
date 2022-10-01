// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			odd_sel
// Description:			odd-even check
// Additional Comments:	VL3 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module odd_sel (
	input	wire	[31: 0]		bus,
	input	wire				sel,
	output	wire				check
);

wire				odd_check;

assign	odd_check	=	^ bus;
assign	check		=	sel ? odd_check : ~odd_check;

endmodule

