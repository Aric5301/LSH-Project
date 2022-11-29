/*------------------------------------------------------------------------------
 * File          : input_handler.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Oct 15, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module input_handler #(
	parameter WINDOW_SIZE = 128
	)();
int fd, i = 0;
reg[1000:1] str;
string line;
logic  [1:0]                     window       [0:WINDOW_SIZE-1];// consists of WINDOW_SIZE kmers


initial begin
	$monitor ("window[0] = %d, window[1] = %d, window[7] = %d, window[124]= %d", window[0], window[1], window[7], window[124]);
	fd = $fopen("read_1410.txt", "r");
	$fgets(line,fd);

foreach (line[i]) begin
	$display("%s", line[i]);
	case(line[i])
		"A" : window[i] = 2'b00;
		"C" : window[i] = 2'b01;
		"G" : window[i] = 2'b10;
		"T" : window[i] = 2'b11;
	endcase
end
  
		
	$fclose(fd);
end
endmodule