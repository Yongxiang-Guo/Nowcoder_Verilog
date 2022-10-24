// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 24, 2022
// Module Name:			rom
// Description:			simple rom
// Additional Comments:	VL23 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module rom (
	input	wire				rst_n,
	input	wire				clk,
	input	wire	[7: 0]		addr,
	output	wire	[3: 0]		data
);

reg		[3: 0]		rom_data	[7: 0];

assign	data  =  rom_data[addr];

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		rom_data[0] <= 4'd0;
		rom_data[1] <= 4'd2;
		rom_data[2] <= 4'd4;
		rom_data[3] <= 4'd6;
		rom_data[4] <= 4'd8;
		rom_data[5] <= 4'd10;
		rom_data[6] <= 4'd12;
		rom_data[7] <= 4'd14;
	end
end

endmodule

