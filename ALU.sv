import alu_defs::*;

module ALU (
	input logic [31:0] a,
	input logic [31:0] b,
	input logic [3:0] alu_op,
	output logic [31:0] result
);

	// computes alu instructions
	always_comb begin
		case (alu_op)
			ADD: result = a + b;
			SUB: result = a - b;
			AND: result = a & b;
			OR: result = a | b;
			XOR: result = a ^ b;
			SLL: result = a << b[4:0];
			SRL: result = a >> b[4:0];
			SRA: result = $signed(a) >>> b [4:0];
			BEQ: result = (a == b) ? 32'd1 : 32'd0; // outputs 1 if equal and 0 otherwise
			BNE: result = (a != b) ? 32'd1 : 32'd0; // outputs 1 if not equal and 0 otherwise
			BLT: result = (a < b) ? 32'd1 : 32'd0; // outputs 1 if less than and 0 otherwise
			BGE: result = (a >= b) ? 32'd1 : 32'd0; // outputs 1 if greater than or equal to and 0 otherwise
			NOP: result = 32'd0;
			default: result = 32'd0;
		endcase
	end

endmodule
