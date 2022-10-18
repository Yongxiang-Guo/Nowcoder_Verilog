// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 18, 2022
// Module Name:			lca_4
// Description:			see Verilog VL12 practice on nowcoder.com
// Additional Comments:	VL12 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module lca_4 (
	input	wire	[3: 0]		A_in,
	input	wire	[3: 0]		B_in,
	input	wire				C_1,
	output	wire				CO,
	output	wire	[3: 0]		S
);

wire	[3: 0]		G_temp;
wire	[3: 0]		P_temp;
wire	[3: 0]		C_temp;

assign G_temp = A_in & B_in;
assign P_temp = A_in ^ B_in;
assign C_temp[0] = G_temp[0] | (P_temp[0] & C_1);
assign C_temp[3: 1] = G_temp[3: 1] | (P_temp[3: 1] & C_temp[2: 0]);

assign CO = C_temp[3];
assign S[0] = P_temp[0] ^ C_1;
assign S[3: 1] = P_temp[3: 1] ^ C_temp[2: 0];

endmodule

