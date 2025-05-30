package alu_defs;

typedef enum logic [3:0] {

	ADD = 4'b0000,
	SUB = 4'b0001,
	AND = 4'b0010,
	OR = 4'b0011,
	XOR = 4'b0100,
	SLL = 4'b0101, // shift left logical
	SRL = 4'b0110, // shift right logical
	SRA = 4'b0111, // shift right arithmetic
	BEQ = 4'b1000, // branch if equal
	BNE = 4'b1001, // branch if not equal
	BLT = 4'b1010, // branch if less than
	BGE = 4'b1011, // branch if greater than or equal to
	NOP = 4'b1100 // no operation
	
} alu_op;
