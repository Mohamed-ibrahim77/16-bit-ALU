module ARITHMETIC_UNIT # (

	parameter A_WIDTH = 16,
	parameter B_WIDTH = 16,
	parameter OUT_WIDTH = 16 )

(	input  wire signed [A_WIDTH-1 : 0]   A_ARITHMETIC,
	input  wire signed [B_WIDTH-1 : 0]   B_ARITHMETIC,
	input  wire 				  		 clk, rst,
	input  wire 	   [3 : 0] 		     ALU_FUN,
	input  wire 				  		 ARITHMETIC_Enable,	

	output reg 				  		 	 ALU_Carry,
	output reg         [OUT_WIDTH-1 : 0] ARITHMETIC_OUT,
	output reg 					         ARITHMETIC_Flag
);
	
	reg [OUT_WIDTH-1 : 0] ARITHMETIC_OUT_reg; 
	always @(*) begin 

		ARITHMETIC_Flag = 1;

		case (ALU_FUN[1:0])

			2'b00 : begin
				ARITHMETIC_OUT_reg = A_ARITHMETIC + B_ARITHMETIC;
				ALU_Carry = ARITHMETIC_OUT_reg[A_WIDTH];
			end

			2'b01: begin				
				ARITHMETIC_OUT_reg = A_ARITHMETIC - B_ARITHMETIC;
				ALU_Carry = ARITHMETIC_OUT_reg[A_WIDTH];
			end

			2'b10 : begin
				ARITHMETIC_OUT_reg = A_ARITHMETIC * B_ARITHMETIC;
			end

			2'b11 : begin
				ARITHMETIC_OUT_reg = A_ARITHMETIC / B_ARITHMETIC;
			end	
			
		endcase
	end

	always @(posedge clk or negedge rst) begin 
		
		if(!rst) begin
			ARITHMETIC_OUT  <= 0;
			ARITHMETIC_Flag <= 0;
		end 

		else if (!ARITHMETIC_Enable) begin
			ARITHMETIC_OUT  <= 0;
			ARITHMETIC_Flag <= 0;
		end

		else begin
			ARITHMETIC_OUT <= ARITHMETIC_OUT_reg;
		end
	end

endmodule : ARITHMETIC_UNIT