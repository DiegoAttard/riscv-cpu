import cpu_defs::*;

module ControlUnit(
	input logic [31:0] instruction,
	output logic regWrite, memWrite, memRead, ALU_src, isJump, isBranch,
	output logic [3:0] ALU_op
);


	//instruction formats can be seen in detail in reference document
	//reference document is named "RISCV_Reference.pdf"
	
	always_comb begin
		
		//setting default values
		regWrite = 0;
		memWrite = 0;
		memRead = 0;
		ALU_src = 0;
		ALU_op = 0;
		isJump = 0;
		isBranch = 0;
		
		case(instruction[6:0])
		
			// R-Type
			OPCODE_RTYPE: begin
				case(instruction[14:12])
					
					//add or sub operation
					FUNCT3_ADD_SUB: begin
						case(instruction[31:25])
							FUNCT7_ADD: begin
								regWrite = 1;
								ALU_op = ALU_ADD;
							end
							FUNCT7_SUB: begin
								regWrite = 1;
								ALU_op = ALU_SUB;
							end
						endcase
					end
					
					//xor operation
					FUNCT3_XOR: begin
						regWrite = 1;
						ALU_op = ALU_XOR;
					end
					
					//or operation
					FUNCT3_OR: begin
						regWrite = 1;
						ALU_op = ALU_OR;
					end
					
					//and operation
					FUNCT3_AND: begin
						regWrite = 1;
						ALU_op = ALU_AND;
					end
					
					//shift left logical operation
					FUNCT3_SLL: begin
						regWrite = 1;
						ALU_op = ALU_SLL;
					end
					
					//shift right operations (srl/sra)
					FUNCT3_SRL_SRA: begin
						case(instruction[31:25])
							FUNCT7_SRL: begin
								regWrite = 1;
								ALU_op = ALU_SRL;
							end
							FUNCT7_SRA: begin
								regWrite = 1;
								ALU_op = ALU_SRA;
							end
						endcase
					end
				endcase
			end
			
			
			// I_Type
			OPCODE_ITYPE: begin
				case(instruction[14:12])
					
					//addi operation
					FUNCT3_ADDI: begin
						regWrite = 1;
						ALU_src = 1;
						ALU_op = ALU_ADD;
					end
					
					//xori operation
					FUNCT3_XOR: begin
						regWrite = 1;
						ALU_src = 1;
						ALU_op = ALU_XOR;
					end
					
					//ori operation
					FUNCT3_OR: begin
						regWrite = 1;
						ALU_src = 1;
						ALU_op = ALU_OR;
					end
					
					//andi operation
					FUNCT3_AND: begin
						regWrite = 1;
						ALU_src = 1;
						ALU_op = ALU_AND;
					end
					
					//shift left logical immediate operation
					FUNCT3_SLL: begin
						regWrite = 1;
						ALU_src = 1;
						ALU_op = ALU_SLL;
					end
					
					//shift right immediate operations (srli/srai)
					FUNCT3_SRL_SRA: begin
						case(instruction[31:25])
							FUNCT7_SRL: begin
								regWrite = 1;
								ALU_src = 1;
								ALU_op = ALU_SRL;
							end
							FUNCT7_SRA: begin
								regWrite = 1;
								ALU_src = 1;
								ALU_op = ALU_SRA;
							end
						endcase
					end
					
				endcase
			end
			
			//load operation
			OPCODE_LOAD: begin
				regWrite = 1;
				memRead = 1;
				ALU_src = 1;
				ALU_op = ALU_ADD;
			end
			
			//store operation
			OPCODE_STORE: begin
				memWrite = 1;
				ALU_src = 1;
				ALU_op = ALU_ADD;
			end
			
			// B-Type
			OPCODE_BTYPE: begin
			
				isBranch = 1;
				
				case(instruction[14:12])
				
					//branch if equal operation
					FUNCT3_BEQ: begin
						ALU_op = ALU_BEQ;
					end
					
					//branch if not equal operation
					FUNCT3_BNE: begin
						ALU_op = ALU_BNE;
					end
					
					//branch if less than operation
					FUNCT3_BLT: begin
						ALU_op = ALU_BLT;
					end
					
					//branch if greater than operation
					FUNCT3_BGE: begin
						ALU_op = ALU_BGE;
					end
				endcase
			end
			
			//jump and link operation
			OPCODE_JAL: begin
				regWrite = 1;
				isJump = 1;
				ALU_op = ALU_ADD;
			end
			
			//jump and link reg operation
			OPCODE_JALR: begin
				regWrite = 1;
				isJump = 1;
				ALU_op = ALU_ADD;
			end
			
			//no operation
			OPCODE_NOP: begin
				ALU_op = ALU_NOP;
			end
		endcase
	end

endmodule
