`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/18 21:29:11
// Design Name: 
// Module Name: icache
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


module icache(
    input clk,
    input rst_n,
    input en,
    input[15:0] Addr,
    output reg[15:0] IR
      );
    reg[15:0] Instra;

always@(Addr)
begin
  case(Addr)
      16'b0000_0000_0000_0000:   Instra <= 16'b0000_0100_0000_0101;//mov r0,5
      16'b0000_0000_0000_0001:   Instra <= 16'b0000_0100_1000_0000;//mov r1,0
      16'b0000_0000_0000_0010:   Instra <= 16'b0001_0000_1000_0000;//sto r1,r0

      16'b0000_0000_0000_0011:   Instra <= 16'b0000_0100_0000_1010;//mov r0,10
      16'b0000_0000_0000_0100:   Instra <= 16'b0000_0100_1000_0001;//mov r1,1
      16'b0000_0000_0000_0101:   Instra <= 16'b0001_0000_1000_0000;//sto r1,r0

      16'b0000_0000_0000_0110:   Instra <= 16'b0000_0100_0000_0000;//mov r0,0
      16'b0000_0000_0000_0111:   Instra <= 16'b0000_0100_1000_0010;//mov r1,2
      16'b0000_0000_0000_1000:   Instra <= 16'b0001_0000_1000_0000;//sto r1,r0

      16'b0000_0000_0000_1001:   Instra <= 16'b0000_0100_0000_0100;//mov r0,4
      16'b0000_0000_0000_1010:   Instra <= 16'b0000_0100_1000_0011;//mov r1,3
      16'b0000_0000_0000_1011:   Instra <= 16'b0001_0000_1000_0000;//sto r1,r0

      16'b0000_0000_0000_1100:   Instra <= 16'b0000_0100_0000_0001;//mov r0,1
      16'b0000_0000_0000_1101:   Instra <= 16'b0000_0100_1000_0100;//mov r1,4
      16'b0000_0000_0000_1110:   Instra <= 16'b0001_0000_1000_0000;//sto r1,r0

      16'b0000_0000_0000_1111:   Instra <= 16'b0000_0100_0000_0110;//mov r0,6
      16'b0000_0000_0001_0000:   Instra <= 16'b0000_0100_1000_0101;//mov r1,5
      16'b0000_0000_0001_0001:   Instra <= 16'b0001_0000_1000_0000;//sto r1,r0

      16'b0000_0000_0001_0010:   Instra <= 16'b0000_0100_0000_0110;//mov r0,6
      16'b0000_0000_0001_0011:   Instra <= 16'b0000_0100_1000_0000;//mov r1,0
      16'b0000_0000_0001_0100:   Instra <= 16'b0000_0101_0000_0000;//mov r2,0

      16'b0000_0000_0001_0101:   Instra <= 16'b0000_0101_1000_0001;//mov r3,1
      16'b0000_0000_0001_0110:   Instra <= 16'b0000_0010_0011_0000;//mov r4,r3
      16'b0000_0000_0001_0111:   Instra <= 16'b0011_0010_0000_0000;//dec r4

      16'b0000_0000_0001_1000:   Instra <= 16'b0000_1010_1100_0000;//lad r5,r4
      16'b0000_0000_0001_1001:   Instra <= 16'b0000_1011_0011_0000;//lad r6,r3
      16'b0000_0000_0001_1010:   Instra <= 16'b0101_0010_1110_0000;//cmp r5,r6
      16'b0000_0000_0001_1011:   Instra <= 16'b1000_0100_0010_0010;//JLS 34

      16'b0000_0000_0001_1100:   Instra <= 16'b0000_0011_1101_0000;//mov r7,r5
      16'b0000_0000_0001_1101:   Instra <= 16'b0000_0010_1110_0000;//mov r5,r6
      16'b0000_0000_0001_1110:   Instra <= 16'b0000_0011_0111_0000;//mov r6,r7
      16'b0000_0000_0001_1111:   Instra <= 16'b0001_0010_0101_0000;//sto r4,r5
      16'b0000_0000_0010_0000:   Instra <= 16'b0001_0001_1110_0000;//sto r3,r6
      16'b0000_0000_0010_0001:   Instra <= 16'b0000_0101_0000_0000;//mov r2,0
      16'b0000_0000_0010_0010:   Instra <= 16'b0010_1001_1000_0000;//inc r3
      16'b0000_0000_0010_0011:   Instra <= 16'b0101_0001_1000_0000;//cmp r3,r0
      16'b0000_0000_0010_0100:   Instra <= 16'b0111_1100_0001_0110;//JLO 22
      16'b0000_0000_0010_0101:   Instra <= 16'b0000_0111_1000_0001;//mov r7,1
      16'b0000_0000_0010_0110:   Instra <= 16'b0010_0000_0111_0000;//sub r0,r7
      16'b0000_0000_0010_0111:   Instra <= 16'b0101_0000_0010_0000;//CMP r0,0
      16'b0000_0000_0010_1000:   Instra <= 16'b0110_0100_0001_0101;//JNE 21
      16'b0000_0000_0010_1001:   Instra <= 16'b1111_1000_0000_0000;//hlt
      default:                   Instra <= 16'b1111_1000_0000_0000;
  endcase
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
      IR <= 16'b0;
      
  end
  else  begin
      if(en) begin
          IR <= Instra;
      end
      
  end
end
endmodule