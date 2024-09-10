module LOGIC_UNIT # (

	parameter A_WIDTH = 16,
	parameter B_WIDTH = 16,
	parameter OUT_WIDTH = 16 )

(	input  wire [A_WIDTH-1 : 0]   A_logic,
	input  wire [B_WIDTH-1 : 0]   B_logic,
	input  wire 				  clk, rst,
	input  wire [3 : 0] 		  ALU_FUN,
	input  wire 				  Logic_Enable,	

	output reg  [OUT_WIDTH-1 : 0] Logic_OUT,
	output reg 					  Logic_Flag
);
	
	reg [OUT_WIDTH-1 : 0] Logic_OUT_reg; 
	always @(*) begin 

		Logic_Flag = 1;

		case (ALU_FUN[1:0])
		
			2'b00 : begin
				Logic_OUT_reg = A_logic & B_logic;
			end

			2'b01 : begin
				Logic_OUT_reg = A_logic | B_logic;
			end

			2'b10: begin
				Logic_OUT_reg = ~(A_logic & B_logic);
			end

			2'b11 : begin
				Logic_OUT_reg = ~(A_logic | B_logic);
			end

		endcase
	end

	always @(posedge clk or negedge rst) begin 
		
		if(!rst) begin
			Logic_OUT  <= 0;
			Logic_Flag <= 0;
		end 

		else if (!Logic_Enable) begin
			Logic_OUT  <= 0;
			Logic_Flag <= 0;
		end

		else begin
			Logic_OUT <= Logic_OUT_reg;
		end
	end

endmodule : LOGIC_UNIT