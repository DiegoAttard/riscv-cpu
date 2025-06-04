package cpu_defs;

	//opcodes
	parameter OPCODE_RTYPE = 7'b0110011;
	parameter OPCODE_ITYPE = 7'b0010011;
	parameter OPCODE_LOAD = 7'b0000011;
	parameter OPCODE_STORE = 7'b0100011;
	parameter OPCODE_BTYPE = 7'b1100011;
	parameter OPCODE_JAL = 7'b1101111;
	parameter OPCODE_JALR = 7'b1100111;
	parameter OPCODE_NOP = 7'b0000000;
	
	//function 3
	parameter FUNCT3_ADD_SUB = 3'b000;
	parameter FUNCT3_XOR = 3'b100;
	parameter FUNCT3_OR = 3'b110;
	parameter FUNCT3_AND = 3'b111;
	parameter FUNCT3_SLL = 3'b001;
	parameter FUNCT3_SRL_SRA = 3'b101;
	parameter FUNCT3_ADDI = 3'b000;
	parameter FUNCT3_BEQ = 3'b000;
	parameter FUNCT3_BNE = 3'b001;
	parameter FUNCT3_BLT = 3'b100;
	parameter FUNCT3_BGE = 3'b101;
	
	//function 7
	parameter FUNCT7_ADD = 7'b0000000;
	parameter FUNCT7_SUB = 7'b0100000;
	parameter FUNCT7_SRL = 7'b0000000;
	parameter FUNCT7_SRA = 7'b0100000;

	//ALU operations
	parameter ALU_ADD = 4'b0000;
	parameter ALU_SUB = 4'b0001;
	parameter ALU_AND = 4'b0010;
	parameter ALU_OR = 4'b0011;
	parameter ALU_XOR = 4'b0100;
	parameter ALU_SLL = 4'b0101; // shift left logical
	parameter ALU_SRL = 4'b0110; // shift right logical
	parameter ALU_SRA = 4'b0111; // shift right arithmetic
	parameter ALU_BEQ = 4'b1000; // branch if equal
	parameter ALU_BNE = 4'b1001; // branch if not equal
	parameter ALU_BLT = 4'b1010; // branch if less than
	parameter ALU_BGE = 4'b1011; // branch if greater than or equal to
	parameter ALU_NOP = 4'b1100; // no operation

endpackage
