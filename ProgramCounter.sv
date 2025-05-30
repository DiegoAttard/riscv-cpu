module ProgramCounter #(
	parameter DataWidth = 32
)(
	input logic clock,
	input logic reset,
	input logic [DataWidth-1:0] pc_next,
	output logic [DataWidth-1:0] pc_out
);
	
	// increments pc on every positive clock edge
	always_ff @(posedge clock) begin
		if (reset) begin
			data_out <= '0
		end else begin
			pc_out <= pc_next;
		end
	end

endmodule
