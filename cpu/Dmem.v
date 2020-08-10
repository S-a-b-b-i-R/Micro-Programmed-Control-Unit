`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/18 00:30:44
// Design Name: 
// Module Name: Dmem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Dmem(
input clk,
input cs,
input we,
input Outenab,
input[7:0] Address,
input[15:0] data_in,
output[15:0] Dio,

/////////////////////////////////////////////////////////////////////////
output[15:0] M0_out,
output[15:0] M1_out,
output[15:0] M2_out,
output[15:0] M3_out,
output[15:0] M4_out,
output[15:0] M5_out

);
reg [15:0] RAM [255:0];

assign Dio = ({16{Outenab}}&{16{cs}}) ? RAM[Address] :
                                    16'b0;
always @(posedge clk ) begin
   if(cs & we & (~Outenab))
       RAM[Address] <= data_in;
       


end
///////////////////////////////////////////////////////////////////////////////////////       
assign M0_out = RAM[0];
assign M1_out = RAM[1];
assign M2_out = RAM[2];
assign M3_out = RAM[3];
assign M4_out = RAM[4];
assign M5_out = RAM[5];
endmodule
