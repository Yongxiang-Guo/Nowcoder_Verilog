// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 23, 2022
// Module Name:			tb_decoder_38
// Description:			testbench for 3-8 decoder
// Additional Comments:	VL18 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_decoder_38 ();

logic				E1_n;
logic				E2_n;
logic				E3;
logic				A0;
logic				A1;
logic				A2;
logic				Y0_n;
logic				Y1_n;
logic				Y2_n;
logic				Y3_n;
logic				Y4_n;
logic				Y5_n;
logic				Y6_n;
logic				Y7_n;

initial begin
	#200ns;
	$finish();
end

initial begin
	E1_n = 1'b0;
	E2_n = 1'b0;
	E3 = 1'b1;
	{A2, A1, A0} = 3'b100;
	#50ns
	E1_n = 1'b0;
	E2_n = 1'b0;
	E3 = 1'b1;
	{A2, A1, A0} = 3'b110;
	#50ns
	E1_n = 1'b0;
	E2_n = 1'b0;
	E3 = 1'b1;
	{A2, A1, A0} = 3'b000;
	#50ns
	E1_n = 1'b0;
	E2_n = 1'b1;
	E3 = 1'b1;
	{A2, A1, A0} = 3'b100;

end

decoder_38 u_decoder_38 (
	.E1_n    ( E1_n ),
	.E2_n    ( E2_n ),
	.E3      ( E3   ),
	.A0      ( A0   ),
	.A1      ( A1   ),
	.A2      ( A2   ),
	.Y0_n    ( Y0_n ),
	.Y1_n    ( Y1_n ),
	.Y2_n    ( Y2_n ),
	.Y3_n    ( Y3_n ),
	.Y4_n    ( Y4_n ),
	.Y5_n    ( Y5_n ),
	.Y6_n    ( Y6_n ),
	.Y7_n    ( Y7_n )
);

endmodule

