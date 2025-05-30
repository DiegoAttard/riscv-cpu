module DataMemory (
	input logic clock,
	input logic write_enable,
	input logic read_enable,
	input logic [31:0] addr,
	input logic [31:0] write_data,
	output logic [31:0] read_data
);

	logic [31:0] dmem[0:255];
		
	// write data to memory when write is enabled	
	always_ff @(posedge clock) begin
		if (write_enable) begin
			dmem[addr >> 2] <= write_data;
		end
	end
	
	// read data from memory when read enable is active
	always_ff @(posedge clock) begin
		if (read_enable) begin
			read_data <= dmem[addr >> 2];
		end
	end
	
	// preload memory
	initial begin
		$readmemh("data_memory.hex", dmem);
	end

endmodule
