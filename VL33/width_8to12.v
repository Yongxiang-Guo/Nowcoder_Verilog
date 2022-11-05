// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Nov 05, 2022
// Module Name:			width_8to12
// Description:			data width transfer
// Additional Comments:	VL33 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module width_8to12 (
	input	wire				rst_n,
	input	wire				clk,
	input	wire	[7: 0]		data_in,
	input	wire				valid_in,
	output	wire				valid_out,
	output	wire	[11: 0]		data_out
);

reg					valid_out_reg;
reg		[11: 0]		data_out_reg;
reg		[7: 0]		data_temp;
reg		[1: 0]		cnt;

assign	valid_out  =  valid_out_reg;
assign	data_out   =  data_out_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		valid_out_reg <= 1'b0;
		data_out_reg <= 12'd0;
		data_temp <= 8'd0;
		cnt <= 2'd0;
	end
	else begin
		if (valid_in) begin
			cnt <= cnt + 2'd1;
			data_temp <= data_in;
			if (cnt == 2'd1) begin
				valid_out_reg <= 1'b1;
				data_out_reg <= {data_temp, data_in[7: 4]};
			end
			else if (cnt == 2'd2) begin
				cnt <= 2'd0;
				valid_out_reg <= 1'b1;
				data_out_reg <= {data_temp[3: 0], data_in};
			end
			else begin
				valid_out_reg <= 1'b0;
			end
		end
		else begin
			valid_out_reg <= 1'b0;
		end
	end
end

endmodule

