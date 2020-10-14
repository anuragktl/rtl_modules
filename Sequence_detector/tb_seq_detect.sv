`timescale 1ns/1ps
module tb_seq_detect;

logic in;
logic clk;
logic rst;
logic match;

initial begin 
	clk = 0;
end

always #2.5 clk = !clk;

bit [18:0]in_seq= 'b101_0111_0101_0111_0101; 
int fd;
initial begin
	#0.2
	rst = 1;
	repeat (4) begin
		@(negedge clk);
	end
	
	rst = 0;
	for (int i = 18; i >= 0; i--) begin
		in = in_seq[i];
		@(negedge clk);
	end
	#20;
	$fclose(fd);
	$finish;
end

initial begin
	
	fd = $fopen("seq_detect_output.txt", "w");
	if (fd) begin
		$display("File was opened successfully :%0d", fd);
	end else begin
		$display("File was not opened successfully :%0d", fd);
	end

	forever begin
		@(posedge clk);
		#0.1;
		$display("At time %5d ns, rst = %b, clk = %b, in = %b, match = %b", $time, rst, clk, in, match);
		$fdisplay(fd, "At time %5d ns, rst = %b, clk = %b, in = %b, match = %b", $time, rst, clk, in, match);
		// if (i == 0) begin
		// 	$fclose(fd);
		// end
	end
	// $fmonitor(fd, "At time %5d ns, rst = %b, clk = %b, in = %b, match = %b", $time, rst, clk, in, match);


end

seq_detect DUT (
	.in (in),
	.clk (clk),
	.rst (rst),
	.match (match)
	);

endmodule : tb_seq_detect