import cpu_defs::*;

module Datapath(
	input logic clock,
	input logic reset
);
	
	// internal signal declarations
	logic [31:0] PC;
	logic [31:0] instruction;
	logic [31:0] immediate;
	logic [31:0] ALU_result;
	logic [31:0] PC_next;
	logic [31:0] rs1, rs2;
	logic [31:0] memData;
	logic [31:0] alu_input_a;
	logic [31:0] alu_input_b;
	logic [3:0] ALU_op = ALU_NOP;
	logic regWrite;
	logic memWrite;
	logic memRead;
	logic ALU_src;
	logic isJump;
	logic isBranch;
	logic branch_taken;
	
	// checking if a branch is taken
	assign branch_taken = isBranch && (ALU_result == 1);
	
	// computing next pc value
	assign PC_next = (isJump || branch_taken) ? ALU_result : PC + 4;

	// selecting alu inputs
	assign alu_input_a = (isJump) ? PC : rs1;
	assign alu_input_b = (ALU_src) ? immediate : rs2;
	
	// using ALU module to perform arithmetic/logical operations
	ALU ALU_inst(
		.a(alu_input_a),
		.b(alu_input_b),
		.alu_op(ALU_op),
		.result(ALU_result)
	);
	
	// using program counter module to hold the address of the current instruction
	ProgramCounter PC_inst(
		.clock(clock),
		.reset(reset),
		.pc_next(PC_next),
		.pc_out(PC)
	);
	
	// using register file module to read and write from registers
	RegisterFile register_inst(
		.clock(clock),
		.reset(reset),
		.regWrite(regWrite),
		.readAddr1(instruction[19:15]),
		.readAddr2(instruction[24:20]),
		.writeAddr(instruction[11:7]),
		.writeData((isJump) ? PC + 4 : ((memRead) ? memData : ALU_result)),
		.readData1(rs1),
		.readData2(rs2)
	);
	
	// using instruction memory module to fetch instructions from memory
	InstructionMemory instruction_memory_inst(
		.curr_addr(PC),
		.instruction(instruction)
	);
	
	// using control unit module to decode instructions and generate appropriate control signals
	ControlUnit control_unit_inst(
		.instruction(instruction),
		.regWrite(regWrite),
		.memWrite(memWrite),
		.memRead(memRead),
		.ALU_src(ALU_src),
		.isJump(isJump),
		.isBranch(isBranch),
		.ALU_op(ALU_op)
	);
	
	// using immediate generator module to extract immediate values from instructions
	ImmediateGenerator immediate_inst(
		.instruction(instruction),
		.immediate(immediate)
	);
	
	// using data module for load and store memory instructions
	DataMemory data_memory_inst(
		.clock(clock),
		.write_enable(memWrite),
		.read_enable(memRead),
		.addr(ALU_result),
		.write_data(rs2),
		.read_data(memData)
	);
	
endmodule
