//FFD
//lectura asincrona
`ifndef PC_SV			//Directiva: Si xx_SV no esta definido
    `define PC_SV		//Directiva: pues se define

module pc
import RF_my_pkg::*;	
(
input logic [WD-1:0]d, //WD=32bits "located in my_pkg"
input bit clk, reset, 
input bit enable, 
output logic [WD-1:0]q
);

always@(posedge clk, negedge reset)
	begin

		if(!reset) q <= 32'h00400000
		
		
		
		;
				
		else if(enable) q <= d;
		
		
	end

endmodule

`endif
	 