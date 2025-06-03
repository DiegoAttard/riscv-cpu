module InstructionDecoder (
	input logic [31:0] instruction,
	output logic [5:0] op,
	output logic [4:0] rs,
	output logic [4:0] rt,
	output logic [4:0] rd,
	output logic [4:0] shamt,
	output logic [5:0] funct,
	output logic [15:0] imm,
	output logic [25:0] addr
);
	
	// R-Format (op, rs, rt, rd, shamt, funct)
	// I-Format (op, rs, rt, immediate)
	// J-Format (op, address)
	assign op = instruction[31:26];
	assign rs = instruction[25:21];
	assign rt = instruction[20:16];
	assign rd = instruction[15:11];
	assign shamt = instruction[10:6];
	assign funct = instruction[5:0];
	assign imm = instruction[15:0];
	assign addr = instruction[25:0];

endmodule
