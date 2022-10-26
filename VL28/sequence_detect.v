// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 26, 2022
// Module Name:			sequence_detect
// Description:			sequence detect
// Additional Comments:	VL28 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module sequence_detect (
	input	wire				rst_n,
	input	wire				clk,
	input	wire				data,
	input	wire				data_valid,
	output	wire				match
);

reg					match_reg;
reg		[2: 0]		seq;

assign	match  =  match_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		match_reg <= 1'b0;
		seq <= 3'd0;
	end
	else begin
		if (data_valid == 1'b1) begin
			seq <= {seq[1: 0], data};
			if ({seq, data} == 4'b0110) begin
				match_reg <= 1'b1;
			end
			else begin
				match_reg <= 1'b0;
			end
		end
		else begin
			match_reg <= 1'b0;
		end
	end
end

endmodule

