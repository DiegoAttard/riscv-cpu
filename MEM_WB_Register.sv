module MEM_WB_Register (
	input logic clock,
	input logic reset,

	// data from memory stage
	input logic [31:0] PC_in,
	input logic [31:0] ALU_result_in,
	input logic [31:0] memData_in,

	// register address in
	input logic [4:0] rd_addr_in,

	// control signals in
	input logic regWrite_in,
	input logic memRead_in,
	input logic memUnsigned_in,
	input logic [1:0] memSize_in,

	// data to writeback stage
	output logic [31:0] PC_out,
	output logic [31:0] ALU_result_out,
	output logic [31:0] memData_out,

	// register address out
	output logic [4:0] rd_addr_out,

	// control signals out
	output logic regWrite_out,
	output logic memRead_out,
	output logic memUnsigned_out,
	output logic [1:0] memSize_out
);

	always_ff @(posedge clock or posedge reset) begin
		if (reset) begin
			PC_out <= 32'b0;
			ALU_result_out <= 32'b0;
			memData_out <= 32'b0;
			rd_addr_out <= 5'b0;
			regWrite_out <= 1'b0;
			memRead_out <= 1'b0;
			memUnsigned_out <= 1'b0;
			memSize_out <= 2'b0;
		end else begin
			PC_out <= PC_in;
			ALU_result_out <= ALU_result_in;
			memData_out <= memData_in;
			rd_addr_out <= rd_addr_in;
			regWrite_out <= regWrite_in;
			memRead_out <= memRead_in;
			memUnsigned_out <= memUnsigned_in;
			memSize_out <= memSize_in;
		end
	end
endmodule
