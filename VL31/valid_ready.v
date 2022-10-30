// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 30, 2022
// Module Name:			valid_ready
// Description:			data accumulation
// Additional Comments:	VL31 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module valid_ready (
	input	wire				rst_n,
	input	wire				clk,
	input	wire	[7: 0]		data_in,
	input	wire				valid_a,
	input	wire				ready_b,
	output	wire				ready_a,
	output	wire				valid_b,
	output	wire	[9: 0]		data_out
);

reg					valid_b_reg;
reg		[9: 0]		data_out_reg;
reg		[1: 0]		cnt;

assign	ready_a   =  (~valid_b) | ready_b;
assign	valid_b   =  valid_b_reg;
assign	data_out  =  data_out_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		valid_b_reg <= 1'b0;
		data_out_reg <= 10'd0;
		cnt <= 2'd0;
	end
	else begin
		if (ready_a & valid_a) begin
			cnt <= cnt + 2'd1;
			if (cnt == 2'd0) begin
				data_out_reg <= data_in;
			end
			else begin
				data_out_reg <= data_out_reg + data_in;
			end
			if (cnt == 2'd3) begin
				cnt <= 2'd0;
				valid_b_reg <= 1'b1;
			end
			else begin
				valid_b_reg <= 1'b0;
			end
		end
	end
end

endmodule

