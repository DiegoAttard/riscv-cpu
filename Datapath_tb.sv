module Datapath_tb;

	logic clock;
	logic reset;
	
	// instantiating the datapath
	Datapath datapath_inst(
		.clock(clock),
		.reset(reset)
	);
	
	// clock generation
	initial begin 
		clock = 0;
		forever #5 clock = ~clock;
	end

	initial begin
		// for waveform viewing
		$dumpfile("datapath_tb.vcd");
		$dumpvars(0, Datapath_tb);
		
		reset = 1;
		#10;
		reset = 0;
		
		// simulation run time
		#300;
		
		$finish;
	end
	
endmodule
