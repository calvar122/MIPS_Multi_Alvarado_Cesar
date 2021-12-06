//Package of Memory System

`ifndef MY_PKG_SV
	`define MY_PKG_SV

package my_pkg;

localparam DATA_WIDTH = 32; //DATA_WIDTH represents the word width
//localparam ADDR_WIDTH = 64; //ADDR_WIDTH represents the depth of the memories
localparam SEL_WIDTH =  3;	//Quantity of operations in ALU

localparam MUX5_WIDTH = 5; //PARA EL MUX DE 5BITS
localparam SigExt = 16;
parameter cuatro = 32'b00000000_00000000_00000000_00000100;

parameter add  	= 3'b000;
parameter sub 		= 3'b001;
parameter annd  	= 3'b010;
parameter noor  	= 3'b011;
parameter oor  	= 3'b100;
parameter slt	 	= 3'b101;
parameter sll	  	= 3'b110;
parameter srl  	= 3'b111;

endpackage
`endif