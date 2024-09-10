module ALU_TOP # (

	parameter A_WIDTH_TOP = 16,
	parameter B_WIDTH_TOP = 16,
	parameter OUT_WIDTH_TOP = A_WIDTH_TOP + B_WIDTH_TOP)


(	input  wire signed [A_WIDTH_TOP-1 : 0]   A,
	input  wire signed [B_WIDTH_TOP-1 : 0]   B,
	input  wire 				  		 	 clk, rst,
	input  wire 	   [3 : 0] 		     	 ALU_FUN,

	output wire        [OUT_WIDTH_TOP-1 : 0] ARITHMETIC_OUT,
	output wire        [OUT_WIDTH_TOP-1 : 0] Logic_OUT,
	output wire        [OUT_WIDTH_TOP-1 : 0] CMP_OUT,
	output wire        [OUT_WIDTH_TOP-1 : 0] SHIFT_OUT,
	
	output wire 					         Carry_OUT,
	output wire 					         ARITHMETIC_Flag,
	output wire 					         Logic_Flag,
	output wire 					         CMP_Flag,
	output wire 					         SHIFT_Flag
);

// internal connections 
wire int_Arith_Enable, int_Logic_Enable, int_CMP_Enable, int_Shift_Enable ;


// Decoder
Decoder_UNIT DEC_U (
	.ALU_FUN_DEC(ALU_FUN),
	.Arith_Enable(int_Arith_Enable),
	.Logic_Enable(int_Logic_Enable),
	.CMP_Enable(int_CMP_Enable),
	.Shift_Enable(int_Shift_Enable)
);

//ARITHMETIC_UNIT
ARITHMETIC_UNIT # (
	.A_WIDTH(A_WIDTH_TOP),
	.B_WIDTH(B_WIDTH_TOP),
	.OUT_WIDTH(OUT_WIDTH_TOP)
)
ARITH_U
(	.clk(clk),
	.rst(rst),
	.ALU_FUN(ALU_FUN),
	.ARITHMETIC_Enable(int_Arith_Enable),
	.ALU_Carry(ALU_Carry),
	.ARITHMETIC_OUT(ARITHMETIC_OUT),
	.ARITHMETIC_Flag(ARITHMETIC_Flag)
);

//Logic_UNIT
LOGIC_UNIT # (
	.A_WIDTH(A_WIDTH_TOP),
	.B_WIDTH(B_WIDTH_TOP),
	.OUT_WIDTH(OUT_WIDTH_TOP)
)
LOG_U 
(	.clk(clk),
	.rst(rst),
	.ALU_FUN(ALU_FUN),
	.Logic_Enable(int_Logic_Enable),
	.Logic_OUT(Logic_OUT),
	.Logic_Flag(Logic_Flag)
);

//CMP_UNIT
CMP_UNIT # (
	.A_WIDTH(A_WIDTH_TOP),
	.B_WIDTH(B_WIDTH_TOP),
	.OUT_WIDTH(OUT_WIDTH_TOP)
)
CMP_U 
(	.clk(clk),
	.rst(rst),
	.ALU_FUN(ALU_FUN),
	.CMP_Enable(int_CMP_Enable),
	.CMP_OUT(CMP_OUT),
	.CMP_Flag(CMP_Flag)
);

//SHIFT_UNIT
SHIFT_UNIT # (
	.A_WIDTH(A_WIDTH_TOP),
	.B_WIDTH(B_WIDTH_TOP),
	.OUT_WIDTH(OUT_WIDTH_TOP)
)
SHIFT_U 
(	.clk(clk),
	.rst(rst),
	.ALU_FUN(ALU_FUN),
	.SHIFT_Enable(int_SHIFT_Enable),
	.SHIFT_OUT(SHIFT_OUT),
	.SHIFT_Flag(SHIFT_Flag)
);

endmodule : ALU_TOP