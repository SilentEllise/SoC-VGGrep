module mux8(
	input [3:0] select ,
	input [63:0] in_1 ,
	input [63:0] in_2 ,
	input [63:0] in_3 ,
	input [63:0] in_4 ,
	input [63:0] in_5 ,
	input [63:0] in_6 ,
	input [63:0] in_7 ,
	input [63:0] in_8 ,
	
	output reg [63:0] out
);

always@(*)
begin
	case(select)
		4'b0000 : out = in_1 ;
		4'b0001 : out = in_2 ;
		4'b0010 : out = in_3 ;
		4'b0011 : out = in_4 ;
		4'b0100 : out = in_5 ;
		4'b0101 : out = in_6 ;
		4'b0110 : out = in_7 ;
		4'b0111 : out = in_8 ;
		default : out = in_1 ;
		
	endcase
end

endmodule

