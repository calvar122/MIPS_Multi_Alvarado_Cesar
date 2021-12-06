//TOP MODULE - REGISTER FILE

`ifndef RF_TOP_SV			//Directiva: Si xx_SV no esta definido
    `define RF_TOP_SV		//Directiva: pues se define

module RF_TOP
import RF_my_pkg::*;	
(
input clk, 
input reset, 

//input [WD-1:0]Reg_Write_i,
input Reg_Write_i,
input [SEL-1:0]Read_Register_1_i,
input [SEL-1:0]Read_Register_2_i,
input [SEL-1:0]Write_Register_i,
input [WD-1:0]Write_Data_i,
output [WD-1:0]Read_Data_1_o,
output [WD-1:0]Read_Data_2_o
);


RF_RegFile UUT(
				.clk(clk), .reset(reset), .Reg_Write_i(Reg_Write_i), .Read_Register_1_i(Read_Register_1_i), .Read_Register_2_i(Read_Register_2_i),
				.Write_Register_i(Write_Register_i), .Write_Data_i(Write_Data_i), .Read_Data_1_o(Read_Data_1_o), .Read_Data_2_o(Read_Data_2_o) 
);

endmodule
`endif
