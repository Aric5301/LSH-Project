/*------------------------------------------------------------------------------
 * File          : input_handler_tb.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Nov 29, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module input_handler_tb #() ();
$monitor ("@%g clk= %b reset= %b, isInsert= %b, isQuery= %b, windowID= %d, theTable[0][0]= %d, tableLength[0]= %d, tableLength[1]= %d, countBus[0]= %d, countBus[14]= %d",
		$time,clk,reset,isInsert,isQuery, windowID, theTable[0][0], tableLength[0], tableLength[1], countBus[0], countBus[14]);


clk = 1'b0;
reset = 1'b0;
isInsert = 1'b0;
isQuery = 1'b0;
windowID = 0;

hashedSketch[0] = 8'd0;
hashedSketch[1] = 8'd0;
hashedSketch[2] = 8'd0;
hashedSketch[3] = 8'd0;
hashedSketch[4] = 8'd0;
hashedSketch[5] = 8'd0;
hashedSketch[6] = 8'd0;
hashedSketch[7] = 8'd0;
hashedSketch[8] = 8'd0;
hashedSketch[9] = 8'd0;
hashedSketch[10] = 8'd0;
hashedSketch[11] = 8'd0;
hashedSketch[12] = 8'd0;
hashedSketch[13] = 8'd0;
hashedSketch[14] = 8'd0;
hashedSketch[15] = 8'd0;

#2;

reset = 1'b1;
#2;
reset = 1'b0;
#2;
windowID = 14;
isInsert = 1'b1;
clk = 1'b1;
#2;
windowID = 0;
isInsert = 1'b0;
clk = 1'b0;
#2;
isQuery = 1'b1;
clk = 1'b1;
#2;
isQuery = 1'b0;
clk = 1'b0;
#2;

$finish;
end

endmodule