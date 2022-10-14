/*------------------------------------------------------------------------------
 * File          : hash_table_tb.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Sep 24, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module hash_table_tb #() ();

logic     clk;
logic     reset;
logic     isInsert;
logic     isQuery;
logic  [31:0] windowID;
logic  [7:0]  hashedSketch [0:15];  // 15:0 should be [s-1:0] for const s, [7:0] should be [log2(BUCKETS_SIZE)-1:0]

logic [31:0] countBus     [0:1023]; // currently supports up to 1024 windows

logic [31:0] theTable [0:255][0:15]; // Currently place for up to 16 eyvarim in one bucket, 256 is buckets size
logic [31:0] tableLength [0:255]; // current length of each bucket, 256 is buckets size

hash_table U1 (.*);

initial begin
	$monitor ("@%g clk= %b reset= %b isInsert= %b isQuery= %b windowID= %d, theTable[0][0]= %d, tableLength[0] = %d",
			$time,clk,reset,isInsert,isQuery,windowID,theTable[0][0],tableLength[0]);
	
	
	clk = 1'b0;
	reset = 1'b0;
	isInsert = 1'b0;
	isQuery = 1'b0;
	windowID = 0;
	for (int i = 0; i < 16; i = i + 1) begin
		hashedSketch[i] = 8'd0;
	end
	#2;
	
	reset = 1'b1;
	#2;
	reset = 1'b0;
	#2;
	windowID = 14;
	isInsert = 1'b1;
	clk = 1'b1;
	#2;
	windowID = 0;
	isInsert = 1'b0;
	clk = 1'b0;
	#2;
	
	$finish;
end
endmodule
