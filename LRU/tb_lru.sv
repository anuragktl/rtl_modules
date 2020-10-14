`timescale 1ns/100ps
module tb_lru;

	logic clk, reset, enable;
	logic [3:0] req_vector, grant_vector;

	arbiter_LRU4 DUT (.*);

	initial clk = 0;

	always #2.5 clk = !clk;
	logic [12:0] reset_vec = 13'b0_0000_1000_0001; 
	logic [12:0] enable_vec = 13'b1_1111_0011_1100;
	logic [12:0] [3:0] req_vec = 52'hefadcbe7b8fea;
	int i;
	always @(posedge clk) begin
		#1;
		$display("Cycle number %d, reset = %b, enable = %b, req_vector = %4b, grant_vector = %4b", i,reset,enable,req_vector,grant_vector);
	end
	initial begin
		
		// $monitor("Cycle number %d, reset = %b, enable = %b, req_vector = %4b, grant_vector = %4b", i,reset,enable,req_vector,grant_vector);
		for (i = 0; i <= 12; i++) begin
			@(posedge clk);
			#1;
			reset = reset_vec[i];
			enable = enable_vec[i];
			req_vector = req_vec[i];
		end
		#10;
		$finish;

	end
endmodule