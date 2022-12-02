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
function string split_using_delimiter_fn(input int offset, string str,string del,output int cnt);
	for (int i = offset; i < str.len(); i= i+1) 
	  if (str.getc(i) == del) begin
		 cnt = i;
		 return str.substr(offset,i-1);
	   end
  endfunction

initial begin
	
	fd = $fopen("reference_sv", "r");
	

	window_reset = 1;
	ready_for_hashing = 0;
	$fgets(line, fd);
	//foreach (line[j]) begin
	for(int j =0 ; j < WINDOW_SIZE ; j = j++) begin
		window[j] = split_using_delimiter_fn(p_offset_in, line, "['", p_offset_out);
		window[j] = split_using_delimiter_fn(p_offset_in, line, ", ", p_offset_out);
	end
	window_id = i;
	window_reset = 0;
	#1
	ready_for_hashing = 1;
	while (!(hashing_is_done)) begin
		#1;
	end
	#2;
	is_insert = 1;

	
	$fclose(fd);
end
endmodule
 