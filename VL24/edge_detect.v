// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 25, 2022
// Module Name:			edge_detect
// Description:			edge detect
// Additional Comments:	VL24 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module edge_detect (
	input	wire				rst_n,
	input	wire				clk,
	input	wire				a,
	output	wire				rise,
	output	wire				down
);

reg					rise_reg;
reg					down_reg;
reg					a_sync;

assign	rise  =  rise_reg;
assign	down  =  down_reg;

always @(posedge clk) begin
	a_sync <= a;
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		rise_reg <= 1'b0;
		down_reg <= 1'b0;
	end
	else begin
		if (a_sync != a) begin
			if (a_sync == 1'b0) begin
				rise_reg <= 1'b1;
			end
			else begin
				down_reg <= 1'b1;
			end
		end
		else begin
			rise_reg <= 1'b0;
			down_reg <= 1'b0;
		end
	end
end

endmodule

