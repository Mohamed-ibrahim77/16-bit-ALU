module Decoder_UNIT (

	input  wire [3 : 0] ALU_FUN_DEC,
	
	output reg 		    Arith_Enable,
	output reg 		    Logic_Enable,
	output reg 		    CMP_Enable,
	output reg 		    Shift_Enable		
);
	
	always @(*) begin 
		
		Arith_Enable = 0; Logic_Enable = 0; CMP_Enable = 0; Shift_Enable = 0;
		
		case (ALU_FUN_DEC[3:2])

			2'b00 : begin
				Arith_Enable = 1;
			end

			2'b01: begin
				Logic_Enable = 1;
			end

			2'b10 : begin
				CMP_Enable = 1;
			end

			2'b11 : begin
				Shift_Enable = 1;
			end	
			
		endcase
	end

endmodule : Decoder_UNIT