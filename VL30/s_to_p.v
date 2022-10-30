// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 30, 2022
// Module Name:			s_to_p
// Description:			serial to parallel conversion
// Additional Comments:	VL30 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module s_to_p (
	input	wire				rst_n,
	input	wire				clk,
	input	wire				valid_a,
	input	wire				data_a,
	output	wire				ready_a,
	output	wire				valid_b,
	output	wire	[5: 0]		data_b
);

reg					ready_a_reg;
reg					valid_b_reg;
reg		[5: 0]		data_b_reg;
reg		[2: 0]		cnt;
reg		[4: 0]		data_temp;

assign	ready_a  =  ready_a_reg;
assign	valid_b  =  valid_b_reg;
assign	data_b   =  data_b_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		ready_a_reg <= 1'b0;
		valid_b_reg <= 1'b0;
		data_b_reg <= 6'd0;
		cnt <= 3'd0;
		data_temp <= 5'd0;
	end
	else begin
		ready_a_reg <= 1'b1;
		if (valid_a == 1'b1) begin
			cnt <= cnt + 3'd1;
			if (cnt == 3'd5) begin
				cnt <= 3'd0;
				valid_b_reg <= 1'b1;
				data_b_reg <= {data_a, data_temp};
			end
			else begin
				valid_b_reg <= 1'b0;
				data_temp = {data_a, data_temp[4: 1]};
			end
		end
		else begin
			valid_b_reg <= 1'b0;
		end
	end
end

endmodule

