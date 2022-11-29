/*------------------------------------------------------------------------------
 * File          : input_handler.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Oct 15, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module input_handler #(
	parameter WINDOW_SIZE = 128, 
			  KMER_SIZE = 16
	)(
	  input logic hashing_is_done,
	  output logic  [1:0]                     window       [0:WINDOW_SIZE-1],// consists of WINDOW_SIZE kmers
	  output logic window_id,
	  output logic window_reset,
	  output logic ready_for_hashing,
	  output logic is_insert
	  );
int fd, i = 1;
reg[1000:1] str;
string line[128];

initial begin
	fd = $fopen("reference", "r");
	
for (i = 0 ;; i++) begin
	window_reset = 1;
	ready_for_hashing = 0;
	$fseek(fd, (WINDOW_SIZE - (KMER_SIZE - 1)) * i, 0);
	$fgets(line[i], fd);

	foreach (line[j]) begin
		$display("%s", line[j]);
		case(line[j])
			"A" : window[j] = 2'b00;
			"C" : window[j] = 2'b01;
			"G" : window[j] = 2'b10;
			"T" : window[j] = 2'b11;
		endcase
		window_id = i;
		window_reset = 0;
		#1
		ready_for_hashing = 1;
		while (!(hashing_is_done)) begin
		#1;
		end
		#2;
		is_insert = 1;
		end

	end
  
		
	$fclose(fd);
end
endmodule
 