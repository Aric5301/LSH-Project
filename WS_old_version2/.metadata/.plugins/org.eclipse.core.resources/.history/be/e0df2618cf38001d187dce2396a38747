/*------------------------------------------------------------------------------
 * File          : test_tb.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Sep 2, 2022
 * Description   :
 *------------------------------------------------------------------------------*/

module test_tb #() ();

reg a,b,c;
reg s1,c1,s2,c2,s3,c3;

test U1(.*);

initial begin
   $monitor ("@%g a = %h b = %h s1= %h c1 = %h s2 = %h c2 = %h s3 = %h c3 = %h",$time,a,b,s1,c1,s2,c2,s3,c3);
   a = 1'b0;
   b = 1'b0;
   c = 1'b0;
#50 $finish;
end

always @ (a)
  begin
	 #2 a <= ~a;
  end
always @ (b)
  begin
	 #4 b <= ~b;
  end
always @ (c)
  begin
	 #8 c <= ~c;
  end


endmodule