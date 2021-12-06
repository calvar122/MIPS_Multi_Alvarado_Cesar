//MUX 4X1

`ifndef MUX4T1_SV
	`define  MUX4T1_SV
module MUX4t1 
import my_pkg::*;
(
   input [(DATA_WIDTH-1):0] a_i,
	input [(DATA_WIDTH-1):0] b_i,
   input [(DATA_WIDTH-1):0] c_i,
	input [(DATA_WIDTH-1):0] d_i,

	input bit [1:0] sel,
	output logic [(DATA_WIDTH-1):0] out
   
);

assign out = (sel[1]) ? (sel[0]? d_i:c_i) : (sel[0]? b_i:a_i);

endmodule 
`endif

//`ifndef MUX4T1_SV
//	`define  MUX4T1_SV
//module MUX4t1
//#(
//    parameter WIDTH = 32
//
//)
//(
//    /*input [WIDTH-1:0] w, x, y, z,
//   input [1:0] Sel,
//   output [WIDTH-1:0] Data_out*/
//
//    input [(WIDTH-1):0] w, x, y, z,
//   input [1:0] Sel,
//
//   output reg [(WIDTH-1):0] Data_out
//);
//
// localparam S0 = 2'b00;
//   localparam S1 = 2'b01;
//   localparam S2 = 2'b10;
//   localparam S3 = 2'b11;
//
//   always @ (*)
//   begin
//      case(Sel)
//            default:
//                Data_out = w;
//         S1: begin
//            Data_out = x;
//         end
//         S2: begin
//            Data_out = y;
//         end
//         S3: begin
//            Data_out = z;
//         end
//            endcase
//   end
//endmodule
//
//`endif