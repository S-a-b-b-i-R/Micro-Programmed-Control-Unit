`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/17 19:52:45
// Design Name: 
// Module Name: dbus
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


module dbus(

input[15:0] ALU_out,   
input[15:0] B_out,
input[15:0] Dmen_out,
input[15:0] IR_data,
input ALU_out_en,
input B_out_en,
input Dmen_out_en,
input IR_data_en,
output[15:0] DBUS_out
  );

assign DBUS_out = ({16{ALU_out_en}} & ALU_out)
               |({16{B_out_en}} & B_out)
               |({16{Dmen_out_en}} & Dmen_out)
               |({16{IR_data_en}} & IR_data);

endmodule
