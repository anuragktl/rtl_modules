module seq_detect (
	input wire in,
	input wire clk,
	input wire rst,
	output reg match
	);

localparam [2:0] S0 = 0;
localparam [2:0] S1 = 1;
localparam [2:0] S2 = 2;
localparam [2:0] S3 = 3;
localparam [2:0] S4 = 4;
localparam [2:0] S5 = 5;
localparam [2:0] S6 = 6;

logic [2:0] STATE;

always @(posedge clk) begin
	if (rst) begin
		match <= 0;
		STATE <= S0;
	end else begin
		match <= 0;
		case (STATE)
			S0: begin
				if (in) begin
					STATE <= S1;
				end
			end

			S1: begin
				if (in) begin
					STATE <= S2;
				end else begin
					STATE <= S0;
				end
			end

			S2: begin
				if (in) begin
					STATE <= S3;
				end else begin
					STATE <= S0;
				end
			end

			S3: begin
				if (in == 0) begin
					STATE <= S4;
				end
			end

			S4: begin
				if (in) begin
					STATE <= S5;
				end else begin
					STATE <= S0;
				end
			end

			S5: begin
				if (in == 0) begin
					STATE <= S6;
				end else begin
					STATE <= S2;
				end
			end

			S6: begin
				match <= 1;
				if (in) begin
					STATE <= S1;
				end else begin
					STATE <= S0;
				end
			end
		endcase // STATE
	end // : end else
end // : always @(posedge clk)
endmodule
