// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Sep 28, 2022
// Module Name:			mux4_1
// Description:			4:1 MUX
// Additional Comments:	VL1 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module mux4_1 (
	input	wire	[1: 0]		d0,
	input	wire	[1: 0]		d1,
	input	wire	[1: 0]		d2,
	input	wire	[1: 0]		d3,
	input	wire	[1: 0]		sel,
	output	wire	[1: 0]		mux_out
);

assign	mux_out  =  sel[0] ? (sel[1] ? d0 : d2) : (sel[1] ? d1 : d3);

endmodule

