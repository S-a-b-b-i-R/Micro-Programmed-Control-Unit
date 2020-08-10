`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/18 22:43:32
// Design Name: 
// Module Name: decode
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


module decode(
    input[5:0] Opcode,       //5位操作码加一位立即数标志
    output reg[15:0] CU_entry //微指令入�?
  );
always@(Opcode)
begin
  case(Opcode)  //通过Opcode找到指令�-Umem中的入口地址
      6'b000000:    CU_entry = 16'b000001_000000_0000;//MOV
      6'b000001:    CU_entry = 16'b000001_000001_0000;//MOV(I)
      6'b000010:    CU_entry = 16'b000001_000010_0000;//LAD
      6'b000011:    CU_entry = 16'b000001_000011_0000;//LAD(I)
      6'b000100:    CU_entry = 16'b000001_000100_0000;//STO
      6'b000110:    CU_entry = 16'b000001_000110_0000;//ADD
      6'b001000:    CU_entry = 16'b000001_001000_0000;//SUB
      6'b001010:    CU_entry = 16'b000001_001010_0000;//INC
      6'b001100:    CU_entry = 16'b000001_001100_0000;//DEC
      6'b001110:    CU_entry = 16'b000001_001110_0000;//AND
      6'b010000:    CU_entry = 16'b000001_010000_0000;//OR
      6'b010010:    CU_entry = 16'b000001_010010_0000;//NOT
      6'b010100:    CU_entry = 16'b000001_010100_0000;//CMP
      6'b010111:    CU_entry = 16'b000001_010111_0000;//JEQ
      6'b011001:    CU_entry = 16'b000001_010111_0000;//JNE
      6'b011011:    CU_entry = 16'b000001_010111_0000;//JHI
      6'b011101:    CU_entry = 16'b000001_010111_0000;//JHS
      6'b011111:    CU_entry = 16'b000001_010111_0000;//JLO
      6'b100001:    CU_entry = 16'b000001_010111_0000;//JLS
      6'b100011:    CU_entry = 16'b000001_010111_0000;//JMP
      6'b111110:    CU_entry = 16'b000000_000000_0000;//HLT
      default:      CU_entry = 16'b000000_000000_0000;
    endcase
end
endmodule
