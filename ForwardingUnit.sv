module ForwardingUnit(
	input logic [4:0] rs1_addr_EX,
	input logic [4:0] rs2_addr_EX,
	input logic [4:0] rd_addr_MEM,
	input logic [4:0] rd_addr_WB,
	input logic regWrite_MEM,
	input logic regWrite_WB,
	output logic [1:0] forwardA,
	output logic [1:0] forwardB
);

	always_comb begin
		
		forwardA = 2'b00;
		forwardB = 2'b00;
		
		if (regWrite_MEM && (rd_addr_MEM != 5'd0) && (rd_addr_MEM == rs1_addr_EX)) 
			forwardA = 2'b10;
		
		if (regWrite_WB && (rd_addr_WB != 5'd0) && (rd_addr_WB == rs1_addr_EX)) 
			forwardA = 2'b01;
			
		if (regWrite_MEM && (rd_addr_MEM != 5'd0) && (rd_addr_MEM == rs2_addr_EX)) 
			forwardB = 2'b10;
		
		if (regWrite_WB && (rd_addr_WB != 5'd0) && (rd_addr_WB == rs2_addr_EX)) 
			forwardB = 2'b01;
		
	end
	
endmodule
