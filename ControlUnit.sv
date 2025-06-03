include alu_defs::*;

module ControlUnit(
	input logic [5:0] op,
	output logic regWrite, memWrite, memRead, ALU_src,
	output logic [3:0] ALU_op
);

	always_comb begin
		
		//setting default values
		regWrite = 0;
		memWrite = 0;
		memRead = 0;
		ALU_src = 0;
		ALU_op = 0;
		
		case(op)
			6'b000000: begin //add
				regWrite = 1;
				ALU_op = ADD;
			end
			6'b000001: begin //addi
				regWrite = 1;
				ALU_src = 1;
				ALU_op = ADD;
			end
			6'b000010: begin //sub
				regWrite = 1;
				ALU_op = SUB;
			end
			6'b000011: begin //and
				regWrite = 1;
				ALU_op = AND;
			end
			6'b000100: begin //andi
				regWrite = 1;
				ALU_src = 1;
				ALU_op = AND;
			end
			6'b000101: begin //or
				regWrite = 1;
				ALU_op = OR;
			end
			6'b000110: begin //ori
				regWrite = 1;
				ALU_src = 1;
				ALU_op = OR;
			end
			6'b000111: begin //xor
				regWrite = 1;
				ALU_op = XOR;
			end
			6'b001000: begin //sll
				regWrite = 1;
				ALU_op = SLL;
			end
			6'b001001: begin //srl
				regWrite = 1;
				ALU_op = SRL;
			end
			6'b001010: begin //sra
				regWrite = 1;
				ALU_op = SRA;
			end
			6'b001011: begin //ld
				regWrite = 1;
				memRead = 1;
				ALU_src = 1;
				ALU_op = ADD;
			end
			6'b001100: begin //stw
				memWrite = 1;
				ALU_src = 1;
				ALU_op = ADD;
			end
			6'b001101: begin //beq
				regWrite = 1;
				ALU_op = BEQ;
			end
			6'b001110: begin //bne
				regWrite = 1;
				ALU_op = BNE;
			end
			6'b001111: begin //blt
				regWrite = 1;
				ALU_op = BLT;
			end
			6'b010000: begin //bge
				regWrite = 1;
				ALU_op = BGE;
			end
			6'b010001: begin //jal
				regWrite = 1;
				ALU_op = ADD;
			end
			6'b010010: begin //jalr
				regWrite = 1;
				ALU_op = ADD;
			end
			6'b010011: begin //nop
				ALU_op = NOP;
			end
		endcase
	end

endmodule
