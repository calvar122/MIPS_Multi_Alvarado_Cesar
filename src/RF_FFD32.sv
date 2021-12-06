//32 FFD con todo y and

`ifndef RF_FFD32_SV			//Directiva: Si xx_SV no esta definido
    `define RF_FFD32_SV		//Directiva: pues se define

module RF_FFD32
import RF_my_pkg::*;	
(
input logic [WD-1:0]data, 
input bit clk, reset, 
//input enablet and_i1,
input enablet and_i2,
input and_i1,
//input [WD-1:0] and_i2,
output FFD_O q
);

logic [WD-1:0] and_o;

genvar i;
generate
for (i=0; i<32; i++) begin: id_gen	


RF_FFD FFD32(.d(data),.clk(clk),.reset(reset),.enable(and_o[i]),.q(q[i]));
//and(and_o[i],and_i1[i],and_i2[i]);

and(and_o[i],and_i1,and_i2[i]);

end
endgenerate




endmodule

`endif
