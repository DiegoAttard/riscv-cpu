import cpu_defs::*;

module ControlUnit(
	input logic [31:0] instruction,
	output logic regWrite, memWrite, memRead, ALU_src, isBranch, memUnsigned, isEcall, isEbreak, adjustPC, uType,
	output logic [1:0] memSize,
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
		memSize = 0;
		memUnsigned = 0;
		isBranch = 0;
		isEcall = 0;
		isEbreak = 0;
		adjustPC = 0;
		uType = 0;
		
		case(instruction[6:0])
		
			// R-Type
			OPCODE_RTYPE: begin
			
				//setting control signals for all the R-Type instructions
				regWrite = 1;
				memSize = SIZE_WORD;
			
				case(instruction[14:12])
					
					//add or sub operation
					FUNCT3_ADD_SUB: begin
						case(instruction[31:25])
							FUNCT7_ADD: begin
								ALU_op = ALU_ADD;
								//need to pass memory size for all add operations
								memSize = SIZE_WORD;
							end
							FUNCT7_SUB: begin
								ALU_op = ALU_SUB;
							end
						endcase
					end
					
					//xor operation
					FUNCT3_XOR: ALU_op = ALU_XOR;
					
					//or operation
					FUNCT3_OR: ALU_op = ALU_OR;
					
					//and operation
					FUNCT3_AND: ALU_op = ALU_AND;
					
					//shift left logical operation
					FUNCT3_SLL: ALU_op = ALU_SLL;
					
					//shift right operations (srl/sra)
					FUNCT3_SRL_SRA: begin
						case(instruction[31:25])
							FUNCT7_SRL: begin
								ALU_op = ALU_SRL;
							end
							FUNCT7_SRA: begin
								ALU_op = ALU_SRA;
							end
						endcase
					end
					
					//set less than operation
					FUNCT3_SLT: ALU_op = ALU_SLT;
					
					//set less than unsigned operation
					FUNCT3_SLTU: begin
						ALU_op = ALU_SLT;
						memUnsigned = 1;
					end
					
				endcase
			end
			
			
			// I-Type
			OPCODE_ITYPE: begin
			
				//setting control signals for all the I-Type instructions
				regWrite = 1;
				ALU_src = 1;
			
				case(instruction[14:12])
					
					//addi operation
					FUNCT3_ADDI: begin
						ALU_op = ALU_ADD;
						//need to pass memory size for all add operations
						memSize = SIZE_WORD;
					end
					
					//xori operation
					FUNCT3_XOR: ALU_op = ALU_XOR;
					
					//ori operation
					FUNCT3_OR: ALU_op = ALU_OR;
					
					//andi operation
					FUNCT3_AND: ALU_op = ALU_AND;
					
					//shift left logical immediate operation
					FUNCT3_SLL: ALU_op = ALU_SLL;
					
					//shift right immediate operations (srli/srai)
					FUNCT3_SRL_SRA: begin
						case(instruction[31:25])
							FUNCT7_SRL: begin
								ALU_op = ALU_SRL;
							end
							FUNCT7_SRA: begin
								ALU_op = ALU_SRA;
							end
						endcase
					end
					
					// set less than immediate operation
					FUNCT3_SLT: ALU_op = ALU_SLT;
					
					//set less than immediate unsigned operation
					FUNCT3_SLTU: begin
						ALU_op = ALU_SLT;
						memUnsigned = 1;
					end
					
				endcase
			end
			
			//load operation
			OPCODE_LOAD: begin
			
				//setting control signals for all the load instructions
				regWrite = 1;
				memRead = 1;
				ALU_src = 1;
				ALU_op = ALU_ADD;
			
				case(instruction[14:12])
				
					//load byte operation
					FUNCT3_LB: memSize = SIZE_BYTE;
					
					//load half operation
					FUNCT3_LH: memSize = SIZE_HALF;

					
					//load word operation
					FUNCT3_LW: memSize = SIZE_WORD;
					
					//load byte unsigned operation
					FUNCT3_LBU: begin
						memSize = SIZE_BYTE;
						memUnsigned = 1;
					end
					
					//load half unsigned operation
					FUNCT3_LHU: begin
						memSize = SIZE_HALF;
						memUnsigned = 1;
					end
				endcase
			end
			
			//store operation
			OPCODE_STORE: begin
			
				//setting control signals for all the store instructions
				memWrite = 1;
				ALU_src = 1;
				ALU_op = ALU_ADD;
				
				case(instruction[14:12])
				
					//store byte operation
					FUNCT3_SB: memSize = SIZE_BYTE;
					
					//store half operation
					FUNCT3_SH: memSize = SIZE_HALF;
					
					//store word operation
					FUNCT3_SW: memSize = SIZE_WORD;
				endcase
			end
			
			// Branch Type
			OPCODE_BRANCH: begin
			
				isBranch = 1;
				
				case(instruction[14:12])
				
					//branch if equal operation
					FUNCT3_BEQ: ALU_op = ALU_BEQ;
					
					//branch if not equal operation
					FUNCT3_BNE: ALU_op = ALU_BNE;
					
					//branch if less than operation
					FUNCT3_BLT: ALU_op = ALU_BLT;
					
					//branch if greater than or equal to operation
					FUNCT3_BGE: ALU_op = ALU_BGE;
					
					//branch if less than unsigned operation
					FUNCT3_BLTU: begin
						ALU_op = ALU_BLT;
						memUnsigned = 1;
					end
					
					//branch if greater than or equal to unsigned operation
					FUNCT3_BGEU: begin
						ALU_op = ALU_BGE;
						memUnsigned = 1;
					end
				endcase
			end
			
			//jump and link operation
			OPCODE_JAL: begin
				regWrite = 1;
				ALU_op = ALU_ADD;
			end
			
			//jump and link reg operation
			OPCODE_JALR: begin
				regWrite = 1;
				ALU_op = ALU_ADD;
			end
			
			//load upper immediate operation
			OPCODE_LUI: begin
				regWrite = 1;
				ALU_src = 1;
				uType = 1;
				ALU_op = ALU_ADD;
			end
			
			//add upper immediate to PC operation
			OPCODE_AUIPC: begin
				regWrite = 1;
				ALU_src = 1;
				adjustPC = 1;
				uType = 1;
				ALU_op = ALU_ADD;
			end
			
			//system operations
			OPCODE_SYSTEM: begin
				
				case(instruction[23:20])
				
					//enviornment call operation
					FUNCT7_ECALL: begin
						isEcall = 1;
					end
					
					//enviornment break operation
					FUNCT7_EBREAK: begin
						isEbreak = 1;
					end
				endcase
			end
			
			//no operation
			OPCODE_NOP: ALU_op = ALU_NOP;
			
			default: ALU_op = ALU_NOP;
			
		endcase
	end

endmodule
