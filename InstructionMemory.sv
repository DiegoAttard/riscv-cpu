module InstructionMemory (
	input logic [31:0] curr_addr,
	output logic [31:0] instruction
);

	logic [31:0] imem[0:255];
	
	// reading instruction from memory
	assign instruction = imem[curr_addr >> 2];
	
	// preload instructions
	initial begin
		$readmemh("instruction_memory.hex", imem);
	end

endmodule
