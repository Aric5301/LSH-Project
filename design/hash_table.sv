/*------------------------------------------------------------------------------
 * File          : hash_table.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Sep 20, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module	hash_table #(
	parameter SKETCH_SIZE         =16,
	          NUM_OF_BUCKETS      =256,
	          LOG2_NUM_OF_BUCKETS =8,
	          BUCKET_SIZE         =16
) (
	
	input	logic                        clk,
	input	logic                        reset,
	input	logic                        isInsert,
	input	logic                        isQuery,
	input logic  [31:0]                    windowID,
	input logic  [LOG2_NUM_OF_BUCKETS-1:0] hashedSketch [0:SKETCH_SIZE-1],                     // vector of SKETCH_SIZE size with each value representing the value of the K-mer after h2 is applied on it
	
	output logic [31:0]                    countBus     [0:1023],                              // currently supports up to 1024 windows
	
	// local parameters, temp as output
	output logic [31:0]                    theTable     [0:NUM_OF_BUCKETS-1][0:BUCKET_SIZE-1], // NUM_OF_BUCKETS buckets of BUCKET_SIZE size
	output logic [31:0]                    tableLength  [0:NUM_OF_BUCKETS-1]                   // current length of each bucket
);

// local parameters
//logic [31:0] theTable     [0:NUM_OF_BUCKETS-1][0:BUCKET_SIZE-1], // NUM_OF_BUCKETS buckets of BUCKET_SIZE size
//logic [31:0] tableLength  [0:NUM_OF_BUCKETS-1]        // current length of each bucket
logic wasBucketQueried [0:255];
//////////--------------------------------------------------------------------------------------------------------------=

always @(posedge clk or posedge reset) begin
	if (reset) begin
		
		tableLength = '{default: '0};
		theTable = '{default: '0};
		countBus = '{default: '0};
		wasBucketQueried = '{default: '0};
	end
	
	else begin
		
		if (isInsert) begin
			for (int i = 0; i < SKETCH_SIZE; i = i + 1) begin
				theTable[hashedSketch[i]][tableLength[hashedSketch[i]]] = windowID;
				tableLength[hashedSketch[i]] = tableLength[hashedSketch[i]] + 1;
			end
		end else if (isQuery) begin
			wasBucketQueried = '{default: '0};
			countBus = '{default: '0};
			
			for (int i = 0; i < SKETCH_SIZE; i = i + 1) begin
				
				for (int j = 0; j < BUCKET_SIZE; j = j + 1) begin
					if (j < tableLength[hashedSketch[i]] && wasBucketQueried[hashedSketch[i]] == 1'b0) begin
						countBus[theTable[hashedSketch[i]][j]] = countBus[theTable[hashedSketch[i]][j]] + 1;
					end
				end
				wasBucketQueried[hashedSketch[i]] = 1'b1;
			end
		end
	end
end

//////////--------------------------------------------------------------------------------------------------------------=
endmodule