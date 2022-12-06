/*------------------------------------------------------------------------------
 * File          : input_handler.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Oct 15, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module input_handler #(
	parameter WINDOW_SIZE              = 128,
	          KMER_SIZE                = 16,
	          SKETCH_SIZE              =16,
	          NUM_OF_BUCKETS           =256,
	          LOG2_NUM_OF_BUCKETS      =8,
	          BUCKET_SIZE              =16,
	          MAX_WINDOWS_IN_REFERENCE = 1024
) ();

// variables of main

logic isReference;

int temp;
int fd;
int i = 0;
int j = 0;
int k = 0;
int dummy;

string file_name;
string file_number;

// other modules ports
logic                            clk;
logic                            reset_hash_table;
logic                            is_insert;
logic                            is_query;
logic  [31:0]                    window_id;
logic  [LOG2_NUM_OF_BUCKETS-1:0] hashed_sketch [0:SKETCH_SIZE-1];             // vector of SKETCH_SIZE size with each value representing the value of the K-mer after h2 is applied on it
logic [31:0]                     count_bus     [0:MAX_WINDOWS_IN_REFERENCE-1]; // currently supports up to 1024 windows
logic                        	 reset_window_hasher;
logic                        	 ready_for_hashing;
logic  [1:0]                     window       [0:WINDOW_SIZE-1];// consists of WINDOW_SIZE kmers
logic                            hashing_is_done;                  // turns on for one clock cycle when ready


// turning sections from read and reference files to windows, handling required flags
task window_maker(int fd, logic isReference);
	
	// flags reset
	is_insert = 1'b0;
	is_query = 1'b0;
	
	while(!($feof(fd))) begin
		ready_for_hashing = 1'b0;
		reset_window_hasher = 1'b1;
		#1
				reset_window_hasher = 1'b0;
		
		// assigning to window according to nucleotides in file
		for(int j = 0 ; j < WINDOW_SIZE ; j++) begin
			temp = $fgetc(fd);
			case (temp)
				"A": window[j] = 2'b00;
				"C": window[j] = 2'b01;
				"G": window[j] = 2'b10;
				"T": window[j] = 2'b11;
			endcase
			
		end
		window_id = i;
		ready_for_hashing = 1'b1;
		while (!(hashing_is_done)) begin
			#2;
		end
		if (isReference) begin
			is_insert = 1'b1;
			#2;
		end
		else
			is_query = 1'b1;
			#2

				if(!($feof(fd))) begin
					i++;
					dummy = $fseek(fd, (WINDOW_SIZE - KMER_SIZE + 1) * i, 0);
				end
	end
endtask

always #1 clk=~clk; // creation of clock

window_hasher window_hasher (
	//outputs
	.hashed_sketch(hashed_sketch),
	.hashing_is_done(hashing_is_done),
	
	//inputs
	.clk (clk),
	.reset_window_hasher (reset_window_hasher),
	.ready_for_hashing (ready_for_hashing),
	.window (window)
	
);

hash_table hash_table (
	//outputs
	.count_bus(count_bus),
	
	//inputs
	.clk (clk),
	.reset_hash_table (reset_hash_table),
	.is_insert(is_insert),
	.is_query(is_query),
	.window_id (window_id),
	.hashed_sketch(hashed_sketch)

);

initial begin
	reset_hash_table = 1'b1;
	#2
	reset_hash_table = 1'b0;
	
	// opening reference file
	fd = $fopen("reference_sv", "r");
	isReference = 1'b1;
	window_maker(fd, isReference);
	
	// opening read files
	while (1'b1) begin
		$sformat(file_number, j);
		file_name = {"read_sv_", file_number};
		if((fd = $fopen(file_name, "r")) == 0 ) begin
			break;
		end
		j++;
		isReference = 1'b0;
		window_maker(fd, isReference);
	end
	
	
	$fclose(fd);
end
endmodule
