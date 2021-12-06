//TB DataPath

`ifndef TB_DP_SV
 `define TB_DP_SV

module TB_DP;
import my_pkg::*;
bit 	TB_IorD_i;
bit 	TB_MemWrite_i;
bit 	TB_IRWrite_i;
bit 	TB_RegDst_i;
bit 	TB_MemtoReg_i;
bit 	TB_RegWrite_i;
bit 	TB_ALUSrcA_i;
bit 	TB_PCSrc_i;
bit 	TB_PCEn_i;
logic  [1:0] TB_ALUSrcB_i;
logic  [2:0] TB_ALUControl_i;
bit 	TB_clk;
bit 	TB_reset;

logic [5:0] TB_OP_o;
logic [5:0] TB_Funct_o;
logic [DATA_WIDTH-1:0] TB_ALU_OUT_o;
logic [DATA_WIDTH-1:0] Scope_PC;
logic [DATA_WIDTH-1:0] Scope_instr;
logic [DATA_WIDTH-1:0] Scope_srca;
logic [DATA_WIDTH-1:0] Scope_srcb;
bit TB_ZERO_f;

 DATA_PATH my_DUV(	.IorD_i(TB_IorD_i), 
		.MemWrite_i(TB_MemWrite_i), 
		.IRWrite_i(TB_IRWrite_i), 
		.RegDst_i(TB_RegDst_i), 
		.MemtoReg_i(TB_MemtoReg_i),
		.RegWrite_i(TB_RegWrite_i), 
		.ALUSrcA_i(TB_ALUSrcA_i),  
		.PCSrc_i(TB_PCSrc_i), 
		.PCEn_i(TB_PCEn_i), 
		.ALUSrcB_i(TB_ALUSrcB_i),
		.ALUControl_i(TB_ALUControl_i), 
		.clk(TB_clk), 
		.reset(TB_reset), 
		.OP_o(TB_OP_o), 
		.Funct_o(TB_Funct_o), 
		.ALU_OUT_o(TB_ALU_OUT_o),
		.Scope_PC(Scope_PC),
		.Scope_instr(Scope_instr),
		.Scope_srca(Scope_srca),
		.Scope_srcb(Scope_srcb),
		.ZERO_f(TB_ZERO_f)
 );

 	initial begin
	forever #1 TB_clk = ~TB_clk;
	end
 
 initial begin
/*
	#0 TB_reset = 1'b0;
	
	#2q TB_PCEn_i = 1'b1;
	#4 TB_reset = 1'b1;
	
	#0 TB_PCEn_i = 1'b1;
	TB_IorD_i = 1'b0;
	TB_MemWrite_i = 1'b0;
	TB_RegWrite_i = 1'b0;
	TB_IRWrite_i = 1'b1;	   
	#3 TB_PCEn_i = 1'b0;
	
	#0 TB_IRWrite_i = 1'b0;
	
	#7  TB_ALUSrcA_i = 1'b1;
	    TB_ALUSrcB_i = 2'b10;
	#5  TB_ALUControl_i = 3'b000;
	#2  TB_RegWrite_i = 1'b1;
	    TB_RegDst_i = 1'b0;
	    TB_MemtoReg_i = 1'b0;
		 
	#6 TB_RegWrite_i = 1'b0;
	#4 TB_ALUSrcA_i = 1'b0;
	   TB_ALUSrcB_i = 2'b01;
	   TB_ALUControl_i = 3'b000;
	   TB_PCSrc_i = 1'b0;
	   TB_RegDst_i = 1'bx;
	   TB_MemtoReg_i = 1'bx;
 */
 
	///////FETCH\\\\\\\
	// reseteo para que PC inicie en 00400000
	#0 TB_reset = 0;
	//Haciendo que PC entre a memory unit
	#0 TB_IorD_i = 0; //mux
	#0 TB_MemWrite_i = 0; //memoria modo ROM
	#0 TB_IRWrite_i = 1;  //habilitando registro instr
	
	#4 TB_reset = 1;	//deshabilitando reset
	
	///////DECODE\\\\\\\
	#2 TB_IRWrite_i = 0;  //DEShabilitando registro instr
	
	#0 TB_IorD_i = 1'bx; //mux en x decode_req
	//#0 TB_RegDst_i = 0;		//Eligiendo rt como destino debido a una addi tipo I
	//#0 TB_MemtoReg_i = 1;	//Eligiendo dato a escribir, el que viende de la memory
	#0	TB_RegWrite_i = 0;	//desHabilitando register file
	#0 TB_ALUSrcA_i = 1'bx; //mux en x decode_req
	#0 TB_ALUSrcB_i = 2'bxx; //mux en x decode_req
	
		///////EJECUTUION\\\\\\\
	#0 TB_ALUSrcA_i = 1; //mux en x decode_req
	#0 TB_ALUSrcB_i = 2'b10; //mux en x decode_req
	#0 TB_ALUControl_i = 3'b000;
	
	////WRITE BACK\\\\\\\
	#3 TB_RegDst_i = 0;//Ya que es un addi tip I se tiene que escribir en el rt20-16
	#0 TB_MemtoReg_i = 0;	//Eligo dato que viene de la ALU
	#0	TB_RegWrite_i = 1;	//Habilitando register file (se guarda 3 en rt, "$t1")
	
	//Incrementado el PC
	#3	TB_RegWrite_i = 0;		//deshabilitando register file write
	
	
	#0 TB_ALUSrcA_i = 0;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b01;	//Seleccionando 4 en srcb para incrementar el PC
	
	
	//Ahora a grabar el 4000004 en el PC
	//#2 TB_PCSrc_i = 0; //Seleccionando ALU result del ultimo MUX YA ESTABA ASI
	#4 TB_PCEn_i = 1;		//habilitando el PC
	#2 TB_PCEn_i = 0;		//des habilitando el PC
	#0 TB_IorD_i = 0; //mux SELECCIONA pc 
	//TB_MemWrite_i sigue en 0 modo rom
	TB_IRWrite_i = 1; //habilitando reg inst pa guardar dir de memory
	#2 TB_IRWrite_i = 0; //des-habilitando reg inst pa guardar dir de memory
	//RegDst sigue en 0, dejar asi por ser instruccion I
	//MemtoReg sigue en 0, dejar asi por ser instruccion I
	#1	TB_RegWrite_i = 1;		//habilitando register file write
	
	
	//ejecucion
	#0 TB_ALUSrcA_i = 1;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b10;	//Seleccionando signext en srcb para incrementar el PC
	
	
	////Incrementado el PC
	#5	TB_RegWrite_i = 0;		//deshabilitando register file write
	
	
	#0 TB_ALUSrcA_i = 0;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b01;	//Seleccionando 4 en srcb para incrementar el PC
	
	
	//Ahora a grabar el 4000008 en el PC
	//#2 TB_PCSrc_i = 0; //Seleccionando ALU result del ultimo MUX YA ESTABA ASI
	#4 TB_PCEn_i = 1;		//habilitando el PC
	#2 TB_PCEn_i = 0;		//des habilitando el PC
	#0 TB_IorD_i = 0; //mux SELECCIONA pc 
	//TB_MemWrite_i sigue en 0 modo rom
	TB_IRWrite_i = 1; //habilitando reg inst pa guardar dir de memory
	#2 TB_IRWrite_i = 0; //des-habilitando reg inst pa guardar dir de memory
	//RegDst sigue en 0, dejar asi por ser instruccion I
	//MemtoReg sigue en 0, dejar asi por ser instruccion I
	#1	TB_RegWrite_i = 1;		//habilitando register file write
	
	//ejecucion
	#0 TB_ALUSrcA_i = 1;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b10;	//Seleccionando signext en srcb para incrementar el PC
	
	
	
	/////////COMENZANDO ADD\\\\\\\\\\\
	////Incrementado el PC
	#5	TB_RegWrite_i = 0;		//deshabilitando register file write
	
	
	#0 TB_ALUSrcA_i = 0;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b01;	//Seleccionando 4 en srcb para incrementar el PC
	
	
	
	//Ahora a grabar el 400000C en el PC
	//#2 TB_PCSrc_i = 0; //Seleccionando ALU result del ultimo MUX YA ESTABA ASI
	#4 TB_PCEn_i = 1;		//habilitando el PC
	#2 TB_PCEn_i = 0;		//des habilitando el PC
	#0 TB_IorD_i = 0; //mux SELECCIONA pc 
	//TB_MemWrite_i sigue en 0 modo rom
	TB_IRWrite_i = 1; //habilitando reg inst pa guardar dir de memory
	#2 TB_IRWrite_i = 0; //des-habilitando reg inst pa guardar dir de memory
	//LO SIGUIENTE CAMBIA PUES YA ES FORMATO R
	#2 TB_RegDst_i = 1; //cambiar a 1, por ser instruccion R(guardar en rd)
	
	#0 TB_ALUSrcA_i = 1;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b00;	//Seleccionando 4 en srcb para incrementar el PC
	//MemtoReg sigue en 0, dejar asi por que vamos a guardar lo de la ALU en rd
	#2	TB_RegWrite_i = 1;		//habilitando register file write
	
	///////////////////instruccion 5
	////Incrementado el PC
	#2	TB_RegWrite_i = 0;		//deshabilitando register file write
	
	
	#0 TB_ALUSrcA_i = 0;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b01;	//Seleccionando 4 en srcb para incrementar el PC
	//Ahora a grabar el 4000010 en el PC
	//#2 TB_PCSrc_i = 0; //Seleccionando ALU result del ultimo MUX YA ESTABA ASI
	#4 TB_PCEn_i = 1;		//habilitando el PC
	#2 TB_PCEn_i = 0;		//des habilitando el PC
	#0 TB_IorD_i = 0; //mux SELECCIONA pc 
	//TB_MemWrite_i sigue en 0 modo rom
	TB_IRWrite_i = 1; //habilitando reg inst pa guardar dir de memory
	#2 TB_IRWrite_i = 0; //des-habilitando reg inst pa guardar dir de memory
	//LO SIGUIENTE CAMBIA PUES YA ES FORMATO R
	#2 TB_RegDst_i = 1; //cambiar a 1, por ser instruccion R(guardar en rd)
	
	#0 TB_ALUSrcA_i = 1;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b00;	//Seleccionando 4 en srcb para incrementar el PC
	//MemtoReg sigue en 0, dejar asi por que vamos a guardar lo de la ALU en rd
	#2	TB_RegWrite_i = 1;		//habilitando register file write
	
	///////////////////instruccion 6
	////Incrementado el PC
	#2	TB_RegWrite_i = 0;		//deshabilitando register file write
	
	
	#0 TB_ALUSrcA_i = 0;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b01;	//Seleccionando 4 en srcb para incrementar el PC
	//Ahora a grabar el 4000014 en el PC
	//#2 TB_PCSrc_i = 0; //Seleccionando ALU result del ultimo MUX YA ESTABA ASI
	#4 TB_PCEn_i = 1;		//habilitando el PC
	#2 TB_PCEn_i = 0;		//des habilitando el PC
	#0 TB_IorD_i = 0; //mux SELECCIONA pc 
	//TB_MemWrite_i sigue en 0 modo rom
	TB_IRWrite_i = 1; //habilitando reg inst pa guardar dir de memory
	#2 TB_IRWrite_i = 0; //des-habilitando reg inst pa guardar dir de memory
	//LO SIGUIENTE CAMBIA PUES YA ES FORMATO R
	#2 TB_RegDst_i = 1; //cambiar a 1, por ser instruccion R(guardar en rd)
	
	#0 TB_ALUSrcA_i = 1;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b00;	//Seleccionando 4 en srcb para incrementar el PC
	//MemtoReg sigue en 0, dejar asi por que vamos a guardar lo de la ALU en rd
	#2	TB_RegWrite_i = 1;		//habilitando register file write
	
	
	
	/*#0 TB_ALUSrcA_i = 1;	//seleccionando RF como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b00;	//Seleccionando RF como SRCB en la alu
	
	//Haciendo que PC entre a memory unit
	#0 TB_IorD_i = 0; //selecccionando al PC para que entre al RF
	#0 TB_MemWrite_i = 0; //memoria modo ROM
	#0 TB_IRWrite_i = 1;  //habilitando registro instr
	
	///////DECODE\\\\\\\
	#4 TB_IRWrite_i = 0;  //DEShabilitando registro instr

	
	#0 TB_IorD_i = 1'bx; //mux en x decode_req
	#0	TB_RegWrite_i = 0;	//desHabilitando register file
	#0 TB_ALUSrcA_i = 1'bx; //mux en x decode_req
	#0 TB_ALUSrcB_i = 2'bxx; //mux en x decode_req
	
	///////EJECUTUION\\\\\\\
	#0 TB_ALUSrcA_i = 1; //mux en x decode_req
	#0 TB_ALUSrcB_i = 2'b10; //mux en x decode_req
	#0 TB_ALUControl_i = 3'b000;
	
	////WRITE BACK\\\\\\\
	#3 TB_RegDst_i = 0;//Ya que es un addi tip I se tiene que escribir en el rt20-16
	#0 TB_MemtoReg_i = 0;	//Eligo dato que viene de la ALU
	#0	TB_RegWrite_i = 1;	//Habilitando register file (se guarda 7 en rt, "$t3")
	
	//Incrementado el PC
	#3	TB_RegWrite_i = 0;		//deshabilitando register file write
	#0 TB_ALUSrcA_i = 0;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b01;	//Seleccionando 4 en srcb para incrementar el PC
	
	//Ahora a grabar el 4000008 en el PC
	#2 TB_PCSrc_i = 0; //Seleccionando ALU result del ultimo MUX
	#0 TB_PCEn_i = 1;		//habilitando el PC
	#4 TB_PCEn_i = 0;		//deshabilitando el PC
	#0 TB_ALUSrcA_i = 1;	//seleccionando RF como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b00;	//Seleccionando RF como SRCB en la alu
	
	//Haciendo que PC entre a memory unit
	#0 TB_IorD_i = 0; //selecccionando al PC para que entre al RF
	#0 TB_MemWrite_i = 0; //memoria modo ROM
	#0 TB_IRWrite_i = 1;  //habilitando registro instr
	
		///////DECODE\\\\\\\
	#4 TB_IRWrite_i = 0;  //DEShabilitando registro instr

	
	#0 TB_IorD_i = 1'bx; //mux en x decode_req
	#0	TB_RegWrite_i = 0;	//desHabilitando register file
	#0 TB_ALUSrcA_i = 1'bx; //mux en x decode_req
	#0 TB_ALUSrcB_i = 2'bxx; //mux en x decode_req
	
		///////EJECUTUION\\\\\\\
	#0 TB_ALUSrcA_i = 1; //mux en x decode_req
	#0 TB_ALUSrcB_i = 2'b10; //mux en x decode_req
	#0 TB_ALUControl_i = 3'b000; //Operacion addi
	
		////WRITE BACK\\\\\\\
	#3 TB_RegDst_i = 0;//Ya que es un addi tip I se tiene que escribir en el rt20-16
	#0 TB_MemtoReg_i = 0;	//Eligo dato que viene de la ALU
	#0	TB_RegWrite_i = 1;	//Habilitando register file (se guarda 1 en rt, "$t3")
	
		//Incrementado el PC
	#3	TB_RegWrite_i = 0;		//deshabilitando register file write
	#0 TB_ALUSrcA_i = 0;			//seleccionando PC como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b01;	//Seleccionando 4 en srcb para incrementar el PC
	
		//Ahora a grabar el 400000c en el PC
	#2 TB_PCSrc_i = 0; //Seleccionando ALU result del ultimo MUX
	#0 TB_PCEn_i = 1;		//habilitando el PC
	#4 TB_PCEn_i = 0;		//deshabilitando el PC
	#0 TB_ALUSrcA_i = 1;	//seleccionando RF como SRCA en la ALU
	#0 TB_ALUSrcB_i = 2'b00;	//Seleccionando RF como SRCB en la alu
	
	///////////////AQUI TERMINAN LAS 3 ADDI Y COMIENZAN LAS ADD\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	//Haciendo que PC entre a memory unit
	#0 TB_IorD_i = 0; //selecccionando al PC para que entre al RF
	#0 TB_MemWrite_i = 0; //memoria modo ROM
	#0 TB_IRWrite_i = 1;  //habilitando registro instr
	
			///////DECODE\\\\\\\
	#4 TB_IRWrite_i = 0;  //DEShabilitando registro instr

	
	#0 TB_IorD_i = 1'bx; //mux en x decode_req
	#0	TB_RegWrite_i = 0;	//desHabilitando register file
	#0 TB_ALUSrcA_i = 1'bx; //mux en x decode_req
	#0 TB_ALUSrcB_i = 2'bxx; //mux en x decode_req
	
	///////EJECUTUION\\\\\\\
	#0 TB_ALUSrcA_i = 1; //mux srca en 1 para elegir salida de RF a la ALU
	#0 TB_ALUSrcB_i = 2'b00; //mux srcb en 00 para elegir las dos salidas del RF
	#0 TB_ALUControl_i = 3'b000; //Operacion ADD addi
*/
end		
 
endmodule
`endif