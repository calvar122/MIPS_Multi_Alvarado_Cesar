//MUX 2X1 (5 bits)

//MUX
`ifndef MUX2T1_5B_SV
	`define  MUX2T1_5B_SV
module MUX2t1_5B 
import my_pkg::*;
(
   input [(MUX5_WIDTH-1):0] a_i,
   input [(MUX5_WIDTH-1):0] b_i,
	input bit sel,
	output logic [(MUX5_WIDTH-1):0] out
   
);

assign out = sel ? b_i : a_i; 
endmodule 
`endif