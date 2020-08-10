`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/19 22:33:53
// Design Name: 
// Module Name: minitop
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


module minitop(
        input clk,
        input rst_n,
        
        output[31:0] M0_out,
        output[31:0] M1_out,
        output[31:0] M2_out,
        output[31:0] M3_out,
        output[31:0] M4_out,
        output[31:0] M5_out
    );
    wire Rd_used;
    wire RsA_used;
    wire RsB_used;
    wire PC_en;
    wire [1:0] PC_sel;
    wire Imem_en;
    wire MPC_en;
    wire [1:0] MPC_sel;
    wire Dmem_cs;
    wire Dmem_we;
    wire Dmem_outenab;
    wire AR_en;
    wire ALU_out_en;
    wire B_out_en;
    wire Dmem_out_en;
    wire IR_data_en;
    wire DR_en;
    wire R0_en;
    wire R1_en;
    wire R2_en;
    wire R3_en;
    wire R4_en;
    wire R5_en;
    wire R6_en;
    wire R7_en;
    wire [2:0] A_sel;
    wire [2:0] B_sel;
    wire [3:0] S;
    wire M;
    wire CF;
    wire ZF;
    wire CF_en;
    wire ZF_en;
    wire CF_in;
    wire ZF_in;
    wire [4:0] Opcode;
    wire jmp;
    reg [15:0] PC_in;
    wire [15:0] PC_branch;
    wire [15:0] PC_out;
    wire [15:0] IR;
    wire [15:0] CU_entry;
    reg [7:0] AR;
    wire [7:0] AR_in;
    wire [15:0] Next_addr;
    wire [15:0] MPC_out;
    reg [15:0] IR_data;
    wire [15:0] DBUS_out;
    wire [15:0] Dio;
    wire [15:0] data_in;
    wire [15:0] Dmem_in;
    wire [15:0] Dmem_out;
    wire [15:0] A;
    wire [15:0] B;
    wire [15:0] F;
    wire [31:0] Micro_ins;
    
pc u0_pc(
        .clk(clk),
        .rst_n(rst_n),
        .en(PC_en),
        .PC_sel(PC_sel),
        .PC_in(PC_in),
        .PC_branch(PC_branch),
        .PC_out(PC_out)
);

icache u1_icache(
        .clk(clk),
        .rst_n(rst_n),
        .en(Imem_en),
        .Addr(PC_out),
        .IR(IR)
);

decode u2_decode(
        .Opcode(IR[15:10]),
        .CU_entry(CU_entry)
);

mpc u3_mpc(
        .clk(clk),
        .rst_n(rst_n),
        .en(MPC_en),
        .MPC_sel(MPC_sel),
        .MPC_in(CU_entry),
        .Next_addr(Next_addr),
        .MPC_out(MPC_out)
);

cumem u4_cumem(
        .MPC_out(MPC_out),
        .Micro_ins(Micro_ins),
        .Next_addr(Next_addr)
);

psw u5_psw(
        .clk(clk),
        .rst_n(rst_n),
        .CF_en(CF_en),
        .ZF_en(ZF_en),
        .CF_in(CF_in),
        .ZF_in(ZF_in),
        .Opcode(Opcode),
        .jmp(jmp)
);

assign Opcode = IR[15:11];
assign CF_in = CF;
assign ZF_in = ZF;

Dmem u6_Dmem(
	.clk(clk),
    .cs(Dmem_cs),
    .we(Dmem_we),
    .Outenab(Dmem_outenab),
    .Address(AR),
    .data_in(data_in),
    .Dio(Dio),
    
    .M0_out(M0_out),
    .M1_out(M1_out),
    .M2_out(M2_out),
    .M3_out(M3_out),
    .M4_out(M4_out),
    .M5_out(M5_out)
);

assign AR_in = AR_en ? DBUS_out[7:0]: 16'hzzzz;
assign Dmem_out = Dio;
wire data_en = Dmem_cs & Dmem_we & (~Dmem_outenab);
assign data_in = data_en ? DBUS_out :16'h0;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		AR <= 8'b0;	
	end
	else  begin
		if(AR_en)
		   AR <= AR_in;
	end
end

dbus u7_dbus(
        .ALU_out(F),
        .B_out(B),
        .Dmen_out(Dmem_out),
        .IR_data(IR_data),
        .ALU_out_en(ALU_out_en),
        .B_out_en(B_out_en),
        .Dmen_out_en(Dmem_out_en),
        .IR_data_en(IR_data_en),
        .DBUS_out(DBUS_out)
);

always @( clk ) begin
	if(jmp)
	begin
		IR_data = {6'b0 , IR[9:0]};
	    PC_in =  IR_data;
	end
	else
    begin
	   IR_data = {9'b000000000,IR[6:0]};
	   PC_in = PC_out;
	end
end

register u8_register(
        .clk(clk),
        .rst_n(rst_n),
        .DR_in(DBUS_out),
        .DR_en(1'b1),
        .R0_en(R0_en),
        .R1_en(R1_en),
        .R2_en(R2_en),
        .R3_en(R3_en),
        .R4_en(R4_en),
        .R5_en(R5_en),
        .R6_en(R6_en),
        .R7_en(R7_en),
        .A_sel(A_sel),
        .B_sel(B_sel),
        .A_port(A),
        .B_port(B)
);

assign R0_en = (Rd_used & (IR[9:7] == 3'b000)) ? 1'b1 : 1'b0;
assign R1_en = (Rd_used & (IR[9:7] == 3'b001)) ? 1'b1 : 1'b0;
assign R2_en = (Rd_used & (IR[9:7] == 3'b010)) ? 1'b1 : 1'b0;
assign R3_en = (Rd_used & (IR[9:7] == 3'b011)) ? 1'b1 : 1'b0;
assign R4_en = (Rd_used & (IR[9:7] == 3'b100)) ? 1'b1 : 1'b0;
assign R5_en = (Rd_used & (IR[9:7] == 3'b101)) ? 1'b1 : 1'b0;
assign R6_en = (Rd_used & (IR[9:7] == 3'b110)) ? 1'b1 : 1'b0;
assign R7_en = (Rd_used & (IR[9:7] == 3'b111)) ? 1'b1 : 1'b0;

assign A_sel = RsA_used ? IR[9:7] : 3'b000;
assign B_sel = RsB_used ? IR[6:4] : 3'b000;

alu u9_alu(
        .A(A),
        .B(B),
        .S(S),
        .M(M),
        .C_n(1'b1),
        .F(F),
        .ZF(ZF),
        .CF(CF)
);


assign M = Micro_ins[24];
assign S = Micro_ins[23:20];
assign RsB_used = Micro_ins[19];
assign RsA_used = Micro_ins[18];
assign Rd_used = Micro_ins[17];
assign IR_data_en = Micro_ins[16];
assign Dmem_out_en = Micro_ins[15];
assign B_out_en = Micro_ins[14];
assign ALU_out_en = Micro_ins[13];
assign AR_en = Micro_ins[12];
assign Dmem_outenab = Micro_ins[11];
assign Dmem_we = Micro_ins[10];
assign Dmem_cs = Micro_ins[9];
assign ZF_en = Micro_ins[8];
assign CF_en = Micro_ins[7];
assign MPC_sel = Micro_ins[6:5];
assign MPC_en = Micro_ins[4];
assign Imem_en = Micro_ins[3];
assign PC_sel = Micro_ins[2:1];
assign PC_en = Micro_ins[0];

endmodule
