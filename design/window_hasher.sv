/*------------------------------------------------------------------------------
 * File          : window_hasher.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Nov 29, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module window_hasher #(
	parameter SKETCH_SIZE         =16,
	          NUM_OF_BUCKETS      =256,
	          LOG2_NUM_OF_BUCKETS =8,
	          WINDOW_SIZE         =128,
	          KMER_SIZE           =16
) (
	
	input	logic                        clk,
	input	logic                        reset,
	input	logic                        ready_for_hashing,
	input logic  [1:0]                     window       [0:WINDOW_SIZE-1], // consists of WINDOW_SIZE kmers
	
	
	output logic [LOG2_NUM_OF_BUCKETS-1:0] hashedSketch [0:SKETCH_SIZE-1], // vector of SKETCH_SIZE size with each value representing the value of the K-mer after h2 is applied on it
	output logic                           hashing_is_done                 // turns on for one clock cycle when ready
);

logic [31:0] h1_all_kmers  [0:WINDOW_SIZE-KMER_SIZE+1]; // h1 run on all possible kmers
logic [LOG2_NUM_OF_BUCKETS-1:0] h2_all_kmers  [0:WINDOW_SIZE-KMER_SIZE+1]; // h2 run on all possible kmers

logic is_hashing_active;

genvar i;
generate
	for (i = 0 ; i <= WINDOW_SIZE - 1 - KMER_SIZE + 1 ; i++) begin
		hasher u0 (
			.kmer(window[i:i + KMER_SIZE - 1]),
			.h1  (h1_all_kmers[i]            ),
			.h2  (h2_all_kmers[i]            )
		);
	end
endgenerate

logic [31:0] h1_sketch [0:SKETCH_SIZE-1];

logic [31:0] currentSmallest;

logic [31:0] index_in_h1_sketch;
logic [31:0] index_in_h1_all_kmers;

always @(posedge clk or posedge reset) begin
	
	if (reset) begin
		
		currentSmallest = 0;
		index_in_h1_sketch = 0;
		index_in_h1_all_kmers = 0;
		is_hashing_active = 0;
		hashing_is_done = 0;
	end
	
	else if (ready_for_hashing == 1 && is_hashing_active == 0) begin
		
		is_hashing_active = 1;
	end
	
	else if (is_hashing_active == 1 && hashing_is_done == 0) begin
		
		if (index_in_h1_all_kmers == 0) begin
			
			if (h1_all_kmers[index_in_h1_all_kmers] >= currentSmallest) begin
				
				h1_sketch[index_in_h1_sketch] = h1_all_kmers[index_in_h1_all_kmers];
				hashedSketch[index_in_h1_sketch] = h2_all_kmers[index_in_h1_all_kmers];
			end
			index_in_h1_all_kmers += 1;
		end
		
		else begin
			
			if (h1_all_kmers[index_in_h1_all_kmers] >= currentSmallest
					&& h1_all_kmers[index_in_h1_all_kmers] < h1_sketch[index_in_h1_sketch]) begin
				
				h1_sketch[index_in_h1_sketch] = h1_all_kmers[index_in_h1_all_kmers];
				hashedSketch[index_in_h1_sketch] = h2_all_kmers[index_in_h1_all_kmers];
			end
			
			if (index_in_h1_all_kmers == WINDOW_SIZE-KMER_SIZE+1) begin
				
				if (index_in_h1_sketch == SKETCH_SIZE - 1) begin
					
					hashing_is_done = 1;
				end
				
				else begin
					
					currentSmallest = h1_sketch[index_in_h1_sketch];
					index_in_h1_sketch += 1;
					index_in_h1_all_kmers = 0;
				end
			end
			
			else begin
				
				index_in_h1_all_kmers += 1;
			end
		end
	end
end
endmodule
