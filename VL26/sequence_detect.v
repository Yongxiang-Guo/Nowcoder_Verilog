// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 25, 2022
// Module Name:			sequence_detect
// Description:			sequence detect
// Additional Comments:	VL26 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module sequence_detect (
	input	wire				rst_n,
	input	wire				clk,
	input	wire				a,
	output	wire				match
);

reg					match_reg;
reg		[8: 0]		seq;

assign	match  =  match_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		match_reg <= 1'b0;
		seq <= 9'd0;
	end
	else begin
		seq <= {seq[7: 0], a};
		
		if ((seq[8: 6] == 3'b011) && (seq[2: 0] == 3'b110)) begin
			match_reg <= 1'b1;
		end
		else begin
			match_reg <= 1'b0;
		end
	end
end

endmodule

