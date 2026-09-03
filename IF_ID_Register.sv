module IF_ID_Register (
	input logic clock,
	input logic reset,
	input logic [31:0] PC_in,
	input logic [31:0] instruction_in,
	output logic [31:0] PC_out,
	output logic [31:0] instruction_out
);
	
	always_ff @(posedge clock or posedge reset) begin
		if (reset) begin
			PC_out <= 32'b0;
			instruction_out <= 32'b0;
		end else begin
			PC_out <= PC_in;
			instruction_out <= instruction_in;
		end
	end

endmodule
