/*------------------------------------------------------------------------------
 * File          : window_hasher_tb.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Nov 29, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module window_hasher_tb #(
	parameter SKETCH_SIZE         =16,
			  NUM_OF_BUCKETS      =256,
			  WINDOW_SIZE         =128,
			  KMER_SIZE           =16
) ();

logic                        clk;
logic                        reset;
logic                        ready_for_hashing;
logic  [1:0]                     window       [0:WINDOW_SIZE-1]; // consists of WINDOW_SIZE kmers


logic [$clog2(NUM_OF_BUCKETS)-1:0] hashedSketch [0:SKETCH_SIZE-1]; // vector of SKETCH_SIZE size with each value representing the value of the K-mer after h2 is applied on it
logic                           hashing_is_done;                 // turns on for one clock cycle when ready

window_hasher U1 (.*);

int temp;

initial begin
	/*$monitor ("@%g hashedSketch[0]= %d, hashedSketch[1]= %d, hashedSketch[2]= %d, hashedSketch[3]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d, hashedSketch[0]= %d,",
	$time, kmer[0], h1, h2);*/
	
	reset = 1'b1;
	clk = 1'b0;
	#6;
	reset = 1'b0;
	
	// window = '{default: '0};
	for(int i = 0; i < WINDOW_SIZE; i++) begin
		// window[i] = i % 4;
		temp = ($urandom_range(3, 0));
		window[i] = temp[1:0];
	end
	
	ready_for_hashing = 1;
	
	wait(hashing_is_done == 1);
	
	$finish;
end

always #1 clk=~clk; //now you create your cyclic clock


endmodule

