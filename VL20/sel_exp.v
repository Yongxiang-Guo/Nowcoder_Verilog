// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 23, 2022
// Module Name:			sel_exp
// Description:			logic using data_sel
// Additional Comments:	VL20 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module sel_exp (
	input	wire				A,
	input	wire				B,
	input	wire				C,
	output	wire				L
);

data_sel u_data_sel (
	.S0		( B    ),
	.S1		( A    ),
	.D0		( 1'b0 ),
	.D1		( C    ),
	.D2		( ~C   ),
	.D3		( 1'b1 ),
	.Y		( L    )
);

endmodule


module data_sel(
   input             S0     ,
   input             S1     ,
   input             D0     ,
   input             D1     ,
   input             D2     ,
   input             D3     ,
   
   output wire        Y    
);

assign Y = ~S1 & (~S0&D0 | S0&D1) | S1&(~S0&D2 | S0&D3);
     
endmodule

