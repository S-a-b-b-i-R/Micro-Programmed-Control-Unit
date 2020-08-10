`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/16 16:54:06
// Design Name: 
// Module Name: alu
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


module alu(
            input [15:0] A,
            input [15:0] B,
            input C_n,
            input M,
            input [3:0] S,
            
            output [15:0] F,
            output CF,
            output ZF
    );
reg[15:0] data_o_logic;
    reg[16:0] data_o_arith;
    reg[16:0] data_sub_tmp;
    wire[15:0] C_n_arith;
    
    assign F = M ? data_o_logic:
                   data_o_arith[15:0];
    assign CF = M ? 1'b1:
                    (~data_o_arith[16]);
    assign ZF = (|data_o_arith[15:0]) ? 1'b0:
                                        1'b1;
    assign C_n_arith = {15'b0,(~C_n)};
    
    always@(A,B,S,M)
    begin
        case(S)
            4'b0000: data_o_logic = ~A;
            4'b0001: data_o_logic = ~(A|B);
            4'b0010: data_o_logic = (~A)&B;
            4'b0011: data_o_logic = 16'b0;
            4'b0100: data_o_logic = ~(A&B);
            4'b0101: data_o_logic = ~B;
            4'b0110: data_o_logic = A^B;
            4'b0111: data_o_logic = A&(~B);
            4'b1000: data_o_logic = (~A)|B;
            4'b1001: data_o_logic = A^~B;
            4'b1010: data_o_logic = B;
            4'b1011: data_o_logic = A&B;
            4'b1100: data_o_logic = 16'b0000_0000_0000_0001;
            4'b1101: data_o_logic = A|(~B);
            4'b1110: data_o_logic = A|B;
            4'b1111: data_o_logic = A;
            default: data_o_logic = 16'b0;
        endcase
    end
    
    always@(A,B,S,M,C_n_arith)
    begin
        case(S)
            4'b0000: data_o_arith = {1'b0,A} + C_n_arith;
            4'b0001: data_o_arith = {1'b0,A|B} + C_n_arith;
            4'b0010: data_o_arith = {1'b0,A|(~B)} + C_n_arith;
            4'b0011: data_o_arith = 17'b0_1111_1111_1111_1111 + C_n_arith;
            4'b0100: data_o_arith = {1'b0,A}+{1'b0,A|(~B)}+C_n_arith;
            4'b0101: data_o_arith = {1'b0,A|B}+{1'b0,A|(~B)}+C_n_arith;
            4'b0110: begin
                     data_sub_tmp = {1'b0,A}-{1'b0,B}+C_n_arith;
                     data_o_arith = {(~data_sub_tmp[16]),data_sub_tmp[15:0]};
                     end
            4'b0111: begin
                     data_sub_tmp = {1'b0,A|(~B)}-1+C_n_arith;
                     data_o_arith = {(~data_sub_tmp[16]),data_sub_tmp[15:0]};
                     end
            4'b1000: data_o_arith = {1'b0,A}+1 +C_n_arith;
            4'b1001: data_o_arith = {1'b0,A}+{1'b0,B}+C_n_arith;
            4'b1010: data_o_arith = {1'b0,A|(~B)} +{1'b0,A&B}+C_n_arith;
            4'b1011: begin
                     data_sub_tmp = {1'b0,A&B}-1+C_n_arith;
                     data_o_arith = {(~data_sub_tmp[16]),data_sub_tmp[15:0]};
                     end
            4'b1100: data_o_arith = {1'b0,A}+{1'b0,A}+C_n_arith;
            4'b1101: data_o_arith = {1'b0,A|B}+{1'b0,A}+C_n_arith;
            4'b1110: data_o_arith = {1'b0,A|(~B)}+{1'b0,A}+C_n_arith;
            4'b1111: begin
                     data_sub_tmp = {1'b0,A}-1'b1+C_n_arith;
                     data_o_arith = {(~data_sub_tmp[16]),data_sub_tmp[15:0]};
                     end
            default: data_o_arith = 17'b0;
        endcase
          
    end
endmodule
