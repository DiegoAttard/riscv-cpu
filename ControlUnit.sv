include alu_defs::*;

module ControlUnit(
	input logic [5:0] op,
	output logic RegWrite, MemWrite, MemRead, ALU_src,
	output logic [3:0] ALU_op
);

	always_comb begin
		
		//setting default values
		RegWrite = 0;
		MemWrite = 0;
		MemRead = 0;
		ALU_src = 0;
		ALU_op = 0;
		
		case(op)
			6'b000000: begin //add
				RegWrite = 1;
				ALU_op = ADD;
			end
			6'b000001: begin //addi
				RegWrite = 1;
				ALU_src = 1;
				ALU_op = ADD;
			end
			6'b000010: begin //sub
				RegWrite = 1;
				ALU_op = SUB;
			end
			6'b000011: begin //and
				RegWrite = 1;
				ALU_op = AND;
			end
			6'b000100: begin //andi
				RegWrite = 1;
				ALU_src = 1;
				ALU_op = AND;
			end
			6'b000101: begin //or
				RegWrite = 1;
				ALU_op = OR;
			end
			6'b000110: begin //ori
				RegWrite = 1;
				ALU_src = 1;
				ALU_op = OR;
			end
			6'b000111: begin //xor
				RegWrite = 1;
				ALU_op = XOR;
			end
			6'b001000: begin //sll
				RegWrite = 1;
				ALU_op = SLL;
			end
			6'b001001: begin //srl
				RegWrite = 1;
				ALU_op = SRL;
			end
			6'b001010: begin //sra
				RegWrite = 1;
				ALU_op = SRA;
			end
			6'b001011: begin //ld
				RegWrite = 1;
				MemRead = 1;
				ALU_src = 1;
				ALU_op = ADD;
			end
			6'b001100: begin //stw
				MemWrite = 1;
				ALU_src = 1;
				ALU_op = ADD;
			end
			6'b001101: begin //beq
				RegWrite = 1;
				ALU_op = BEQ;
			end
			6'b001110: begin //bne
				RegWrite = 1;
				ALU_op = BNE;
			end
			6'b001111: begin //blt
				RegWrite = 1;
				ALU_op = BLT;
			end
			6'b010000: begin //bge
				RegWrite = 1;
				ALU_op = BGE;
			end
			6'b010001: begin //jal
				RegWrite = 1;
				ALU_op = ADD;
			end
			6'b010010: begin //jalr
				RegWrite = 1;
				ALU_op = ADD;
			end
			6'b010011: begin //nop
				ALU_op = NOP;
			end
		endcase
	end

endmodule
