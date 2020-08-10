`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/18 19:58:37
// Design Name: 
// Module Name: pc
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


module pc(
input clk,
input rst_n,
input en,
input[1:0] PC_sel,
input[15:0] PC_in,
input[15:0] PC_branch,
output[15:0] PC_out
  );

reg[15:0] PC;
assign PC_out = PC;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) 
      PC <= 16'b0;
      
  else begin
      if(en) begin
          if(PC_sel == 2'b11)
             PC <= PC_in;
          else if(PC_sel == 2'b10)
             PC <= PC + PC_branch;
          else 
             PC <= PC + 1;
      end      
  end
end
endmodule
