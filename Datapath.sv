import cpu_defs::*;

module Datapath(
	input logic clock,
	input logic reset
);
	
	// internal signal declarations
	logic [31:0] PC;
	logic [31:0] PC_ID;
	logic [31:0] PC_EX;
	logic [31:0] PC_MEM;
	logic [31:0] PC_WB;
	logic [31:0] instruction_IF;
	logic [31:0] instruction_ID;
	logic [31:0] immediate;
	logic [31:0] immediate_EX;
	logic [31:0] ALU_result;
	logic [31:0] ALU_result_MEM;
	logic [31:0] ALU_result_WB;
	logic [31:0] PC_next;
	logic [31:0] rs1;
	logic [31:0] rs1_EX;
	logic [31:0] rs2;
	logic [31:0] rs2_EX;
	logic [31:0] rs2_MEM;
	logic [31:0] memData;
	logic [31:0] memData_WB;
	logic [31:0] alu_input_a;
	logic [31:0] alu_input_b;
	logic [31:0] branch_target;
	logic [4:0] rs1_addr_EX;
	logic [4:0] rs2_addr_EX;
	logic [4:0] rd_addr_EX;
	logic [4:0] rd_addr_MEM;
	logic [4:0] rd_addr_WB;
	logic [4:0] ALU_op;
	logic [4:0] ALU_op_EX;
	logic [1:0] memSize;
	logic [1:0] memSize_EX;
	logic [1:0] memSize_MEM;
	logic [1:0] memSize_WB;
	logic [1:0] trapCause;
	logic regWrite;
	logic regWrite_EX;
	logic regWrite_MEM;
	logic regWrite_WB;
	logic memWrite;
	logic memWrite_EX;
	logic memWrite_MEM;
	logic memRead;
	logic memRead_EX;
	logic memRead_MEM;
	logic memRead_WB;
	logic ALU_src;
	logic ALU_src_EX;
	logic isBranch;
	logic isBranch_EX;
	logic branch_taken;
	logic memUnsigned;
	logic memUnsigned_EX;
	logic memUnsigned_MEM;
	logic memUnsigned_WB;
	logic isEcall;
	logic isEcall_EX;
	logic isEbreak;
	logic isEbreak_EX;
	logic isJump;
	logic isJump_EX;
	logic isJump_MEM;
	logic isJump_WB;
	logic adjustPC;
	logic adjustPC_EX;
	logic uType;
	logic usePC;
	logic usePC_EX;
	
	// checking if a branch is taken
	assign branch_taken = isBranch_EX && (ALU_result == 1);
	
	// computing branch target
	assign branch_target = PC_EX + immediate_EX;
		
	// computing next pc value
	always_comb begin
		trapCause = 2'b0;
		if (isEcall_EX) begin
			trapCause = TRAP_ECALL;
			PC_next = PC;
		end else if (isEbreak_EX) begin
			trapCause = TRAP_EBREAK;
			PC_next = PC;
		end else
			PC_next = isJump_EX ? ALU_result : branch_taken ? branch_target : PC + 4;
	end
	
	// checking whether PC or regesiter is used for alu input a
	assign usePC = instruction_ID[6:0] == OPCODE_JAL;
	
	// selecting alu inputs
	assign alu_input_a = (usePC_EX || adjustPC_EX) ? PC_EX : rs1_EX;
	assign alu_input_b = (ALU_src_EX) ? immediate_EX : rs2_EX;
	
	
	
	// using program counter module to hold the address of the current instruction
	ProgramCounter PC_inst(
		.clock(clock),
		.reset(reset),
		.pc_next(PC_next),
		.pc_out(PC)
	);
	
	// using instruction memory module to fetch instructions from memory
	InstructionMemory instruction_memory_inst(
		.curr_addr(PC),
		.instruction(instruction_IF)
	);
	
	// using IF_ID register module to hold intermmediate values for this stage
	IF_ID_Register IF_ID_inst(
		.clock(clock),
		.reset(reset),
		.PC_in(PC),
		.instruction_in(instruction_IF),
		.PC_out(PC_ID),
		.instruction_out(instruction_ID)
	);
	
	// using control unit module to decode instructions and generate appropriate control signals
	ControlUnit control_unit_inst(
		.instruction(instruction_ID),
		.regWrite(regWrite),
		.memWrite(memWrite),
		.memRead(memRead),
		.ALU_src(ALU_src),
		.isBranch(isBranch),
		.memUnsigned(memUnsigned),
		.isEcall(isEcall),
		.isEbreak(isEbreak),
		.isJump(isJump),
		.adjustPC(adjustPC),
		.uType(uType),
		.memSize(memSize),
		.ALU_op(ALU_op)
	);
	
	// using register file module to read and write from registers
	RegisterFile register_inst(
		.clock(clock),
		.reset(reset),
		.regWrite(regWrite_WB),
		.memUnsigned(memUnsigned_WB),
		.memSize(memSize_WB),
		.readAddr1(uType ? 5'd0 : instruction_ID[19:15]),
		.readAddr2(instruction_ID[24:20]),
		.writeAddr(rd_addr_WB),
		.writeData((isJump_WB) ? PC_WB + 4 : ((memRead_WB) ? memData_WB : ALU_result_WB)),
		.readData1(rs1),
		.readData2(rs2)
	);
	
	// using immediate generator module to extract immediate values from instructions
	ImmediateGenerator immediate_inst(
		.instruction(instruction_ID),
		.immediate(immediate)
	);
	
	// using ID_EX register module to hold intermmediate values for this stage
	ID_EX_Register ID_EX_inst (
		.clock(clock),
		.reset(reset),
		.PC_in(PC_ID),
		.rs1_data_in(rs1),
		.rs2_data_in(rs2),
		.immediate_in(immediate),
		.rs1_addr_in(instruction_ID[19:15]),
		.rs2_addr_in(instruction_ID[24:20]),
		.rd_addr_in(instruction_ID[11:7]),
		.regWrite_in(regWrite),
		.memWrite_in(memWrite),
		.memRead_in(memRead),
		.ALU_src_in(ALU_src),
		.isBranch_in(isBranch),
		.memUnsigned_in(memUnsigned),
		.isEcall_in(isEcall),
		.isEbreak_in(isEbreak),
		.isJump_in(isJump),
		.adjustPC_in(adjustPC),
		.usePC_in(usePC),
		.memSize_in(memSize),
		.ALU_op_in(ALU_op),
		.PC_out(PC_EX),
		.rs1_data_out(rs1_EX),
		.rs2_data_out(rs2_EX),
		.immediate_out(immediate_EX),
		.rs1_addr_out(rs1_addr_EX),
		.rs2_addr_out(rs2_addr_EX),
		.rd_addr_out(rd_addr_EX),
		.regWrite_out(regWrite_EX),
		.memWrite_out(memWrite_EX),
		.memRead_out(memRead_EX),
		.ALU_src_out(ALU_src_EX),
		.isBranch_out(isBranch_EX),
		.memUnsigned_out(memUnsigned_EX),
		.isEcall_out(isEcall_EX),
		.isEbreak_out(isEbreak_EX),
		.isJump_out(isJump_EX),
		.adjustPC_out(adjustPC_EX),
		.usePC_out(usePC_EX),
		.memSize_out(memSize_EX),
		.ALU_op_out(ALU_op_EX)
	);
	
	// using ALU module to perform arithmetic/logical operations
	ALU ALU_inst(
		.a(alu_input_a),
		.b(alu_input_b),
		.alu_op(ALU_op_EX),
		.memUnsigned(memUnsigned_EX),
		.result(ALU_result)
	);
	
	// using EX_MEM register module to hold intermmediate values for this stage
	EX_MEM_Register EX_MEM_inst (
		.clock(clock),
		.reset(reset),
		.PC_in(PC_EX),
		.ALU_result_in(ALU_result),
		.rs2_data_in(rs2_EX),
		.rd_addr_in(rd_addr_EX),
		.regWrite_in(regWrite_EX),
		.memWrite_in(memWrite_EX),
		.memRead_in(memRead_EX),
		.memUnsigned_in(memUnsigned_EX),
		.isJump_in(isJump_EX),
		.memSize_in(memSize_EX),
		.PC_out(PC_MEM),
		.ALU_result_out(ALU_result_MEM),
		.rs2_data_out(rs2_MEM),
		.rd_addr_out(rd_addr_MEM),
		.regWrite_out(regWrite_MEM),
		.memWrite_out(memWrite_MEM),
		.memRead_out(memRead_MEM),
		.memUnsigned_out(memUnsigned_MEM),
		.isJump_out(isJump_MEM),
		.memSize_out(memSize_MEM)
	);
	
	// using data module for load and store memory instructions
	DataMemory data_memory_inst(
		.clock(clock),
		.write_enable(memWrite_MEM),
		.read_enable(memRead_MEM),
		.memSize(memSize_MEM),
		.addr(ALU_result_MEM),
		.write_data(rs2_MEM),
		.read_data(memData)
	);
	
	// using MEM_WB register module to hold intermmediate values for this stage
	MEM_WB_Register MEM_WB_inst (
		.clock(clock),
		.reset(reset),
		.PC_in(PC_MEM),
		.ALU_result_in(ALU_result_MEM),
		.memData_in(memData),
		.rd_addr_in(rd_addr_MEM),
		.regWrite_in(regWrite_MEM),
		.memRead_in(memRead_MEM),
		.isJump_in(isJump_MEM),
		.memUnsigned_in(memUnsigned_MEM),
		.memSize_in(memSize_MEM),
		.PC_out(PC_WB),
		.ALU_result_out(ALU_result_WB),
		.memData_out(memData_WB),
		.rd_addr_out(rd_addr_WB),
		.regWrite_out(regWrite_WB),
		.memRead_out(memRead_WB),
		.isJump_out(isJump_WB),
		.memUnsigned_out(memUnsigned_WB),
		.memSize_out(memSize_WB)
	);
	
endmodule
