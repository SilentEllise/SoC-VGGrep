module counterGroup(
	input clk ,
	input rst_n ,
	
	input valid_i ,
	
	output reg enable1 ,
	output reg enable2 ,
	output reg enable3 ,
	output reg enable4 ,
	output reg enable5 ,
	output reg enable6 ,
	output reg enable7 ,
	output reg enable8 ,
	output reg enable9 ,
	
	output valid_o ,
	output reg chnl_done
);

	/* The first counter : init_counter */
	reg [6:0] init_counter ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			init_counter <= 7'd113 ;
		else
			begin
				if(valid_i==1'b1)
					begin
						if(init_counter == 7'd0)
							init_counter <= init_counter ;
						else
							init_counter <= init_counter - 1 ;
					end
				else
					init_counter <= init_counter ;
			end
	end
	
	/* The second counter : row_counter */
	reg [6:0] row_counter ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			row_counter <= 7'd0 ;
		else
			begin
				if(init_counter!=7'd0)
					row_counter <= row_counter ;
				else
					begin
						if(valid_i==1'b1)
							begin
								if(row_counter==7'd111)
									row_counter <= 7'd0 ;
								else
									row_counter <= row_counter + 1 ;
							end
						else
							row_counter <= row_counter ;
					end
			end
	end
	
	/* The third counter : column_counter */
	reg [6:0] column_counter ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			column_counter <= 7'd0 ;
		else
			begin
				if(init_counter!=7'd0)
					column_counter <= column_counter ;
				else
					begin
						if((valid_i==1'b1) && (row_counter==7'd111))
							begin
								if(column_counter==7'd111)
									column_counter <= 7'd0 ;
								else
									column_counter <= column_counter + 1 ;
							end
						else
							column_counter <= column_counter ;
					end
			end
	end
	
	/* The chnl_done signal , which is used to help controlling weight switching */
	
	always@(*)
	begin
		if(init_counter!=7'd0)
			chnl_done = 1'b0 ;
		else
			begin
				if((valid_i==1'b1) && (row_counter==7'd111) && (column_counter==7'd111))
					chnl_done = 1'b1 ;
				else
					chnl_done = 1'b0 ;
			end
	end
	
	
	/* Decide enable signal according to counters */
	always@(*)
	begin
		if(init_counter!=7'd0)
			begin
				enable1 = 1'b0 ;
				enable2 = 1'b0 ;
				enable3 = 1'b0 ;
				enable4 = 1'b0 ;
				enable5 = 1'b0 ;
				enable6 = 1'b0 ;
				enable7 = 1'b0 ;
				enable8 = 1'b0 ;
				enable9 = 1'b0 ;
			end
		else
			begin
				case(column_counter)
					7'd0 :
						begin
							case(row_counter)
								7'd0 : 
									begin
										enable1 = 1'b1 ;
										enable2 = 1'b1 ;
										enable3 = 1'b0 ;
										enable4 = 1'b1 ;
										enable5 = 1'b1 ;
										enable6 = 1'b0 ;
										enable7 = 1'b0 ;
										enable8 = 1'b0 ;
										enable9 = 1'b0 ;
									end
								7'd111 : 
									begin
										enable1 = 1'b0 ;
										enable2 = 1'b1 ;
										enable3 = 1'b1 ;
										enable4 = 1'b0 ;
										enable5 = 1'b1 ;
										enable6 = 1'b1 ;
										enable7 = 1'b0 ;
										enable8 = 1'b0 ;
										enable9 = 1'b0 ;
									end
								default: 
									begin
										enable1 = 1'b1 ;
										enable2 = 1'b1 ;
										enable3 = 1'b1 ;
										enable4 = 1'b1 ;
										enable5 = 1'b1 ;
										enable6 = 1'b1 ;
										enable7 = 1'b0 ;
										enable8 = 1'b0 ;
										enable9 = 1'b0 ;
									end
							endcase
						end
					7'd111 : 
						begin
							case(row_counter)
								7'd0 : 
									begin
										enable1 = 1'b0 ;
										enable2 = 1'b0 ;
										enable3 = 1'b0 ;
										enable4 = 1'b1 ;
										enable5 = 1'b1 ;
										enable6 = 1'b0 ;
										enable7 = 1'b1 ;
										enable8 = 1'b1 ;
										enable9 = 1'b0 ;
									end
								7'd111 : 
									begin
										enable1 = 1'b0 ;
										enable2 = 1'b0 ;
										enable3 = 1'b0 ;
										enable4 = 1'b0 ;
										enable5 = 1'b1 ;
										enable6 = 1'b1 ;
										enable7 = 1'b0 ;
										enable8 = 1'b1 ;
										enable9 = 1'b1 ;
									end
								default: 
									begin
										enable1 = 1'b0 ;
										enable2 = 1'b0 ;
										enable3 = 1'b0 ;
										enable4 = 1'b1 ;
										enable5 = 1'b1 ;
										enable6 = 1'b1 ;
										enable7 = 1'b1 ;
										enable8 = 1'b1 ;
										enable9 = 1'b1 ;
									end
							endcase
						end
					default :
						begin
							case(row_counter)
								7'd0 : 
									begin
										enable1 = 1'b1 ;
										enable2 = 1'b1 ;
										enable3 = 1'b0 ;
										enable4 = 1'b1 ;
										enable5 = 1'b1 ;
										enable6 = 1'b0 ;
										enable7 = 1'b1 ;
										enable8 = 1'b1 ;
										enable9 = 1'b0 ;
									end
								7'd111 : 
									begin
										enable1 = 1'b0 ;
										enable2 = 1'b1 ;
										enable3 = 1'b1 ;
										enable4 = 1'b0 ;
										enable5 = 1'b1 ;
										enable6 = 1'b1 ;
										enable7 = 1'b0 ;
										enable8 = 1'b1 ;
										enable9 = 1'b1 ;
									end
								default: 
									begin
										enable1 = 1'b1 ;
										enable2 = 1'b1 ;
										enable3 = 1'b1 ;
										enable4 = 1'b1 ;
										enable5 = 1'b1 ;
										enable6 = 1'b1 ;
										enable7 = 1'b1 ;
										enable8 = 1'b1 ;
										enable9 = 1'b1 ;
									end
							endcase
						end
				endcase
			end
	end
	
	/* generate valid signal sent to multiplierBar */
	
	reg [6:0] row_counter_buf ;
	
	assign valid_o = (row_counter_buf == row_counter)? 0 : 1 ;
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			row_counter_buf <= 7'h0 ;
		else
			row_counter_buf <= row_counter ;
	end
	
	
	
	

endmodule

