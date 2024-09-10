module CMP_UNIT # (

	parameter A_WIDTH = 16,
	parameter B_WIDTH = 16,
	parameter OUT_WIDTH = 16 )

(	input  wire [A_WIDTH-1 : 0]   A_CMP,
	input  wire [B_WIDTH-1 : 0]   B_CMP,
	input  wire 				  clk, rst,
	input  wire [3 : 0] 		  ALU_FUN,
	input  wire 				  CMP_Enable,	

	output reg  [OUT_WIDTH-1 : 0] CMP_OUT,
	output reg 					  CMP_Flag
);
	
	reg [OUT_WIDTH-1 : 0] CMP_OUT_reg; 
	always @(*) begin 

		CMP_Flag = 1;

		case (ALU_FUN[1:0])

			2'b01 : begin
				if(A_CMP == B_CMP)
					CMP_OUT_reg = 1;
				else
					CMP_OUT_reg = 0;
			end

			2'b10: begin
				if(A_CMP > B_CMP)
					CMP_OUT_reg = 2;
				else
					CMP_OUT_reg = 0;
			end

			2'b11 : begin
				if(A_CMP < B_CMP)
					CMP_OUT_reg = 3;
				else
					CMP_OUT_reg = 0;
			end

			default : begin
				CMP_OUT_reg = 0;
			end	
			
		endcase
	end

	always @(posedge clk or negedge rst) begin 
		
		if(!rst) begin
			CMP_OUT  <= 0;
			CMP_Flag <= 0;
		end 

		else if (!CMP_Enable) begin
			CMP_OUT  <= 0;
			CMP_Flag <= 0;
		end

		else begin
			CMP_OUT <= CMP_OUT_reg;
		end
	end

endmodule : CMP_UNIT