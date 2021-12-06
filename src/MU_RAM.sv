//RAM
`ifndef MU_RAM_SV
	`define  MU_RAM_SV
module MU_RAM
import MU_my_pkg::*;
(
input [DATA_WIDTH-1:0] addr,			//donde se va escribir?
input [DATA_WIDTH-1:0] Write_Data, //q se va escribir?
input clk,
input Write_enable,						//debo escribir?
output [DATA_WIDTH-1:0]q				//esto es lo q escribi
);

	// Declare the RAM variable (my pkg)
	ram myram;												//_____876543210_________
																// #0	 ||||||||| 
																// #1	 |||||||||
																// #............
																// #63 |||||||||
	logic [(DATA_WIDTH-1):0]i = 32'h10010000;
	
	always@(posedge clk)
	begin
	if(Write_enable)
	myram[(addr-i)>>2] <= Write_Data;
	end
	assign q = myram[(addr-i)>>2];
	
endmodule
`endif




