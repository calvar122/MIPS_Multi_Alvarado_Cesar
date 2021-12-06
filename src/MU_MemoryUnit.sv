//Memory Wrapper
`ifndef MU_MEMORYUNIT_SV
	`define  MU_MEMORYUNIT_SV
	
module MU_MemoryUnit
import MU_my_pkg::*;
	(
	input WE_i,
	input [(DATA_WIDTH-1):0] WD_i,//escritura
	input clk,
	input [(DATA_WIDTH-1):0] ADDR_i,	//localizacion
	output [(DATA_WIDTH-1):0] RD_o
	);	
	
	MU_MemorySystem DUV(
							.Write_enable_i(WE_i),
							.Write_Data_i(WD_i), 
							.clk(clk), 
							.addr_i(ADDR_i), 
							.Read_Data_o(RD_o)
						);
	

endmodule
	
`endif