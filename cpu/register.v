`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/16 14:25:18
// Design Name: 
// Module Name: register
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


module register(
                output reg [15:0] A_port,
                output reg [15:0] B_port,
                
                input clk,
                input rst_n,
                input [2:0] A_sel,
                input [2:0] B_sel,
                input DR_en,
                input [15:0] DR_in,
                
                input R0_en,
                input R1_en,
                input R2_en,
                input R3_en,
                input R4_en,
                input R5_en,
                input R6_en,
                input R7_en
    );

reg[15:0] R0;
    reg[15:0] R1;
    reg[15:0] R2;
    reg[15:0] R3;
    reg[15:0] R4;
    reg[15:0] R5;
    reg[15:0] R6;
    reg[15:0] R7;
    reg[15:0] DR;
    
    always@(*)
    begin
        case(A_sel)
            3'b000: A_port = R0;
            3'b001: A_port = R1;
            3'b010: A_port = R2;
            3'b011: A_port = R3;
            3'b100: A_port = R4;
            3'b101: A_port = R5;
            3'b110: A_port = R6;
            3'b111: A_port = R7;
            default: A_port = 16'b0;
        endcase
    end
    
    always@(*)
    begin
        case(B_sel)
            3'b000: B_port = R0;
            3'b001: B_port = R1;
            3'b010: B_port = R2;
            3'b011: B_port = R3;
            3'b100: B_port = R4;
            3'b101: B_port = R5;
            3'b110: B_port = R6;
            3'b111: B_port = R7;
            default: B_port = 16'b0;
        endcase
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            R0<=16'b0;
            R1<=16'b0;
            R2<=16'b0;
            R3<=16'b0;
            R4<=16'b0;
            R5<=16'b0;
            R6<=16'b0;
            R7<=16'b0;
            
        end
        else  begin
            if(R0_en)
                 R0<= DR;
            else if(R1_en)
                R1<=DR;
            else if(R2_en)
                R2<=DR;
            else if(R3_en)
                R3<=DR;
            else if(R4_en)
                R4<=DR;
            else if(R5_en)
                R5<=DR;
            else if(R6_en)
                R6<=DR;
            else if(R7_en)
                R7<=DR;
    
        end
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            DR<=16'b0;        
        end
        else  begin
            if(DR_en)
               DR<=DR_in;
            
        end
    end
endmodule
