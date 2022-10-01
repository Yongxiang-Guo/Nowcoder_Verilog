// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			multi_sel
// Description:			multiplier with select
// Additional Comments:	VL4 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module multi_sel (
	input	wire				clk,
	input	wire				rst,
	input	wire	[7: 0]		d,
	output	wire				input_grant,
	output	wire	[10: 0]		out
);

reg					input_grant_reg;
reg		[10: 0]		out_reg;

reg		[1: 0]		result_cnt;
reg		[10: 0]		d_reg;

assign	input_grant  =  input_grant_reg;
assign	out          =  out_reg;

always @(posedge clk or negedge rst) begin
	if (~rst) begin
		result_cnt	<= 2'd0;
	end
	else begin
		result_cnt <= result_cnt + 1'b1;
	end
end

always @(posedge clk or negedge rst) begin
	if (~rst) begin
		input_grant_reg	<= 1'b0;
		out_reg			<= 11'd0;
		d_reg			<= 11'd0;
	end
	else begin
		case (result_cnt)
			2'd0: begin
				input_grant_reg	<= 1'b1;		// ready to output result
				out_reg			<= {3'd0, d};	// first result: d * 1
				d_reg			<= {3'd0, d};	// store d value for next calculation
			end
			2'd1: begin
				input_grant_reg	<= 1'b0;
				out_reg			<= (d_reg << 1) + d_reg;	// second result: d * 3
			end
			2'd2: begin
				input_grant_reg	<= 1'b0;
				out_reg			<= (d_reg << 2) + (d_reg << 1) + d_reg;	// third result: d * 7
			end
			2'd3: begin
				input_grant_reg	<= 1'b0;
				out_reg			<= (d_reg << 3);	// fourth result: d * 8
			end
			default: begin
				input_grant_reg	<= 1'b0;
				out_reg			<= 11'd0;
				d_reg			<= 11'd0;
			end
		endcase
	end
end

endmodule

