/*------------------------------------------------------------------------------
 * File          : test.sv
 * Project       : RTL
 * Author        : epebar
 * Creation date : Sep 2, 2022
 * Description   :
 *------------------------------------------------------------------------------*/



module test (
	input      a,
	           b,
	           c,
	output reg s1,
	           c1,
	           s2,
	           c2,
	           s3,
	           c3
);

always @(a,b)
begin
	s1 = a ^ b ;
	c1 = s1 ^ c ;
end

always @(a,b)
begin
	s2 <= a ^ b ;
	c2 <= s2 ^ c ;
end

always @(a,b,s3)
begin
	s3 <= a ^ b ;
	c3 <= s3 ^ c ;
end
endmodule
