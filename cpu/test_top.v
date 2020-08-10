`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/20 10:37:41
// Design Name: 
// Module Name: test_top
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


module test_top(
    );

reg clk;
reg rst_n;
wire[15:0] M0_out,M1_out,M2_out,M3_out,M4_out,M5_out;

initial begin
    clk = 0;
    rst_n = 0;
    #20;
    rst_n = 1;
end
always #5 clk = ~clk;

minitop u_minitop(
    .clk(clk),
    .rst_n(rst_n),
    .M0_out(M0_out),
    .M1_out(M1_out),
    .M2_out(M2_out),
    .M3_out(M3_out),
    .M4_out(M4_out),
    .M5_out(M5_out)
);
endmodule
