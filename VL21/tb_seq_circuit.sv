// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 23, 2022
// Module Name:			tb_seq_circuit
// Description:			testbench for sequence logic
// Additional Comments:	VL21 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_seq_circuit ();

logic				rst_n;
logic				clk;
logic				A;
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
	A = 1'b1;
	#5ns;
	rst_n = 1'b1;
	#70ns;
	A = 1'b0;
	#40ns;
	A = 1'b1;
end

seq_circuit u_seq_circuit (
	.rst_n    ( rst_n ),
	.clk      ( clk   ),
	.A        ( A     ),
	.Y        ( Y     )
);

endmodule

