// Memory_system
`ifndef MU_MEMORYSYSTEM_SV
	`define  MU_MEMORYSYSTEM_SV
module MU_MemorySystem
import MU_my_pkg::*;
	(
	input Write_enable_i,
	input [(DATA_WIDTH-1):0] Write_Data_i,//escritura
	input clk,
	input [(DATA_WIDTH-1):0] addr_i,	//localizacion
	output [(DATA_WIDTH-1):0] Read_Data_o
	);
	
	inter_rom rom_o;	//mypkg, interconexion salida rom con mux
	inter_ram ram_o;	//mypkg, interconexion salida ram con mux
	
	bit addrs;	//auxiliar
	logic [(DATA_WIDTH-1):0] x = 32'h1000_0000;
	
	assign addrs = (addr_i < x) ? 1 : 0; //si addr_i es menor a 1_000_000 se elije rom sino ram
	
	MU_ROM my_rom(.addr(addr_i),.q(rom_o));
	
	MU_RAM my_ram(.addr(addr_i),.Write_Data(Write_Data_i),.clk(clk),.Write_enable(Write_enable_i),.q(ram_o));
	
	MU_MUX my_mux(.my_rom(rom_o), .my_ram(ram_o), .sel(addrs), .out(Read_Data_o));

endmodule
`endif