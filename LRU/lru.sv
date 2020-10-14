module arbiter_LRU4(
	input wire clk,
	input wire reset,
	input wire enable,
	input wire [3:0] req_vector,
	output reg [3:0] grant_vector
	);

reg [3:0] [1:0]mem;
reg grant_given;
always @(posedge clk) begin
	if (reset) begin
		grant_vector <= 0;
		mem[0] <= 0;
		mem[1] <= 1;
		mem[2] <= 2;
		mem[3] <= 3;
		grant_given <= 1'b0;
	end else if (enable && !grant_given) begin
		grant_vector <= 0;
		grant_given <= 1;
		if (req_vector[mem[0]]) begin
			grant_vector[mem[0]] <= 1'b1;
		end else if (req_vector[mem[1]]) begin
			grant_vector[mem[1]] <= 1'b1;
			mem[1] <= mem[0];
			mem[0] <= mem[1];
		end else if (req_vector[mem[2]]) begin
			grant_vector[mem[2]] <= 1'b1;
			mem[2] <= mem[1];
			mem[1] <= mem[0];
			mem[0] <= mem[2];
		end else if (req_vector[mem[3]]) begin
			grant_vector[mem[3]] <= 1'b1;
			mem[3] <= mem[2];
			mem[2] <= mem[1];
			mem[1] <= mem[0];
			mem[0] <= mem[3];
		end
	end else if (grant_given) begin
		grant_given <= 0;
	end else if (enable == 0) begin
		grant_vector <= 0;
	end
end

endmodule