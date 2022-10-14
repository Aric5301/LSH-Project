/*------------------------------------------------------------------------------
 * File          : hash_table.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Sep 20, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module	hash_table (
	
	input	logic     clk,
	input	logic     reset,
	input	logic     isInsert,
	input	logic     isQuery,
	input logic  [31:0] windowID,
	input logic  [7:0]  hashedSketch [0:15],  // 15:0 should be [s-1:0] for const s, [7:0] should be [log2(BUCKETS_SIZE)-1:0]
	
	output logic [31:0] countBus     [0:1023], // currently supports up to 1024 windows
	
	// local parameters, temp as output
	output logic [31:0] theTable [0:255][0:15], // Currently place for up to 16 eyvarim in one bucket, 256 is buckets size
	output logic [31:0] tableLength [0:255] // current length of each bucket, 256 is buckets size
);

// local parameters
//logic [31:0] theTable [0:255][0:15], // Currently place for up to 16 eyvarim in one bucket, 256 is buckets size
//logic [31:0] tableLength [0:255]; // current length of each bucket, 256 is buckets size
//////////--------------------------------------------------------------------------------------------------------------=

always @(posedge clk or posedge reset) begin
	if (reset) begin
		
		tableLength = '{default: '0};
		theTable = '{default: '0};
		countBus = '{default: '0};
	end
	
	else begin
		
		if (isInsert) begin
			for (int i = 0; i < 16; i = i + 1) begin
				theTable[hashedSketch[i]][tableLength[hashedSketch[i]]] = windowID;
				tableLength[hashedSketch[i]] = tableLength[hashedSketch[i]] + 1;
			end
		end else if (isQuery) begin
			
			for (int i = 0; i < 16; i = i + 1) begin
				for (int j = 0; j < 16; j = j + 1) begin // TODO: currently 16 eyvarim
					if (j < tableLength[hashedSketch[i]]) begin
						countBus[theTable[hashedSketch[i]][j]] = countBus[theTable[hashedSketch[i]][j]] + 1;
					end
				end
			end
		end
	end
end

//////////--------------------------------------------------------------------------------------------------------------=
endmodule