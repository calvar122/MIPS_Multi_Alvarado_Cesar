//ProgramCounter
`ifndef ALU_SV
 `define ALU_SV

module ALU
import my_pkg::*;
(
input [DATA_WIDTH-1:0] srca_i,
input [DATA_WIDTH-1:0] srcb_i,
input [SEL_WIDTH-1:0]  sel_i,
input bit clk,
output logic [DATA_WIDTH-1:0] aluresult_o,	//instantanious out
output logic [DATA_WIDTH-1:0] aluout_o,		//register out
output bit zeroflag_o
);

always@(*) begin
case(sel_i)
					//ARITHETIC OPERATIONS\\
	add: 		aluresult_o = (srca_i + srcb_i);	//R: rd = rs+rt
	//addi:		aluresult_o = (srca_i + srcb_i); //I: rt = rs+SignExtImm
	//addiu:	aluresult_o = (srca_i + srcb_i);	//I: rt = rs+SignExtImm
	//addu:		aluresult_o = (srca_i + srcb_i);	//R: rd = rs+rt	
	sub: 		aluresult_o = (srca_i - srcb_i);	//R: rd = rs-rt
	//subu:		aluresult_o = (srca_i - srcb_i);	//R: rd = rs-rt
	
					//BRANCH OPERATIONS\\\
	//beq: 	//I: if(rs==rt) PC=PC+4+BranchAddr
	//bne:	//I: if(rs!=rt) PC=PC+4+BranchAddr

	
					///JUMP OPERATIONS\\\
	//j:		//J: PC=JumpAddr
	//jal:	//J: R[31]=PC+8;  PC=JumpAddr
	//jr:		//R: PC=rs
	
					//LOAD OPERATIONS\\
					
					//LOGIAL OPERATIONS\\
	annd:		aluresult_o = (srca_i & srcb_i);	//R: rd = rs&rt
	//anndi:	aluresult_o = (srca_i & srcb_i);	//I: rt = rs&ZeroExtImm
	noor:		aluresult_o = ~(srca_i | srcb_i);	//R: rd = ~(rs|rt)
	oor:		aluresult_o = srca_i | srcb_i;		//R: rd = rs|rt
	//ori:		aluresult_o = srca_i | srcb_i;		//I: rt = rs|ZEROEXTIMM
					//COMPARISON OPERATIONS\\
	slt:		aluresult_o = (srca_i < srcb_i)? 1:0;//R: rd = (rs<rt)?1:0
	//slti:		aluresult_o = (srca_i < srb_i)? 1:0;//I: rt = (rs<SignExtImm)?1:0
	//sltiu:	aluresult_o = (srca_i < srb_i)? 1:0;//I: rt = (rs<SignExtImm)?1:0
	//sltu:		aluresult_o = (srca_i < srb_i)? 1:0;//R: rd = (rs<rt)?1:0
					//SHIFFT OPERATIONS\\
	sll:		aluresult_o = srca_i << srcb_i;		//R: rd = rt << shamnt
	srl:		aluresult_o = srca_i >> srcb_i;		//R: rd = rt >> shamnt
					//STORE COPERATIONS\\
	
	default: aluresult_o = 32'bx;

endcase 
end

always@(posedge clk)
	aluout_o <= aluresult_o;
	assign zeroflag_o = ~|aluresult_o;

endmodule

`endif