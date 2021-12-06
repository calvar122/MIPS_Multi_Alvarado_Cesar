//Package of Memory System

`ifndef MY_PKG_SV
	`define MY_PKG_SV

package my_pkg;

localparam DATA_WIDTH = 32; //DATA_WIDTH represents the word width
localparam ADDR_WIDTH = 64; //ADDR_WIDTH represents the depth of the memories
	
typedef logic [DATA_WIDTH-1:0] ram[ADDR_WIDTH-1:0];// matriz de 32x64 para las address de ram

typedef logic [DATA_WIDTH-1:0] rom [ADDR_WIDTH-1:0];// matriz de 32x64 para las address de rom

typedef logic [(DATA_WIDTH-1):0] inter_rom;	//interconexion salida rom con mux
typedef logic [(DATA_WIDTH-1):0] inter_ram;	//interconexion salida ram con mux

endpackage
`endif