/*------------------------------------------------------------------------------
 * File          : hasher.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Oct 15, 2022
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
	input logic  [1:0]                     window       [0:WINDOW_SIZE-1], // currently supports up to 1024 windows
	
	
	output logic [LOG2_NUM_OF_BUCKETS-1:0] hashedSketch [0:SKETCH_SIZE-1]  // vector of SKETCH_SIZE size with each value representing the value of the K-mer after h2 is applied on it
);

endmodule