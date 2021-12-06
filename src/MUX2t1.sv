//MUX 2X1

//MUX
`ifndef MUX2T1_SV
	`define  MUX2T1_SV
module MUX2t1 
import my_pkg::*;
(
   input [(DATA_WIDTH-1):0] a_i,
   input [(DATA_WIDTH-1):0] b_i,
	input bit sel,
	output logic [(DATA_WIDTH-1):0] out
   
);

assign out = sel ? b_i : a_i; 
endmodule 
`endif