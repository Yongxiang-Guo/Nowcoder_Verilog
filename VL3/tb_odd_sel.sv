// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 01, 2022
// Module Name:			tb_odd_sel
// Description:			testbench for odd-even check
// Additional Comments:	VL3 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module tb_odd_sel ();

logic	[31: 0]		bus;
logic				sel;
logic				check;

initial begin
	#200ns;
	$finish();
end

initial begin
	bus		=	32'd0;
	forever begin
		#20ns;
		bus	=	bus + 1'b1;
	end
end

initial begin
	sel		=	1'b0;
	#20ns;
	sel		=	1'b1;
	#60ns;
	sel		=	1'b0;
	#60ns;
	sel		=	1'b1;
end

odd_sel u_odd_sel (
	.bus      ( bus   ),
	.sel      ( sel   ),
	.check    ( check )
);

endmodule

