/*------------------------------------------------------------------------------
 * File          : hasher_tb.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Oct 16, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module hasher_tb #( parameter
	NUM_OF_BUCKETS=256, LOG2_NUM_OF_BUCKETS=8, KMER_SIZE=16) ();

logic [1:0] kmer [0:KMER_SIZE-1];


logic [31:0] h1;
logic [LOG2_NUM_OF_BUCKETS-1:0] h2;

hasher U1 (.*);

initial begin
	$monitor ("@%g kmer[0]= %d, h1= %d, h2= %d",
			$time, kmer[0], h1, h2);
	
	kmer[0] = 2'b10;
	kmer[1] = 2'b10;
	kmer[2] = 2'b10;
	kmer[3] = 2'b10;
	kmer[4] = 2'b10;
	kmer[5] = 2'b10;
	kmer[6] = 2'b10;
	kmer[7] = 2'b10;
	kmer[8] = 2'b10;
	kmer[9] = 2'b10;
	kmer[10] = 2'b10;
	kmer[11] = 2'b10;
	kmer[12] = 2'b10;
	kmer[13] = 2'b10;
	kmer[14] = 2'b10;
	kmer[15] = 2'b10;
	
	#2;
	
	kmer[0] = 2'b00;
	kmer[1] = 2'b00;
	kmer[2] = 2'b00;
	kmer[3] = 2'b00;
	kmer[4] = 2'b10;
	kmer[5] = 2'b10;
	kmer[6] = 2'b10;
	kmer[7] = 2'b10;
	kmer[8] = 2'b10;
	kmer[9] = 2'b10;
	kmer[10] = 2'b10;
	kmer[11] = 2'b10;
	kmer[12] = 2'b10;
	kmer[13] = 2'b10;
	kmer[14] = 2'b10;
	kmer[15] = 2'b10;
	
	#2
	
	$finish;
end
endmodule