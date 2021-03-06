//FFD
//lectura asincrona
`ifndef RF_FFD_SV			//Directiva: Si xx_SV no esta definido
    `define RF_FFD_SV		//Directiva: pues se define

module RF_FFD
import RF_my_pkg::*;	
(
input logic [WD-1:0]d, //WD=32bits "located in my_pkg"
input bit clk, reset, 
input bit enable, 
output logic [WD-1:0]q
);

always@(posedge clk, negedge reset)
	begin

		if(!reset) q <= 0;
				
		else if(enable) q <= d;
		
		
	end

endmodule

`endif
	 
