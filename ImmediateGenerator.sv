import cpu_defs::*;

module ImmediateGenerator (
	input logic [31:0] instruction,
	output logic [31:0] immediate
);

	always_comb begin
		case (instruction[6:0])
		
			// I-Type
			OPCODE_ITYPE: immediate <= {{20{instruction[31]}}, instruction[31:20]};
			
			// load operation
			OPCODE_LOAD: immediate <= {{20{instruction[31]}}, instruction[31:20]};
			
			// store operation
			OPCODE_STORE: immediate <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
			
			// Branch operations
			OPCODE_BRANCH: immediate <= {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
			
			// Jump operations
			OPCODE_JAL: immediate <= {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
			
			OPCODE_JALR: immediate <= {{20{instruction[31]}}, instruction[31:20]};
			
			// U-type
			OPCODE_LUI: immediate <= {instruction[31:12], 12'b0};
			
			OPCODE_AUIPC: immediate <= {instruction[31:12], 12'b0};
			
			default: immediate = 32'd0;
		endcase
	end

endmodule
