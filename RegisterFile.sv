module RegisterFile (
	input logic clock,
	input logic reset,
	input logic regWrite,
	input logic [4:0] readAddr1,
	input logic [4:0] readAddr2,
	input logic [4:0] writeAddr,
	input logic [31:0] writeData,
	output logic [31:0] readData1,
	output logic [31:0] readData2
);

	// creating array for 32 registers that are 32 bits
	logic [31:0] registerArray [0:31];
	
	// writing data to registers if write is enabled
	// reseting register values on reset signal
	always_ff @(posedge clock) begin
		if (reset) begin
			for (int i = 0; i < 32; i++) begin
				registerArray[i] <= 0;
			end
		end else if (regWrite && writeAddr) begin
			registerArray[writeAddr] <= writeData;
		end
	end
	
	// reading data from registers
	assign readData1 = (readAddr1 != 0) ? registerArray[readAddr1] : 0;
	assign readData2 = (readAddr2 != 0) ? registerArray[readAddr2] : 0;

endmodule
