// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 17, 2022
// Module Name:			function_mod
// Description:			"function" statement
// Additional Comments:	VL10 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module function_mod (
	input	wire	[3: 0]		a,
	input	wire	[3: 0]		b,
	output	wire	[3: 0]		c,
	output	wire	[3: 0]		d
);

assign	c  =  data_inv(a);
assign	d  =  data_inv(b);

function [3: 0] data_inv;
	input [3: 0] data;
	integer i;
	begin
		for (i=0; i<4; i=i+1) begin
			data_inv[i] = data[3-i];
		end
	end
endfunction

endmodule

