// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 25, 2022
// Module Name:			sequence_detect
// Description:			sequence detect
// Additional Comments:	VL25 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module sequence_detect (
	input	wire				rst_n,
	input	wire				clk,
	input	wire				a,
	output	wire				match
);

reg					match_reg;
reg		[7: 0]		seq;

assign	match  =  match_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		match_reg <= 1'b0;
		seq <= 8'd0;
	end
	else begin
		seq <= {seq[6: 0], a};
		if (seq == 8'b01110001) begin
			match_reg <= 1'b1;
		end
		else begin
			match_reg <= 1'b0;
		end
	end
end

endmodule

