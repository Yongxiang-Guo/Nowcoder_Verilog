// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 25, 2022
// Module Name:			sequence_detect
// Description:			sequence detect
// Additional Comments:	VL27 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module sequence_detect (
	input	wire				rst_n,
	input	wire				clk,
	input	wire				data,
	output	wire				match,
	output	wire				not_match
);

reg					match_reg;
reg					not_match_reg;
reg		[5: 0]		seq;
reg		[2: 0]		cnt;

assign	match      =  match_reg;
assign	not_match  =  not_match_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		match_reg <= 1'b0;
		not_match_reg <= 1'b0;
		seq <= 6'd0;
		cnt <= 3'd0;
	end
	else begin
		cnt <= cnt + 3'd1;
		seq <= {seq[4: 0], data};
		if (cnt == 3'd5) begin
			cnt <= 3'd0;
			if ({seq[4: 0], data} == 6'b011100) begin
				match_reg <= 1'b1;
			end
			else begin
				not_match_reg <= 1'b1;
			end
		end
		else begin
			match_reg <= 1'b0;
			not_match_reg <= 1'b0;
		end
	end
end

endmodule

