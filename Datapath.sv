include cpu_defs::*;

module Datapath(
	input logic clock,
	input logic reset
);
	
	logic [31:0] PC;
	logic [31:0] instruction;
	logic [31:0] immediate;
	logic [31:0] ALU_result;
	logic [31:0] PC_next;
	logic [31:0] rs1, rs2;
	logic [31:0] memData;
	logic [3:0] ALU_op = ALU_NOP;
	logic regWrite;
	logic memWrite;
	logic memRead;
	logic ALU_src;
	logic isJump;
	logic isBranch;
	logic branch_taken;
	
	assign branch_taken = isBranch && (ALU_result == 1);
	assign PC_next = (isJump || branch_taken) ? ALU_result : PC + 4;
	
	ALU ALU_inst(
		.a(rs1),
		.b((ALU_src) ? immediate : rs2),
		.alu_op(ALU_op),
		.result(ALU_result)
	);
	
	ProgramCounter PC_inst(
		.clock(clock),
		.reset(reset),
		.pc_next(PC_next),
		.pc_out(PC)
	);
	
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
	
	InstructionMemory instruction_memory_inst(
		.curr_addr(PC),
		.instruction(instruction)
	);
	
	
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
	
	ImmediateGenerator immediate_inst(
		.instruction(instruction),
		.immediate(immediate)
	);
	
	DataMemory data_memory_inst(
		.clock(clock),
		.write_enable(memWrite),
		.read_enable(memRead),
		.addr(ALU_result),
		.write_data(rs2),
		.read_data(memData)
	);
	
endmodule
