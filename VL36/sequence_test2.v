// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Nov 06, 2022
// Module Name:			sequence_test2
// Description:			sequence_test2
// Additional Comments:	VL36 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module sequence_test2 (
	input	wire				rst,
	input	wire				clk,
	input	wire				data,
	output	wire				flag
);

reg					flag_reg;
reg		[3: 0]		data_temp;

assign	flag  =  flag_reg;

always @(posedge clk or negedge rst) begin
	if (~rst) begin
		flag_reg <= 1'b0;
		data_temp <= 4'd0;
	end
	else begin
		data_temp <= {data_temp[2: 0], data};
		if (data_temp == 4'b1011) begin
			flag_reg <= 1'b1;
		end
		else begin
			flag_reg <= 1'b0;
		end
	end
end

endmodule

