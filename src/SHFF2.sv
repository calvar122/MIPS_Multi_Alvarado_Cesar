//SHIF TO 2
`ifndef SHFF2_SV
 `define SHFF2_SV
 
 module SHFF2
 import my_pkg::*;
 (
 input [DATA_WIDTH-1:0]in,
 output [DATA_WIDTH-1:0]out
 );
 
 assign out = in<<2;
 
 
 endmodule
 
 `endif