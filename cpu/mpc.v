`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/19 09:16:36
// Design Name: 
// Module Name: mpc
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


module mpc(
    input clk,
    input rst_n,
    input en,
    input[1:0] MPC_sel,
    input[15:0] MPC_in,
    input[15:0] Next_addr,
    output[15:0] MPC_out
  );
reg[15:0] MPC;

assign MPC_out = MPC;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n)
      MPC <= 16'b0;
  else begin
      if(en) begin
          if(MPC_sel == 2'b11)
             MPC <= MPC_in;
          else if(MPC_sel == 2'b10)
             MPC <= Next_addr;
          else begin
              MPC <= 16'b0;
              
          end
      end
  end
end
endmodule
