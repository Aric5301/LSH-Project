/*------------------------------------------------------------------------------
 * File          : input_handler.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Oct 15, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module input_handler ();
integer fd;

initial begin
	fd = $fopen("my_file.txt", "rw");
	$fwrite(fd, "Aric ah\n");
	$fwrite(fd, "Ya Aric\n");
	$fwrite(fd, "Eich atta\n");
	$fwrite(fd, "Kaze totach\n");
	
	while (! $feof(fd)) begin
		$fgets(str, fd);
		$display("%0s", str);
	end
	$fclose(fd);
end
endmodule