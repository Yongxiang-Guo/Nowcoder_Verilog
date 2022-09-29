// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Sep 28, 2022
// Module Name:			tb_mux4_1
// Description:			testbench for 4:1 MUX
// Additional Comments:	VL1 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_mux4_1 ();

logic	[1: 0]		d0;
logic	[1: 0]		d1;
logic	[1: 0]		d2;
logic	[1: 0]		d3;
logic	[1: 0]		sel;
logic	[1: 0]		mux_out;

initial begin
	d0		=	2'd0;
	d1		=	2'd1;
	d2		=	2'd2;
	d3		=	2'd3;

	sel		=	2'b00;
	#100;
	sel		=	2'b01;
	#100;
	sel		=	2'b10;
	#100;
	sel		=	2'b11;
	#100;
end

mux4_1 u_mux4_1 (
	.d0			(d0),
	.d1			(d1),
	.d2			(d2),
	.d3			(d3),
	.sel		(sel),
	.mux_out	(mux_out)
);

endmodule

