//DATA_PATH WRAPPER

`ifndef DATA_PATH_SV
 `define DATA_PATH_SV
 
 module DATA_PATH
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
input  [1:0] ALUSrcB_i,
input  [2:0] ALUControl_i,
input 	clk,
input 	reset,
output logic [5:0] OP_o,
output logic [5:0] Funct_o,
output logic [DATA_WIDTH-1:0] ALU_OUT_o,
output logic [DATA_WIDTH-1:0] Scope_PC,
output logic [DATA_WIDTH-1:0] Scope_instr,
output logic [DATA_WIDTH-1:0] Scope_srca,
output logic [DATA_WIDTH-1:0] Scope_srcb,
output bit ZERO_f
 );
 
 DataPath DUV(	.IorD_i(IorD_i), .MemWrite_i(MemWrite_i), .IRWrite_i(IRWrite_i), .RegDst_i(RegDst_i), .MemtoReg_i(MemtoReg_i),
					.RegWrite_i(RegWrite_i), .ALUSrcA_i(ALUSrcA_i),  .PCSrc_i(PCSrc_i), .PCEn_i(PCEn_i), .ALUSrcB(ALUSrcB_i),
					.ALUControl(ALUControl_i), .clk(clk), .reset(reset), .OP_o(OP_o), .Funct_o(Funct_o),  .ALU_OUT(ALU_OUT_o),
					.Scope_PC(Scope_PC), .Scope_instr(Scope_instr), .Scope_srca(Scope_srca), .Scope_srcb(Scope_srcb),.ZERO(ZERO_f)
 );
 
 endmodule
 `endif