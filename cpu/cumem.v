`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/19 10:41:25
// Design Name: 
// Module Name: cumem
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


module cumem(
    input[15:0] MPC_out,
    output[31:0] Micro_ins,
    output[15:0] Next_addr
  );

reg[40:0] CU_data;

assign Micro_ins = {7'b0,CU_data[40:16]};
assign Next_addr = CU_data[15:0];

always@(MPC_out)
begin
  case(MPC_out)
//取指
  16'b0000000000000000:   CU_data = 41'b0000000000000000001011000_0000000000000001; 
  16'b0000000000000001:   CU_data = 41'b0000000000000000001110001_0000000000000000;
//MOV
  16'b0000010000000000:   CU_data = 41'b0000010000100000001010000_0000010000000001;
  16'b0000010000000001:   CU_data = 41'b0000000100000000000010000_0000000000000000; 
//MOV(I)
  16'b0000010000010000:   CU_data = 41'b0000000010000000001010000_0000010000010001; 
  16'b0000010000010001:   CU_data = 41'b0000000100000000000010000_0000000000000000; 
//LAD
  16'b0000010000100000:   CU_data = 41'b0000010000101000001010000_0000010000100001; 
  16'b0000010000100001:   CU_data = 41'b0000001001000101001010000_0000010000100010;
  16'b0000010000100010:   CU_data = 41'b0000000100000000000010000_0000000000000000;
//LAD(I)
  16'b0000010000110000:   CU_data = 41'b0000010010001000001010000_0000010000110001; 
  16'b0000010000110001:   CU_data = 41'b0000000001000101001010000_0000010000110010;
  16'b0000010000110010:   CU_data = 41'b0000000100000000000010000_0000000000000000;
//STO
  16'b0000010001000000:   CU_data = 41'b1111101000011000001010000_0000010001000001;  //10 11
  16'b0000010001000001:   CU_data = 41'b0000010000100011000010000_0000000000000000;
//ADD
  16'b0000010001100000:   CU_data = 41'b0100111000010000111010000_0000010001100001; 
  16'b0000010001100001:   CU_data = 41'b0000000100000000000010000_0000000000000000; 
//SUB
  16'b0000010010000000:   CU_data = 41'b0011011000010000111010000_0000010010000001;
  16'b0000010010000001:   CU_data = 41'b0000000100000000000010000_0000000000000000;
//INC  
  16'b0000010010100000:   CU_data = 41'b0100001000010000001010000_0000010010100001;
  16'b0000010010100001:   CU_data = 41'b0000000100000000000010000_0000000000000000;
//DEC
  16'b0000010011000000:   CU_data = 41'b0111101000010000001010000_0000010011000001; 
  16'b0000010011000001:   CU_data = 41'b0000000100000000000010000_0000000000000000;
//AND
  16'b0000010011100000:   CU_data = 41'b1101111000010000111010000_0000010011100001;
  16'b0000010011100001:   CU_data = 41'b0000000100000000000010000_0000000000000000;
//OR
  16'b0000010100000000:   CU_data = 41'b1111011000010000111010000_0000010100000001; 
  16'b0000010100000001:   CU_data = 41'b0000000100000000000010000_0000000000000000;
//NOT
  16'b0000010100100000:   CU_data = 41'b1000001000010000001010000_0000010100100001; 
  16'b0000010100100001:   CU_data = 41'b0000000100000000000010000_0000000000000000;
//CMP 
  16'b0000010101000000:   CU_data = 41'b0011011000000000110010000_0000000000000000; 
  16'b0000010101110000:   CU_data = 41'b0000000010000000000010111_0000000000000000;
//HLT
  16'b0000011111100000:   CU_data = 41'b0000000000000000000010000_0000000000000000;

  default:                CU_data = 41'b0000000000000000000000000_0000010000000001;
  endcase
end
endmodule
