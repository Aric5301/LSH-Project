/*------------------------------------------------------------------------------
 * File          : input_handler_tb.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Nov 29, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module input_handler_tb #(
		parameter WINDOW_SIZE = 128, 
					KMER_SIZE = 16
) ();

logic hashing_is_done;
logic  [1:0]                     window       [0:WINDOW_SIZE-1];// consists of WINDOW_SIZE kmers
logic window_id;
logic window_reset;
logic ready_for_hashing;
logic is_insert;



initial begin
	$monitor ("window_reset = %b, is_insert = %b, window_id = %d window[0] = %b, window[17] = %b",
				window_reset, is_insert, window_id, window[0][0], window[17][1]);

$finish;
end
endmodule