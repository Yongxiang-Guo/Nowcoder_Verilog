// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 18, 2022
// Module Name:			encoder_83
// Description:			83 encoder
// Additional Comments:	VL15 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module encoder_83 (
	input	wire	[7: 0]		I,
	input	wire				EI,
	output	wire	[2: 0]		Y,
	output	wire				GS,
	output	wire				EO
);

reg 	[2: 0]	Y_reg;

assign	Y   =  Y_reg;
assign	GS  =  EI & (|I);
assign	EO  =  EI & (~(|I));

always @(*) begin
	if (EI == 1'b0) begin
		Y_reg = 3'b000;
	end
	else begin
		casex (I)
			8'b1xxxxxxx: Y_reg = 3'b111;
			8'b01xxxxxx: Y_reg = 3'b110;
			8'b001xxxxx: Y_reg = 3'b101;
			8'b0001xxxx: Y_reg = 3'b100;
			8'b00001xxx: Y_reg = 3'b011;
			8'b000001xx: Y_reg = 3'b010;
			8'b0000001x: Y_reg = 3'b001;
			8'b00000001: Y_reg = 3'b000;
			8'b00000000: Y_reg = 3'b000;
		endcase
	end
end

endmodule

