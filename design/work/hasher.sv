/*------------------------------------------------------------------------------
 * File          : hasher.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Oct 15, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module hasher #( parameter
	NUM_OF_BUCKETS      =256, KMER_SIZE           =16) (
		
		input logic  [1:0]                     kmer [0:KMER_SIZE-1],
		
		output logic [31:0]                    h1,
		output logic [$clog2(NUM_OF_BUCKETS)-1:0] h2
	);

localparam [31:0] SEED = 32'h8f83adef; // Completely arbitrary, at least for now

logic [31:0] chunk;

assign h1 = murmurblock(SEED, chunk);
assign h2 = h1[$clog2(NUM_OF_BUCKETS)-1:0];
assign chunk = {kmer[0], kmer[1], kmer[2], kmer[3], kmer[4], kmer[5], kmer[6], kmer[7],
		kmer[8], kmer[9], kmer[10], kmer[11], kmer[12], kmer[13], kmer[14], kmer[15]}; // TODO: last index is KMER_SIZE

function [31:0] murmurblock;
	input [31:0] seed, chunk;
	logic [31:0] k, key;
	localparam [31:0] c1 = 'hcc9e2d51;
	localparam [31:0] c2 = 'h1b873593;
	localparam [31:0] m = 5;
	localparam [31:0] n = 'he6546b64;
	begin
		k = chunk;
		k = k * c1;
		k = {k[16:0], k[31:17]}; // ROL15
		k = k * c2;
		
		key = seed;
		key = key ^ k;
		key = {key[18:0], key[31:19]}; // ROL13
		murmurblock = key * m + n;
	end
endfunction

endmodule
