//MUX
`ifndef MU_MUX_SV
	`define  MU_MUX_SV
module MU_MUX 
import MU_my_pkg::*;
(
   input [(DATA_WIDTH-1):0] my_rom,
   input [(DATA_WIDTH-1):0] my_ram,
	input bit sel,
	output [(DATA_WIDTH-1):0] out
   
);

assign out = sel ? my_rom : my_ram; 
endmodule 
`endif