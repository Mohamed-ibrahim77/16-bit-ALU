module SHIFT_UNIT # (

	parameter A_WIDTH = 16,
	parameter B_WIDTH = 16,
	parameter OUT_WIDTH = 16 )

(	input  wire [A_WIDTH-1 : 0]   A_SHIFT,
	input  wire [B_WIDTH-1 : 0]   B_SHIFT,
	input  wire 				  clk, rst,
	input  wire [3 : 0] 		  ALU_FUN,
	input  wire 				  SHIFT_Enable,	

	output reg  [OUT_WIDTH-1 : 0] SHIFT_OUT,
	output reg 					  SHIFT_Flag
);
	
	reg [OUT_WIDTH-1 : 0] SHIFT_OUT_reg; 
	always @(*) begin 

		SHIFT_Flag = 1;

		case (ALU_FUN[1:0])
		
			2'b00 : begin
				SHIFT_OUT_reg = A_SHIFT >> 1;
			end

			2'b01 : begin
				SHIFT_OUT_reg = A_SHIFT << 1;
			end

			2'b10: begin
				SHIFT_OUT_reg = B_SHIFT >> 1;
			end

			2'b11 : begin
				SHIFT_OUT_reg = B_SHIFT << 1;
			end

		endcase
	end

	always @(posedge clk or negedge rst) begin 
		
		if(!rst) begin
			SHIFT_OUT  <= 0;
			SHIFT_Flag <= 0;
		end 

		else if (!SHIFT_Enable) begin
			SHIFT_OUT  <= 0;
			SHIFT_Flag <= 0;
		end
		
		else begin
			SHIFT_OUT <= SHIFT_OUT_reg;
		end
	end

endmodule : SHIFT_UNIT