// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 18, 2022
// Module Name:			key_encoder
// Description:			keyboard encoder
// Additional Comments:	VL14 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module key_encoder (
	input	wire	[9: 0]		S_n,
	output	wire	[3: 0]		L,
	output	wire				GS
);

reg		[3: 0]		L_reg;
reg					GS_reg;
wire	[8:0]		I_n;
wire	[3:0]		Y_n;

assign	L   =  L_reg;
assign	GS  =  GS_reg;

encoder_0 u_encoder_0 (
	.I_n    ( I_n ),
	.Y_n    ( Y_n )
);

endmodule


module encoder_0(
   input      [8:0]         I_n,
   output reg [3:0]         Y_n   
);

always @(*)begin
   casex(I_n)
      9'b111111111 : Y_n = 4'b1111;
      9'b0xxxxxxxx : Y_n = 4'b0110;
      9'b10xxxxxxx : Y_n = 4'b0111;
      9'b110xxxxxx : Y_n = 4'b1000;
      9'b1110xxxxx : Y_n = 4'b1001;
      9'b11110xxxx : Y_n = 4'b1010;
      9'b111110xxx : Y_n = 4'b1011;
      9'b1111110xx : Y_n = 4'b1100;
      9'b11111110x : Y_n = 4'b1101;
      9'b111111110 : Y_n = 4'b1110;
      default      : Y_n = 4'b1111;
   endcase    
end

endmodule

