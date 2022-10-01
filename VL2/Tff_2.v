// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			Tff_2
// Description:			two TFF with async reset
// Additional Comments:	VL2 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module Tff_2 (
	input	wire				rst,
	input	wire				clk,
	input	wire				data,
	output	wire				q
);

reg					q_reg;

reg					data_sync;

assign	q  =  q_reg;

always @(posedge clk or negedge rst) begin
	if (~rst) begin
		data_sync	<= 1'b0;
		q_reg		<= 1'b0;
	end
	else begin
		if (data == 1'b1) begin
			data_sync	<= ~data_sync;
		end
		if (data_sync == 1'b1) begin
			q_reg		<= ~q_reg;
		end
	end
end

endmodule

