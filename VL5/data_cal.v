// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			data_cal
// Description:			see Verilog VL5 practice on nowcoder.com
// Additional Comments:	VL5 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module data_cal (
	input	wire				clk,
	input	wire				rst,
	input	wire	[15: 0]		d,
	input	wire	[1: 0]		sel,
	output	wire	[4: 0]		out,
	output	wire				validout
);

reg		[15: 0]		d_reg;

assign	validout  =	(sel == 2'd0) ? 1'b0 : 1'b1;
assign	out       =	(sel == 2'd0) ? 5'd0 :
					(sel == 2'd1) ? (d_reg[3: 0] + d_reg[7: 4]) :
					(sel == 2'd2) ? (d_reg[3: 0] + d_reg[11: 8]) : (d_reg[3: 0] + d_reg[15: 12]);

always @(posedge clk or negedge rst) begin
	if (~rst) begin
		d_reg <= 16'd0;
	end
	else begin
		if (sel == 2'd0) begin
			d_reg <= d;
		end
	end
end

endmodule

