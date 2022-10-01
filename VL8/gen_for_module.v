// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			gen_for_module
// Description:			test for generate-for function
// Additional Comments:	VL8 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module gen_for_module (
	input	wire	[7: 0]		data_in,
	output	wire	[7: 0]		data_out
);

genvar i;
generate
	for (i = 0; i < 8; i = i + 1) begin
		assign data_out[i] = data_in[7 - i];
	end
endgenerate

endmodule

