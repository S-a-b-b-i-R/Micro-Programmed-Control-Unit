`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/19 12:31:10
// Design Name: 
// Module Name: psw
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


module psw(
input clk,
input rst_n,
input CF_en,
input ZF_en,
input CF_in,
input ZF_in,
input[4:0] Opcode,
output reg jmp
  );
reg ZF;
reg CF;
wire EQ;
wire NE;
wire HI;
wire HS;
wire LO;
wire LS;

assign EQ = ZF ? 1'b1:1'b0;
assign NE = ~EQ;
assign HI = ((~ZF)&(~CF)) ? 1'b1 : 1'b0;
assign HS = (~CF)?1'b1 : 1'b0;
assign LO = CF ? 1'b1 : 1'b0;
assign LS = ~(ZF == CF) ? 1'b1 : 1'b0;

always @(posedge clk ) 
begin
  if(Opcode == 5'b01011 & EQ == 1'b1)
     jmp <= 1'b1;
  else if(Opcode == 5'b01100 & NE == 1'b1)
     jmp <= 1'b1;
  else if(Opcode == 5'b01101 & HI == 1'b1)
     jmp <= 1'b1;
  else if(Opcode == 5'b01110 & HS == 1'b1)
     jmp <= 1'b1;
  else if(Opcode == 5'b01111 & LO == 1'b1)
     jmp <= 1'b1;
  else if(Opcode == 5'b10000 & LS == 1'b1)
     jmp <= 1'b1;
  else if(Opcode == 5'b10001 )
     jmp <= 1'b1;
  else 
     jmp <=1'b0;

end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
      ZF <= 1'b0;
      CF <= 1'b0;
      
  end
  else  begin
      if(CF_en == 1'b1)
         CF <= CF_in;
      if(ZF_en == 1'b1)
         ZF <= ZF_in;
         
  end
end
endmodule
