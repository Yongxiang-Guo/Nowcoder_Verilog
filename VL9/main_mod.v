// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			main_mod
// Description:			input data compare
// Additional Comments:	VL9 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module main_mod (
	input	wire				clk,
	input	wire				rst_n,
	input	wire	[7: 0]		a,
	input	wire	[7: 0]		b,
	input	wire	[7: 0]		c,
	output	wire	[7: 0]		d
);

wire	[7: 0]		min_a_b;
reg		[7: 0]		c_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		c_reg <= 8'd0;
	end
	else begin
		c_reg <= c;
	end
end

data_compare u_data_compare_0 (
	.clk      ( clk     ),
	.rst_n    ( rst_n   ),
	.a        ( a       ),
	.b        ( b       ),
	.c        ( min_a_b )
);

data_compare u_data_compare_1 (
	.clk      ( clk     ),
	.rst_n    ( rst_n   ),
	.a        ( min_a_b ),
	.b        ( c_reg   ),
	.c        ( d       )
);

endmodule


module data_compare (
	input	wire				clk,
	input	wire				rst_n,
	input	wire	[7: 0]		a,
	input	wire	[7: 0]		b,
	output	wire	[7: 0]		c
);

reg		[8: 0]		c_reg;

assign	c  =  c_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		c_reg <= 8'd0;
	end
	else begin
		if (a > b) begin
			c_reg <= b;
		end
		else begin
			c_reg <= a;
		end
	end
end

endmodule

