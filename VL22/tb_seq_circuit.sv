// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 24, 2022
// Module Name:			tb_seq_circuit
// Description:			testbench for sequence logic
// Additional Comments:	VL22 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_seq_circuit ();

logic				rst_n;
logic				clk;
logic				C;
logic				Y;

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
	C = 1'b1;
	#8ns;
	rst_n = 1'b1;
	#40ns;
	C = 1'b0;
	#40ns;
	C = 1'b1;
	#40ns;
	C = 1'b0;
end

seq_circuit u_seq_circuit (
	.rst_n    ( rst_n ),
	.clk      ( clk   ),
	.C        ( C     ),
	.Y        ( Y     )
);

endmodule

