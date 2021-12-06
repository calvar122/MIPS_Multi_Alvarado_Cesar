//Sign Extend
`ifndef SIGNEXTEND_SV
 `define SIGNEXTEND_SV

module SignExtend
import my_pkg::*;
(
input [SigExt-1:0] IN,
output [DATA_WIDTH-1:0] OUT
);

assign OUT = { {16{IN[15]}}, IN };


endmodule

`endif