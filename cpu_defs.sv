package cpu_defs;

	//opcodes
	parameter OPCODE_RTYPE = 7'b0110011;
	parameter OPCODE_ITYPE = 7'b0010011;
	parameter OPCODE_LOAD = 7'b0000011;
	parameter OPCODE_STORE = 7'b0100011;
	parameter OPCODE_BRANCH = 7'b1100011;
	parameter OPCODE_JAL = 7'b1101111;
	parameter OPCODE_JALR = 7'b1100111;
	parameter OPCODE_LUI = 7'b0110111;
	parameter OPCODE_AUIPC = 7'b0010111;
	parameter OPCODE_SYSTEM = 7'b1110011;
	parameter OPCODE_NOP = 7'b0000000;
	
	//function 3
	parameter FUNCT3_ADD_SUB = 3'b000;
	parameter FUNCT3_XOR = 3'b100;
	parameter FUNCT3_OR = 3'b110;
	parameter FUNCT3_AND = 3'b111;
	parameter FUNCT3_SLL = 3'b001;
	parameter FUNCT3_SRL_SRA = 3'b101;
	parameter FUNCT3_SLT = 3'b010;
	parameter FUNCT3_SLTU = 3'b011;
	parameter FUNCT3_ADDI = 3'b000;
	parameter FUNCT3_LB = 3'b000;
	parameter FUNCT3_LH = 3'b001;
	parameter FUNCT3_LW = 3'b010;
	parameter FUNCT3_LBU = 3'b100;
	parameter FUNCT3_LHU = 3'b101;
	parameter FUNCT3_SB = 3'b000;
	parameter FUNCT3_SH = 3'b001;
	parameter FUNCT3_SW = 3'b010;
	parameter FUNCT3_BEQ = 3'b000;
	parameter FUNCT3_BNE = 3'b001;
	parameter FUNCT3_BLT = 3'b100;
	parameter FUNCT3_BGE = 3'b101;
	parameter FUNCT3_BLTU = 3'b110;
	parameter FUNCT3_BGEU = 3'b111;
	
	//function 7
	parameter FUNCT7_ADD = 7'b0000000;
	parameter FUNCT7_SUB = 7'b0100000;
	parameter FUNCT7_SRL = 7'b0000000;
	parameter FUNCT7_SRA = 7'b0100000;
	parameter FUNCT7_ECALL = 12'b000000000000;
	parameter FUNCT7_EBREAK = 12'b000000000001;

	//ALU operations
	parameter ALU_ADD = 5'b00000;
	parameter ALU_SUB = 5'b00001;
	parameter ALU_AND = 5'b00010;
	parameter ALU_OR = 5'b00011;
	parameter ALU_XOR = 5'b00100; // exclusive or
	parameter ALU_SLL = 5'b00101; // shift left logical
	parameter ALU_SRL = 5'b00110; // shift right logical
	parameter ALU_SRA = 5'b00111; // shift right arithmetic
	parameter ALU_SLT = 5'b01000; // shift less than
	parameter ALU_SLTU = 5'b01001; // shift less than unsigned
	parameter ALU_BEQ = 5'b01010; // branch if equal
	parameter ALU_BNE = 5'b01011; // branch if not equal
	parameter ALU_BLT = 5'b01100; // branch if less than
	parameter ALU_BGE = 5'b01101; // branch if greater than or equal to
	parameter ALU_LUI = 5'b01110; // load upper immediate
	parameter ALU_AUIPC = 5'b01111; // add upper immediate to PC
	parameter ALU_NOP = 5'b10000; // no operation
	
	//memory size
	parameter SIZE_WORD = 2'b00;
	parameter SIZE_HALF = 2'b01;
	parameter SIZE_BYTE = 2'b10;
	
	//trap cause
	parameter TRAP_ECALL = 1'b0;
	parameter TRAP_EBREAK = 1'b1;

endpackage
