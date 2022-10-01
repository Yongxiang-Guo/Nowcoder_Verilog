// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			data_minus
// Description:			Calculate the difference between two numbers
// Additional Comments:	VL7 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module data_minus (
	input	wire				clk,
	input	wire				rst_n,
	input	wire	[7: 0]		a,
	input	wire	[7: 0]		b,
	output	wire	[8: 0]		c
);

reg		[8: 0]		c_reg;

assign	c  =  c_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		c_reg <= 9'd0;
	end
	else begin
		if (a > b) begin
			c_reg <= a - b;
		end
		else begin
			c_reg <= b - a;
		end
	end
end

endmodule

