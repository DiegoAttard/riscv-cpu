include cpu_defs::*;

module ImmediateGenerator (
	input logic [31:0] instruction,
	output logic [31:0] immediate
);

	always_comb begin
		case (instruction[6:0])
		
			// I-Type
			OPCODE_ITYPE: begin
				immediate <= {{20{instruction[31]}}, instruction[31:20]};
			end
			
			// load operation
			OPCODE_LOAD: begin
				immediate <= {{20{instruction[31]}}, instruction[31:20]};
			end
			
			// store operation
			OPCODE_STORE: begin
				immediate <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
			end
			
			// B-Type
			OPCODE_BTYPE: begin
				immediate <= {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
			end
			
			// Jump operations
			OPCODE_JAL: begin
				immediate <= {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
			end
			OPCODE_JALR: begin
				immediate <= {{20{instruction[31]}}, instruction[31:20]};
			end
			
			default: immediate = 32'd0;
		endcase
	end

endmodule
