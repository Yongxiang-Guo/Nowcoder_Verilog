// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 18, 2022
// Module Name:			encoder_0
// Description:			priority encoder
// Additional Comments:	VL13 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module encoder_0 (
	input	wire	[8: 0]		I_n,
	output	reg		[3: 0]		Y_n
);

always @(*) begin
	if (I_n[8]==1'b0) Y_n = 4'b0110;
	else if (I_n[7]==1'b0) Y_n = 4'b0111;
	else if (I_n[6]==1'b0) Y_n = 4'b1000;
	else if (I_n[5]==1'b0) Y_n = 4'b1001;
	else if (I_n[4]==1'b0) Y_n = 4'b1010;
	else if (I_n[3]==1'b0) Y_n = 4'b1011;
	else if (I_n[2]==1'b0) Y_n = 4'b1100;
	else if (I_n[1]==1'b0) Y_n = 4'b1101;
	else if (I_n[0]==1'b0) Y_n = 4'b1110;
	else Y_n = 4'b1111;
end

endmodule

