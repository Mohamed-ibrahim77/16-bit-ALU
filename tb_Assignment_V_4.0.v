module tb_16_bit_ALU ();

	parameter A_WIDTH_TB = 4;
	parameter B_WIDTH_TB = 4;
	parameter OUT_WIDTH_TB = A_WIDTH_TB + B_WIDTH_TB;

	reg  signed [A_WIDTH_TB-1 : 0]   A_tb;
	reg  signed [B_WIDTH_TB-1 : 0]   B_tb;
	reg 				  		 	 clk_tb, rst_tb;
	reg 	    [3 : 0] 		     ALU_FUN_tb;

	wire signed [OUT_WIDTH_TB-1 : 0] ARITHMETIC_OUT_tb;
	wire        [OUT_WIDTH_TB-1 : 0] Logic_OUT_tb;
	wire        [OUT_WIDTH_TB-1 : 0] CMP_OUT_tb;
	wire        [OUT_WIDTH_TB-1 : 0] SHIFT_OUT_tb;
	
	wire 					         Carry_OUT_tb;
	wire 					         ARITHMETIC_Flag_tb;
	wire 					         Logic_Flag_tb;
	wire 					         CMP_Flag_tb;
	wire 					         SHIFT_Flag_tb;

    //top module instantation 
    ALU_TOP #(.A_WIDTH_TOP(A_WIDTH_TB), .B_WIDTH_TOP(B_WIDTH_TB)) top_module (
	.A(A_tb),
 	.B(B_tb),
  	.clk(clk_tb),
   	.rst(rst_tb),
    .ALU_FUN(ALU_FUN_tb),
    .ARITHMETIC_OUT(ARITHMETIC_OUT_tb),
    .Carry_OUT(Carry_OUT_tb),
    .Logic_OUT(Logic_OUT_tb),
    .CMP_OUT(CMP_OUT_tb),
    .SHIFT_OUT(SHIFT_OUT_tb),
    .ARITHMETIC_Flag(ARITHMETIC_Flag_tb),
    .Logic_Flag(Logic_Flag_tb),
    .CMP_Flag(CMP_Flag_tb),
    .SHIFT_Flag(SHIFT_Flag_tb));


	//clk generator
	always begin
		#6 clk_tb = ~clk_tb;
		#4 clk_tb = ~clk_tb;	
	end
	
	//test cases & secnarios
	initial begin
		//inputs initialization
		clk_tb = 0; rst_tb = 1;
		A_tb = 4'b0111;
		B_tb = 4'b0011;
		ALU_FUN_tb = 4'b0;

		#10 rst_tb = 0;
/*---------------------------------------------------------------------------------------------------------------
------------------------------------- Arithmetic Addition -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------*/

		//test case 1 (Arithmatic : signed Addition > A is Negative & B is Negative)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 1 , Arithmatic : signed Addition") ;
		#20 ALU_FUN_tb = 4'b0000;
			A_tb = 4'sb1111; // -1
			B_tb = 4'sb1011; // -5

		#10
  		if (ARITHMETIC_OUT_tb == -'d6)
   			 $display ("Addition %0d + %0d is passed with ALU value = %0h at simulation time %0t",A_tb,B_tb,ARITHMETIC_OUT_tb,$time);
 		 else
  			 $display ("Addition %0d + %0d is failed with ALU value = %0h at simulation time %0t",A_tb,B_tb,ARITHMETIC_OUT_tb,$time); 

  		//test case 2 (Arithmatic : signed Addition > A is Positive & B is Negative)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 2 , Arithmatic : signed Addition") ;
		#20 ALU_FUN_tb = 4'b0000;
			A_tb = 4'sb0111; //  7
			B_tb = 4'sb1011; // -5

		#10
  		if (ARITHMETIC_OUT_tb == 'd2)
   			 $display ("Addition %0d + %0d is passed with ALU value = %0h at simulation time %0t",A_tb,B_tb,ARITHMETIC_OUT_tb,$time);
 		 else
  			 $display ("Addition %0d + %0d is failed with ALU value = %0h at simulation time %0t",A_tb,B_tb,ARITHMETIC_OUT_tb,$time); 

  		//test case 3 (Arithmatic : signed Addition >  A is Negative & B is Positive)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 3 , Arithmatic : signed Addition") ;
		#20 ALU_FUN_tb = 4'b0000;
			A_tb = 4'sb1111; // -1
			B_tb = 4'sb0110; //  6

		#10
  		if (ARITHMETIC_OUT_tb == 'd5)
   			 $display ("Addition %0d + %0d is passed with ALU value = %0h at simulation time %0t",A_tb,B_tb,ARITHMETIC_OUT_tb,$time);
 		 else
  			 $display ("Addition %0d + %0d is failed with ALU value = %0h at simulation time %0t",A_tb,B_tb,ARITHMETIC_OUT_tb,$time); 	
	
		//test case 4 (Arithmatic : signed Addition >  A is Positive & B is Positive)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 4 , Arithmatic : signed Addition") ;
		#20 ALU_FUN_tb = 4'b0000;
			A_tb = 4'sb0111; //  7
			B_tb = 4'sb0110; //  6

		#10
  		if (ARITHMETIC_OUT_tb == 'd13)
   			 $display ("Addition %0d + %0d is passed with ALU value = %0h at simulation time %0t",A_tb,B_tb,ARITHMETIC_OUT_tb,$time);
 		 else
  			 $display ("Addition %0d + %0d is failed with ALU value = %0h at simulation time %0t",A_tb,B_tb,ARITHMETIC_OUT_tb,$time); 	

/*---------------------------------------------------------------------------------------------------------------
------------------------------------- Arithmetic Subtraction ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------*/
/*
		//test case 5 (Arithmatic : signed Subtraction)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 2 , Arithmatic : unsigned Subtraction") ;
		#20 ALU_FUN_tb = 4'b0001;

		#10
  		if (ALU_OUT_tb == 16'h4)
   			 $display ("TEST CASE 2 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 2 is failed "); 

  		//test case 6 (Arithmatic : signed Subtraction)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 2 , Arithmatic : unsigned Subtraction") ;
		#20 ALU_FUN_tb = 4'b0001;

		#10
  		if (ALU_OUT_tb == 16'h4)
   			 $display ("TEST CASE 2 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 2 is failed "); 
		
		//test case 7 (Arithmatic : signed Subtraction)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 2 , Arithmatic : unsigned Subtraction") ;
		#20 ALU_FUN_tb = 4'b0001;

		#10
  		if (ALU_OUT_tb == 16'h4)
   			 $display ("TEST CASE 2 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 2 is failed "); 
		
		//test case 8 (Arithmatic : signed Subtraction)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 2 , Arithmatic : unsigned Subtraction") ;
		#20 ALU_FUN_tb = 4'b0001;

		#10
  		if (ALU_OUT_tb == 16'h4)
   			 $display ("TEST CASE 2 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 2 is failed "); 
	
/*---------------------------------------------------------------------------------------------------------------
------------------------------------- Arithmetic Multiplication -------------------------------------------------
---------------------------------------------------------------------------------------------------------------*/
/*
		//test case 9 (Arithmatic : signed Multiplication)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 3 , Arithmatic : unsigned Multiplication") ;
		#20 ALU_FUN_tb = 4'b0010;

		#10
  		if (ALU_OUT_tb == 16'h15)
   			 $display ("TEST CASE 3 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 3 is failed "); 

  		//test case 10 (Arithmatic : signed Multiplication)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 3 , Arithmatic : unsigned Multiplication") ;
		#20 ALU_FUN_tb = 4'b0010;

		#10
  		if (ALU_OUT_tb == 16'h15)
   			 $display ("TEST CASE 3 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 3 is failed "); 

  		//test case 11 (Arithmatic : signed Multiplication)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 3 , Arithmatic : unsigned Multiplication") ;
		#20 ALU_FUN_tb = 4'b0010;

		#10
  		if (ALU_OUT_tb == 16'h15)
   			 $display ("TEST CASE 3 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 3 is failed "); 

  		//test case 12 (Arithmatic : signed Multiplication)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 3 , Arithmatic : unsigned Multiplication") ;
		#20 ALU_FUN_tb = 4'b0010;

		#10
  		if (ALU_OUT_tb == 16'h15)
   			 $display ("TEST CASE 3 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 3 is failed "); 	 	 	

/*---------------------------------------------------------------------------------------------------------------
------------------------------------- Arithmetic Division -------------------------------------------------
---------------------------------------------------------------------------------------------------------------*/
/*
		//test case 13 (Arithmatic : signed Division)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 4 , Arithmatic : unsigned Division") ;
		#20 ALU_FUN_tb = 4'b0011;

		#10
  		if (ALU_OUT_tb == 16'h2)
   			 $display ("TEST CASE 4 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 4 is failed "); 

  		//test case 14 (Arithmatic : signed Division)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 4 , Arithmatic : unsigned Division") ;
		#20 ALU_FUN_tb = 4'b0011;

		#10
  		if (ALU_OUT_tb == 16'h2)
   			 $display ("TEST CASE 4 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 4 is failed "); 

  		//test case 15 (Arithmatic : signed Division)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 4 , Arithmatic : unsigned Division") ;
		#20 ALU_FUN_tb = 4'b0011;

		#10
  		if (ALU_OUT_tb == 16'h2)
   			 $display ("TEST CASE 4 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 4 is failed "); 
		
		//test case 16 (Arithmatic : signed Division)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 4 , Arithmatic : unsigned Division") ;
		#20 ALU_FUN_tb = 4'b0011;

		#10
  		if (ALU_OUT_tb == 16'h2)
   			 $display ("TEST CASE 4 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 4 is failed "); 

/*---------------------------------------------------------------------------------------------------------------
------------------------------------- Logical Operations --------------------------------------------------------
---------------------------------------------------------------------------------------------------------------*/
/*
		//test case 17 (Logic : AND)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 5 , Logic : AND") ;
		#20 ALU_FUN_tb = 4'b0100;

		#10
  		if (ALU_OUT_tb == 16'h3)
   			 $display ("TEST CASE 5 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 5 is failed "); 

		//test case 18 (Logic : OR)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 6 , Logic : OR") ;
		#20 ALU_FUN_tb = 4'b0101;

		#10
  		if (ALU_OUT_tb == 16'h7)
   			 $display ("TEST CASE 6 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 6 is failed "); 

		//test case 19 (Logic : NAND)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 7 , Logic : NAND") ;
		#20 ALU_FUN_tb = 4'b0110;

		#10
  		if (ALU_OUT_tb == 16'hfffc)
   			 $display ("TEST CASE 7 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 7 is failed "); 

		//test case 20 (Logic : NOR)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 8 , Logic : NOR") ;
		#20 ALU_FUN_tb = 4'b0111;

		#10
  		if (ALU_OUT_tb == 16'hfff8)
   			 $display ("TEST CASE 8 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 8 is failed "); 

/*---------------------------------------------------------------------------------------------------------------
------------------------------------- Compare Operations --------------------------------------------------------
---------------------------------------------------------------------------------------------------------------*/
/*		
		//test case 21 (CMP: A = B)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 11 , CMP: A = B") ;
		#20 ALU_FUN_tb = 4'b1010;

		#10
  		if (ALU_OUT_tb == 16'h0)
   			 $display ("TEST CASE 11 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 11 is failed "); 

		//test case 22 (CMP: A > B)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 12 , CMP: A > B") ;
		#20 ALU_FUN_tb = 4'b1011;

		#10
  		if (ALU_OUT_tb == 16'h2)
   			 $display ("TEST CASE 12 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 12 is failed "); 

		//test case 23 (CMP: A < B)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 13 , CMP: A < B") ;
		#20 ALU_FUN_tb = 4'b1100;

		#10
  		if (ALU_OUT_tb == 16'h0)
   			 $display ("TEST CASE 13 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 13 is failed "); 

/*---------------------------------------------------------------------------------------------------------------
------------------------------------- Shift Operations ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------*/
/*
		//test case 24 (SHIFT: A >> 1)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 14 , SHIFT: A >> 1") ;
		#20 ALU_FUN_tb = 4'b1101 ;

		#10
  		if (ALU_OUT_tb == 16'h3)
   			 $display ("TEST CASE 14 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 14 is failed "); 

		//test case 25 (SHIFT: A << 1)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 15 , SHIFT: A << 1") ;
		#20 ALU_FUN_tb = 4'b1110;

		#10
  		if (ALU_OUT_tb == 16'he)
   			 $display ("TEST CASE 15 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 15 is failed "); 

  		//test case 26 (SHIFT: B >> 1)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 14 , SHIFT: A >> 1") ;
		#20 ALU_FUN_tb = 4'b1101 ;

		#10
  		if (ALU_OUT_tb == 16'h3)
   			 $display ("TEST CASE 14 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 14 is failed "); 

		//test case 27 (SHIFT: B << 1)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 15 , SHIFT: A << 1") ;
		#20 ALU_FUN_tb = 4'b1110;

		#10
  		if (ALU_OUT_tb == 16'he)
   			 $display ("TEST CASE 15 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 15 is failed "); 

/*---------------------------------------------------------------------------------------------------------------
------------------------------------- NO Operation --------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------*/
/*		
		//test case 28 (NO Operation)
		//----------------------------------------------------------------------------------------------------
		$display ("TEST CASE 16 , NO Operation") ;
		#20 ALU_FUN_tb = 4'b1111;
		
		#10
  		if (ALU_OUT_tb == 16'h0)
   			 $display ("TEST CASE 16 is passed with ALU value = %0h at simulation time %0t",ALU_OUT_tb,$time);
 		 else
  			 $display ("TEST CASE 16 is failed "); 
*/
		#10
		$stop;	
	end	
endmodule : tb_16_bit_ALU