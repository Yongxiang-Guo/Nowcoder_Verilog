// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Nov 05, 2022
// Module Name:			sequence_test1
// Description:			sequence_test1
// Additional Comments:	VL35 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module sequence_test1 (
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
		data_temp <= 4'b0000;
	end
	else begin
		if ({data_temp, data} == 5'b10111) begin
			data_temp <= 4'b0000;
			flag_reg <= 1'b1;
		end
		else begin
			data_temp <= {data_temp[2: 0], data};
			flag_reg <= 1'b0;
		end
	end
end

endmodule

