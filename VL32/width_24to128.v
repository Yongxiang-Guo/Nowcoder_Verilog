// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 30, 2022
// Module Name:			width_24to128
// Description:			data width transfer
// Additional Comments:	VL32 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module width_24to128 (
	input	wire				rst_n,
	input	wire				clk,
	input	wire	[23: 0]		data_in,
	input	wire				valid_in,
	output	wire				valid_out,
	output	wire	[127: 0]	data_out
);

reg					valid_out_reg;
reg		[127: 0]	data_out_reg;
reg		[143: 0]	data_temp;
reg		[3: 0]		cnt;

assign	valid_out  =  valid_out_reg;
assign	data_out   =  data_out_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		valid_out_reg <= 1'b0;
		data_out_reg <= 128'd0;
		data_temp <= 144'd0;
		cnt <= 4'd0;
	end
	else begin
		if (valid_in) begin
			cnt <= cnt + 4'd1;
			data_temp <= {data_temp[119: 0], data_in};
			if (cnt == 4'd5) begin
				valid_out_reg <= 1'b1;
				data_out_reg <= {data_temp[119: 0], data_in[23: 16]};
			end
			else if (cnt == 4'd10) begin
				valid_out_reg <= 1'b1;
				data_out_reg <= {data_temp[111: 0], data_in[23: 8]};
			end
			else if (cnt == 4'd15) begin
				cnt <= 4'd0;
				valid_out_reg <= 1'b1;
				data_out_reg <= {data_temp[103: 0], data_in};
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

