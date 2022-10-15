/*------------------------------------------------------------------------------
 * File          : hasher.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Oct 15, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module hasher #( parameter
	NUM_OF_BUCKETS      =256, LOG2_NUM_OF_BUCKETS =8, KMER_SIZE           =16) (
		
		input	logic                        clk,
		input	logic                        reset,
		input logic  [1:0]                     kmer [0:KMER_SIZE-1], // currently supports up to 1024 windows
		
		
		output logic [31:0]                    h1,
		output logic [LOG2_NUM_OF_BUCKETS-1:0] h2
	);

endmodule