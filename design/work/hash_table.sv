/*------------------------------------------------------------------------------
 * File          : hash_table.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Sep 20, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module	hash_table #(
	parameter SKETCH_SIZE              =16,
	          NUM_OF_BUCKETS           =256,
	          BUCKET_SIZE              =16,
	          MAX_WINDOWS_IN_REFERENCE = 512
) (
	input logic                            clk,
	input logic                            reset_hash_table,
	input logic                            is_insert,
	input logic                            is_query,
	input logic  [31:0]                    window_id,
	input logic  [$clog2(NUM_OF_BUCKETS)-1:0] hashed_sketch [0:SKETCH_SIZE-1],             // vector of SKETCH_SIZE size with each value representing the value of the K-mer after h2 is applied on it
	
	output logic [31:0]                    count_bus     [0:MAX_WINDOWS_IN_REFERENCE-1] // currently supports up to 1024 windows
);

logic [31:0] theTable     [0:NUM_OF_BUCKETS-1][0:BUCKET_SIZE-1]; // NUM_OF_BUCKETS buckets of BUCKET_SIZE size
logic [31:0] tableLength  [0:NUM_OF_BUCKETS-1];        // current length of each bucket
logic wasBucketQueried [0:255];

always @(posedge clk or posedge reset_hash_table) begin
	
	if (reset_hash_table) begin
		
		tableLength = '{default: '0};
		theTable = '{default: '0};
		count_bus = '{default: '0};
		wasBucketQueried = '{default: '0};
	end
	
	else begin
		
		if (is_insert) begin
			
			for (int i = 0; i < SKETCH_SIZE; i = i + 1) begin
				theTable[hashed_sketch[i]][tableLength[hashed_sketch[i]]] = window_id;
				tableLength[hashed_sketch[i]] = tableLength[hashed_sketch[i]] + 1;
			end
			
		end else if (is_query) begin
			wasBucketQueried = '{default: '0};
			count_bus = '{default: '0};
			
			for (int i = 0; i < SKETCH_SIZE; i = i + 1) begin
				
				for (int j = 0; j < BUCKET_SIZE; j = j + 1) begin
					
					if (j < tableLength[hashed_sketch[i]] && wasBucketQueried[hashed_sketch[i]] == 1'b0) begin
						
						count_bus[theTable[hashed_sketch[i]][j]] = count_bus[theTable[hashed_sketch[i]][j]] + 1;
					end
				end
				wasBucketQueried[hashed_sketch[i]] = 1'b1;
			end
		end
	end
end
endmodule
