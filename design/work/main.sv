/*------------------------------------------------------------------------------
 * File          : main.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Jan 20, 2023
 * Description   :
 *------------------------------------------------------------------------------*/

module main #(
	parameter WINDOW_SIZE              = 128,
	          KMER_SIZE                = 16,
	          SKETCH_SIZE              = 16,
	          NUM_OF_BUCKETS           = 256,
	          BUCKET_SIZE              = 16,
	          MAX_WINDOWS_IN_REFERENCE = 512,
	          MAX_WINDOWS_IN_READ      = 16
) ();


// Wires
// ==================================================
// Interface between main and other modules
logic                            hashing_is_done;
logic                            calculate_matched_window;
logic                            reset_stats;
logic                            clk;
logic                            reset_hash_table;
logic  [1:0]                     window       [0:WINDOW_SIZE-1]; // consists of WINDOW_SIZE kmers
logic  [31:0]                    window_id;
logic                        	 ready_for_hashing;
logic                        	 reset_window_hasher;
logic                            is_insert;
logic                            is_query;
logic signed [31:0]              matched_window_id;

// Inner interfaces between modules
logic  [$clog2(NUM_OF_BUCKETS)-1:0] hashed_sketch [0:SKETCH_SIZE-1];
logic  [31:0]                       count_bus     [0:MAX_WINDOWS_IN_REFERENCE-1];
// ==================================================


// Modules Instantiation
// ==================================================
window_hasher window_hasher (
	// Inputs
	.clk                (clk                ),
	.reset_window_hasher(reset_window_hasher),
	.ready_for_hashing  (ready_for_hashing  ),
	.window             (window             ),
	
	// Outputs
	.hashed_sketch      (hashed_sketch      ),
	.hashing_is_done    (hashing_is_done    )
);

hash_table hash_table (
	// Inputs
	.clk             (clk             ),
	.reset_hash_table(reset_hash_table),
	.is_insert       (is_insert       ),
	.is_query        (is_query        ),
	.window_id       (window_id       ),
	.hashed_sketch   (hashed_sketch   ),
	
	// Outputs
	.count_bus       (count_bus       )
);

stats stats (
	// Inputs
	.clk                     (clk                     ),
	.reset_stats             (reset_stats             ),
	.is_query                (is_query                ),
	.count_bus               (count_bus               ),
	.calculate_matched_window(calculate_matched_window),
	
	// Outputs
	.matched_window_id       (matched_window_id       )
);
// ==================================================


// Variables
// ==================================================
logic isReference;

int temp;
int fd;
int i = 0;
int j = 0;
int k = 0;
int scanned = 0;
int dummy;

string file_name;
string file_number;
// ==================================================

// turning sections from read and reference files to windows, handling required flags
task window_maker(int fd, logic isReference);
	
	// flags reset
	is_insert = 1'b0;
	is_query = 1'b0;
	i = 0;
	
	while (!($feof(fd))) begin
		ready_for_hashing = 1'b0;
		reset_window_hasher = 1'b1;
		#2
				reset_window_hasher = 1'b0;
		
		// assigning to window according to nucleotides in file
		for(int j = 0 ; j < WINDOW_SIZE ; j++) begin
			if (($feof(fd))) begin
				break;
			end
			temp = $fgetc(fd);
			case (temp)
				"A": window[j] = 2'b00;
				"C": window[j] = 2'b01;
				"G": window[j] = 2'b10;
				"T": window[j] = 2'b11;
			endcase
		end
		if (($feof(fd))) begin
			break;
		end
		window_id = i;
		$display("%d", window_id);
		ready_for_hashing = 1'b1;
		while (!(hashing_is_done)) begin
			#2;
		end
		if (isReference) begin
			is_insert = 1'b1;
			#2;
			is_insert = 1'b0;
		end
		else begin
			is_query = 1'b1;
			#2
					is_query = 1'b0;
		end
		if (!($feof(fd))) begin
			i++;
			dummy = $fseek(fd, (WINDOW_SIZE - KMER_SIZE + 1) * i, 0);
		end
		
	end
endtask

always #1 clk=~clk; // creation of clock


initial begin
	
	clk = 1'b0;
	reset_hash_table = 1'b1;
	#2
			reset_hash_table = 1'b0;
	
	
	// opening reference file
	fd = $fopen("reference_sv", "r");
	isReference = 1'b1;
	window_maker(fd, isReference);
	
	
	// opening read files
	while (1'b1) begin
		$sformat(file_number,"%0d",k);
		file_name = {"./read_files/read_sv_", file_number};
		fd = $fopen(file_name, "r");
		$display("%d", fd);
		if(fd == 0) begin
			$display("KULULU");
			break;
		end
		j++;
		isReference = 1'b0;
		window_maker(fd, isReference);
		$fclose(fd);
	end
	
	$fclose(fd);
	$finish;
	
end
endmodule

