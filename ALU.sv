import cpu_defs::*;

module ALU (
	input logic [31:0] a,
	input logic [31:0] b,
	input logic [3:0] alu_op,
	output logic [31:0] result
);

	// computes alu instructions
	always_comb begin
		case (alu_op)
			ALU_ADD: result = a + b;
			ALU_SUB: result = a - b;
			ALU_AND: result = a & b;
			ALU_OR: result = a | b;
			ALU_XOR: result = a ^ b;
			ALU_SLL: result = a << b[4:0];
			ALU_SRL: result = a >> b[4:0];
			ALU_SRA: result = $signed(a) >>> b [4:0];
			ALU_BEQ: result = (a == b) ? 32'd1 : 32'd0; // outputs 1 if equal and 0 otherwise
			ALU_BNE: result = (a != b) ? 32'd1 : 32'd0; // outputs 1 if not equal and 0 otherwise
			ALU_BLT: result = (a < b) ? 32'd1 : 32'd0; // outputs 1 if less than and 0 otherwise
			ALU_BGE: result = (a >= b) ? 32'd1 : 32'd0; // outputs 1 if greater than or equal to and 0 otherwise
			ALU_NOP: result = 32'd0;
			default: result = 32'd0;
		endcase
	end

endmodule
