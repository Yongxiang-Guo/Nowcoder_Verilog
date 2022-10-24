// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 24, 2022
// Module Name:			seq_circuit
// Description:			sequence logic
// Additional Comments:	VL22 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module seq_circuit (
	input	wire				rst_n,
	input	wire				clk,
	input	wire				C,
	output	wire				Y
);

reg					Y_reg;
reg		[1: 0]		Q_reg;
reg		[1: 0]		cs;		// current state
reg		[1: 0]		ns;		// next state

assign	Y  =  Y_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		cs <= 2'd0;
	end
	else begin
		cs <= ns;
	end
end

always @(*) begin
	if (~rst_n) begin
		ns = 2'd0;
	end
	else begin
		case (cs)
			2'd0: begin
				if (C == 1'b1) begin
					ns = 2'd1;
				end
			end

			2'd1: begin
				if (C == 1'b0) begin
					ns = 2'd3;
				end
			end

			2'd2: begin
				if (C == 1'b0) begin
					ns = 2'd0;
				end
			end

			2'd3: begin
				if (C == 1'b1) begin
					ns = 2'd2;
				end
			end
		endcase
	end
end

always @(*) begin
	case (cs)
		2'd0: Y_reg = 1'b0;
		2'd1: Y_reg = 1'b0;
		2'd2: Y_reg = C;
		2'd3: Y_reg = 1'b1;
	endcase
end

endmodule

