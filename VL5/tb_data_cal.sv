// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			tb_data_cal
// Description:			testbench for see Verilog VL5 practice on nowcoder.com
// Additional Comments:	VL5 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_data_cal ();

logic				clk;
logic				rst;
logic	[15: 0]		d;
logic	[1: 0]		sel;
logic	[4: 0]		out;
logic				validout;

initial begin
	#200ns;
	$finish();
end

initial begin
	rst = 1'b0;
	#11ns;
	rst = 1'b1;
end

initial begin
	clk = 1'b1;
	forever begin
		#5ns;
		clk = ~clk;
	end
end

initial begin
	d = 16'd0;
	#21ns;
	d = 16'h8421;
	#40ns;
	d = 16'h8423;
	#50ns;
	d = 16'h8427;
end

initial begin
	sel = 2'd0;
	#31ns;
	sel = 2'd2;
	#30ns;
	sel = 2'd1;
	#30ns;
	sel = 2'd0;
	#10ns;
	sel = 2'd3;
end

data_cal u_data_cal (
	.clk         ( clk      ),
	.rst         ( rst      ),
	.d           ( d        ),
	.sel         ( sel      ),
	.out         ( out      ),
	.validout    ( validout )
);

endmodule

