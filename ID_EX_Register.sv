module ID_EX_Register (
	input logic clock,
	input logic reset,
	
	// data from instruction decode stage
	input logic [31:0] PC_in,
	input logic [31:0] rs1_data_in,
	input logic [31:0] rs2_data_in,
	input logic [31:0] immediate_in,
	
	// register addresses in
	input logic [4:0] rs1_address_in,
	input logic [4:0] rs2_address_in,
	input logic [4:0] rd_address_in,
	
	// control signals in
	input logic regWrite_in,
   input logic memWrite_in,
   input logic memRead_in,
   input logic ALU_src_in,
   input logic isBranch_in,
   input logic memUnsigned_in,
   input logic isEcall_in,
   input logic isEbreak_in,
   input logic adjustPC_in,
   input logic [1:0] memSize_in,
   input logic [3:0] ALU_op_in,
	
	// data to execute stage
   output logic [31:0] PC_out,
   output logic [31:0] rs1_data_out,
   output logic [31:0] rs2_data_out,
   output logic [31:0] immediate_out,
	
	// register addresses out
	output logic [4:0] rs1_addr_out,
   output logic [4:0] rs2_addr_out,
   output logic [4:0] rd_addr_out,
	
	// control signals out
	output logic regWrite_out,
   output logic memWrite_out,
   output logic memRead_out,
   output logic ALU_src_out,
   output logic isBranch_out,
   output logic memUnsigned_out,
   output logic isEcall_out,
   output logic isEbreak_out,
   output logic adjustPC_out,
   output logic [1:0] memSize_out,
   output logic [3:0] ALU_op_out
);
	
	always_ff @(posedge clock or posedge reset) begin
       if (reset) begin
           PC_out <= 32'b0;
           rs1_data_out <= 32'b0;
           rs2_data_out <= 32'b0;
           immediate_out <= 32'b0;
           rs1_addr_out <= 5'b0;
           rs2_addr_out <= 5'b0;
           rd_addr_out <= 5'b0;
           regWrite_out <= 1'b0;
           memWrite_out <= 1'b0;
           memRead_out <= 1'b0;
           ALU_src_out <= 1'b0;
           isBranch_out <= 1'b0;
           memUnsigned_out <= 1'b0;
           isEcall_out <= 1'b0;
           isEbreak_out <= 1'b0;
           adjustPC_out <= 1'b0;
           memSize_out <= 2'b0;
           ALU_op_out <= 4'b0;
       end else begin
           PC_out <= PC_in;
           rs1_data_out <= rs1_data_in;
           rs2_data_out <= rs2_data_in;
           immediate_out <= immediate_in;
           rs1_addr_out <= rs1_addr_in;
           rs2_addr_out <= rs2_addr_in;
           rd_addr_out <= rd_addr_in;
           regWrite_out <= regWrite_in;
           memWrite_out <= memWrite_in;
           memRead_out <= memRead_in;
           ALU_src_out <= ALU_src_in;
           isBranch_out <= isBranch_in;
           memUnsigned_out <= memUnsigned_in;
           isEcall_out <= isEcall_in;
           isEbreak_out <= isEbreak_in;
           adjustPC_out <= adjustPC_in;
           memSize_out <= memSize_in;
           ALU_op_out <= ALU_op_in;
       end
   end
endmodule
