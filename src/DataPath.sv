//Data path

`ifndef DATAPATH_SV
 `define DATAPATH_SV
 
 module DataPath
 import my_pkg::*;
 (
input 	IorD_i,
			MemWrite_i,
			IRWrite_i,
			RegDst_i,
			MemtoReg_i,
			RegWrite_i,
			ALUSrcA_i,
			PCSrc_i,
			PCEn_i,
input  [1:0] ALUSrcB,
input  [2:0] ALUControl,
input 	clk,
input 	reset,
output logic [5:0] OP_o,
output logic [5:0] Funct_o,
output logic [DATA_WIDTH-1:0] ALU_OUT,
output logic [DATA_WIDTH-1:0] Scope_PC,
output logic [DATA_WIDTH-1:0] Scope_instr,
output logic [DATA_WIDTH-1:0] Scope_srca,
output logic [DATA_WIDTH-1:0] Scope_srcb,
output bit ZERO
 );
 
 logic [DATA_WIDTH-1:0] conex1;
 logic [DATA_WIDTH-1:0] omuximemory;
 logic [DATA_WIDTH-1:0] omemory;
 logic [DATA_WIDTH-1:0] oInstrReg;	//salida de registro de instr
 logic [DATA_WIDTH-1:0] oDataReg;
 logic [DATA_WIDTH-1:0] ALUOut;
 logic [DATA_WIDTH-1:0] ALUResult;
 logic [DATA_WIDTH-1:0] WDcon;
 logic [DATA_WIDTH-1:0] RD1con;
 logic [DATA_WIDTH-1:0] RD2con;
 logic [DATA_WIDTH-1:0] WDMcon; //Interconexion entre la memoria WD y ReadData 2
 logic [DATA_WIDTH-1:0] RD1RtoMUXALU1; //Interconexion entre la memoria WD y ReadData 2
 logic [DATA_WIDTH-1:0] SRCA; //Para entrada A de aku
 logic [DATA_WIDTH-1:0] SRCB; //Para entrada B de aku
 logic [DATA_WIDTH-1:0] SGNExout;
 logic [DATA_WIDTH-1:0] SHFout;
 logic [DATA_WIDTH-1:0] PCfeedback;

 
 logic [MUX5_WIDTH-1:0] toWR;			//DE 5BITS
 
 
 //Program counter
 pc 			PC 			(.d(PCfeedback), .clk(clk), .reset(reset), .enable(PCEn_i), .q(conex1));
 //Mux del Address para la memoria
 MUX2t1 			muxAddr 		(.a_i(conex1), .b_i(ALUOut), .sel(IorD_i), .out(omuximemory));
 //Unidad de memoria
 MU_MemoryUnit MU				(.WE_i(MemWrite_i), .WD_i(WDMcon), .clk(clk), .ADDR_i(omuximemory), .RD_o(omemory));
 //Registri de instruccion (salida de memoria)
 RF_FFD 			Instr			(.d(omemory), .clk(clk), .reset(reset), .enable(IRWrite_i), .q(oInstrReg));	
 //Registro de data (salida de memoria )
 RF_FFD 			Data			(.d(omemory), .clk(clk), .reset(reset), .enable(1), .q(oDataReg));	
 //MUX 5 BITS 2TO1 
  MUX2t1_5B		WRegmux		(.a_i(oInstrReg[20:16]), .b_i(oInstrReg[15:11]), .sel(RegDst_i), .out(toWR));
  //Mux del WD
 MUX2t1 			WDmux 		(.a_i(ALUOut), .b_i(oDataReg), .sel(MemtoReg_i), .out(WDcon));
 //Register File												WE3								A1							A2							A3	
 RF_TOP			RegFile		(.clk(clk), .reset(reset), .Reg_Write_i(RegWrite_i), .Read_Register_1_i(oInstrReg[25:21]), .Read_Register_2_i(oInstrReg[20:16]),
									.Write_Register_i(toWR), .Write_Data_i(WDcon), .Read_Data_1_o(RD1con), .Read_Data_2_o(RD2con));
 //SIGN EXTEND
 SignExtend		signExt		(.IN(oInstrReg[15:0]), .OUT(SGNExout));
 //Registros de salida del RegisterFile
 RF_FFD 			RDReg1			(.d(RD1con), .clk(clk), .reset(reset), .enable(1), .q(RD1RtoMUXALU1));	
 RF_FFD 			RDReg2			(.d(RD2con), .clk(clk), .reset(reset), .enable(1), .q(WDMcon));	
 
 //Mux del sourceA de la ALU (OJO YA CONTIENE REGISTRO)
 MUX2t1 			ALUmuxA 		(.a_i(conex1), .b_i(RD1RtoMUXALU1), .sel(ALUSrcA_i), .out(SRCA));
 
 //ALU
 ALU				alu			(.srca_i(SRCA), .srcb_i(SRCB), .sel_i(ALUControl), .clk(clk), .aluresult_o(ALUResult), .aluout_o(ALUOut), .zeroflag_o(ZERO));
 
 //MUX 4 A 1
 MUX4t1			MUX4			(.a_i(WDMcon), .b_i(cuatro), .c_i(SGNExout), .d_i(SHFout), .sel(ALUSrcB), .out(SRCB));
 
 //Shiffter 2
 SHFF2			SHFL2			(.in(SGNExout), .out(SHFout));
 
 // MUX 
 MUX2t1 			muxALUout	(.a_i(ALUResult), .b_i(ALUOut), .sel(PCSrc_i), .out(PCfeedback));
 

 
 assign  OP_o = oInstrReg[31:26];
  assign  Funct_o = oInstrReg[5:0];
  assign ALU_OUT = ALUOut;
  assign Scope_PC = conex1; //pa ver que anda mandando el PC
 assign Scope_instr = oInstrReg;
 assign Scope_srca = SRCA;
 assign Scope_srcb = SRCB;
 
 endmodule
 
 `endif