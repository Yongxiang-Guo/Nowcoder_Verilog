// ======================================================================
// Affiliation:			Tsinghua Univ
// Author:				Yongxiang Guo
// Create Date:			Oct 30, 2022
// Module Name:			signal_generator
// Description:			signal generator
// Additional Comments:	VL29 on nowcoder
// ======================================================================

`timescale 1ns/1ns

module signal_generator (
	input	wire				rst_n,
	input	wire				clk,
	input	wire	[1: 0]		wave_choise,
	output	wire	[4: 0]		wave
);

reg		[4: 0]		wave_reg;
reg		[4: 0]		cnt;
reg					incr_decr_flag;

assign	wave  =  wave_reg;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		wave_reg <= 5'd0;
		cnt <= 5'd0;
		incr_decr_flag <= 1'b0;	// decrease
	end
	else begin
		case (wave_choise)
			2'd0: begin		// square
				cnt <= cnt + 5'd1;
				if (cnt == 5'd9) begin
					wave_reg <= 5'd20;
				end
				else if (cnt == 5'd19) begin
					wave_reg <= 5'd0;
					cnt <= 5'd0;
				end
				incr_decr_flag <= 1'b0;
			end
			2'd1: begin		// sawtooth
				wave_reg <= wave_reg + 5'd1;
				if (wave_reg == 5'd20) begin
					wave_reg <= 5'd0;
				end
				incr_decr_flag <= 1'b0;
			end
			2'd2: begin		// triangular
				if (incr_decr_flag == 1'b0) begin
					wave_reg <= wave_reg - 5'd1;
					if (wave_reg == 5'd0) begin
						wave_reg <= 5'd1;
						incr_decr_flag <= 1'b1;
					end
				end
				else begin
					wave_reg <= wave_reg + 5'd1;
					if (wave_reg == 5'd20) begin
						wave_reg <= 5'd19;
						incr_decr_flag <= 1'b0;
					end
				end
			end
			default: begin
				wave_reg <= 5'd0;
				cnt <= 5'd0;
				incr_decr_flag <= 1'b0;
			end
		endcase
	end
end

endmodule

