/*------------------------------------------------------------------------------
 * File          : stats.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Jan 21, 2023
 * Description   :
 *------------------------------------------------------------------------------*/

module stats_tb #(
	parameter MAX_WINDOWS_IN_REFERENCE = 512,
	          BUCKET_SIZE              =16,
	          WINDOWS_PER_QUERY        = 1 // In the future this might change
) ();

logic                            clk;
logic                            reset_stats;
logic                            is_query;
logic [31:0]                    count_bus    [0:MAX_WINDOWS_IN_REFERENCE-1];
logic                    calculate_matched_window;

logic signed [31:0] matched_window_id;

stats U1 (.*);

always #1 clk=~clk; // creation of clock

initial begin
	$monitor ("@%g matched_window_id= %d", $time, matched_window_id);
	clk = 1'b0;
	reset_stats = 1'b1;
	#4;
	reset_stats = 1'b0;
	is_query = 1'b1;
	count_bus = '{default: '0};
	count_bus[5] = 0;
	count_bus[7] = 0;
	count_bus[8] = 0;
	#4;
	is_query = 1'b0;
	#4;
	calculate_matched_window = 1'b1;
	#3;
	
	
	$finish;
end
endmodule