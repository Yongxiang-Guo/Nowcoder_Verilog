// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 23, 2022
// Module Name:			decoder_38
// Description:			3-8 decoder
// Additional Comments:	VL18 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module decoder_38 (
	input	wire	E1_n,
	input	wire	E2_n,
	input	wire	E3,
	input	wire	A0,
	input	wire	A1,
	input	wire	A2,
	output	wire	Y0_n,
	output	wire	Y1_n,
	output	wire	Y2_n,
	output	wire	Y3_n,
	output	wire	Y4_n,
	output	wire	Y5_n,
	output	wire	Y6_n,
	output	wire	Y7_n
);

assign	Y0_n  =  ~((~E1_n) & (~E2_n) & E3 & (~A2) & (~A1) & (~A0));
assign	Y1_n  =  ~((~E1_n) & (~E2_n) & E3 & (~A2) & (~A1) & ( A0));
assign	Y2_n  =  ~((~E1_n) & (~E2_n) & E3 & (~A2) & ( A1) & (~A0));
assign	Y3_n  =  ~((~E1_n) & (~E2_n) & E3 & (~A2) & ( A1) & ( A0));
assign	Y4_n  =  ~((~E1_n) & (~E2_n) & E3 & ( A2) & (~A1) & (~A0));
assign	Y5_n  =  ~((~E1_n) & (~E2_n) & E3 & ( A2) & (~A1) & ( A0));
assign	Y6_n  =  ~((~E1_n) & (~E2_n) & E3 & ( A2) & ( A1) & (~A0));
assign	Y7_n  =  ~((~E1_n) & (~E2_n) & E3 & ( A2) & ( A1) & ( A0));

endmodule

