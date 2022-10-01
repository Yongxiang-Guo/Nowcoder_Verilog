// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			data_select
// Description:			multi-function data calculate
// Additional Comments:	VL6 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module data_select (
	input	wire					clk,
	input	wire					rst_n,
	input	wire	signed	[7: 0]	a,
	input	wire	signed	[7: 0]	b,
	input	wire			[1: 0]	select,
	output	wire	signed	[8: 0]	c
);

reg	signed	[8: 0]		c_reg;

assign	c  =  c_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		c_reg <= 9'd0;
	end
	else begin
		case (select)
			2'd0: c_reg <= a;
			2'd1: c_reg <= b;
			2'd2: c_reg <= a + b;
			2'd3: c_reg <= a - b;
			default: c_reg <= 9'd0;
		endcase
	end
end

endmodule

