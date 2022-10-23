// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 23, 2022
// Module Name:			seq_circuit
// Description:			sequence logic
// Additional Comments:	VL21 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module seq_circuit (
	input	wire				rst_n,
	input	wire				clk,
	input	wire				A,
	output	wire				Y
);

reg		[1: 0]		Q_reg;

assign	Y  =  (Q_reg == 2'b11);

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		Q_reg <= 2'b00;
	end
	else begin
		if (A == 1'b0) begin
			Q_reg <= Q_reg + 2'd1;
		end
		else begin
			Q_reg <= Q_reg - 2'd1;
		end
	end
end

endmodule

