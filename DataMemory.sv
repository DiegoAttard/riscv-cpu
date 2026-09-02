import cpu_defs::*;

module DataMemory (
	input logic clock,
	input logic write_enable,
	input logic read_enable,
	input logic [1:0] memSize,
	input logic [31:0] addr,
	input logic [31:0] write_data,
	output logic [31:0] read_data
);

	logic [31:0] dmem[0:255];
		
	// write data to memory when write is enabled	
	always_ff @(posedge clock) begin
		if (write_enable) begin
			case(memSize)
				SIZE_WORD: dmem[addr >> 2] <= write_data;
				SIZE_HALF: dmem[addr >> 2] <= {16'b0, write_data[15:0]};
				SIZE_BYTE: dmem[addr >> 2] <= {24'b0, write_data[7:0]};
			endcase
		end
	end
	
	// read data from memory when read enable is active
	always_comb begin
		if (read_enable)
			read_data = dmem[addr >> 2];
		else
			read_data = 32'b0;
	end

	
	// preload memory
	initial begin
		$readmemh("data_memory.hex", dmem);
	end

endmodule
