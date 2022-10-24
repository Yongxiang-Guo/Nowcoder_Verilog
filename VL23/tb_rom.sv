// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 24, 2022
// Module Name:			tb_rom
// Description:			testbench for simple rom
// Additional Comments:	VL23 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_rom ();

logic				rst_n;
logic				clk;
logic	[7: 0]		addr;
logic	[3: 0]		data;

initial begin
	#200ns;
	$finish();
end

initial begin
	clk = 1'b0;
	forever begin
		#10ns;
		clk = ~clk;
	end
end

initial begin
	rst_n = 1'b0;
	addr = 8'd0;
	#8ns;
	rst_n = 1'b1;
	#40ns;
	addr = 8'd1;
	#40ns;
	addr = 8'd2;
	#40ns;
	addr = 8'd3;
end

rom u_rom (
	.rst_n    ( rst_n ),
	.clk      ( clk   ),
	.addr     ( addr  ),
	.data     ( data  )
);

endmodule

