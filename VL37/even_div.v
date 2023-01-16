// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Nov 06, 2022
// Module Name:			even_div
// Description:			even_div
// Additional Comments:	VL37 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module even_div (
	input	wire				rst,
	input	wire				clk_in,
	output	wire				clk_out2,
	output	wire				clk_out4,
	output	wire				clk_out8
);

reg					clk_out2_reg;
reg					clk_out4_reg;
reg					clk_out8_reg;

assign	clk_out2  =  clk_out2_reg;
assign	clk_out4  =  clk_out4_reg;
assign	clk_out8  =  clk_out8_reg;

always @(posedge clk_in or negedge rst) begin
	if (~rst) begin
		clk_out2_reg <= 1'b0;
	end
	else begin
		clk_out2_reg <= ~clk_out2_reg;
	end
end

always @(posedge clk_out2 or negedge rst) begin
	if (~rst) begin
		clk_out4_reg <= 1'b0;
	end
	else begin
		clk_out4_reg <= ~clk_out4_reg;
	end
end

always @(posedge clk_out4 or negedge rst) begin
	if (~rst) begin
		clk_out8_reg <= 1'b0;
	end
	else begin
		clk_out8_reg <= ~clk_out8_reg;
	end
end

endmodule

