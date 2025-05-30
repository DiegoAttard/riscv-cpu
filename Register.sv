module Register #(
	parameter DataWidth = 32
)(
	input logic clock,
	input logic reset,
	input logic write_in,
	input logic [DataWidth-1:0] data_in,
	output logic [DataWidth-1:0] data_out
);
	
	// update data_out with data_in if write is enabled
	always_ff @(posedge clock) begin
		if (write_in) begin
			data_out <= data_in;
		end
		
		if (reset) begin
			data_out <= '0
		end
	end

endmodule
