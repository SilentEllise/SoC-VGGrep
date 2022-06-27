`timescale 1ns / 1ps
////////////////////////

module golden_model();


logic signed [7:0] fm_mem  [401408] ;
logic signed [7:0] fm_padding [32][114][114] ;
logic signed [7:0] w33_mem [288] ;
logic signed [7:0] w11_mem [512] ;

logic signed [7:0] conv_33 [32][112][112] ;
logic signed [7:0] conv_11 [16][112][112] ;
logic signed [7:0] w33 [32][3][3] ;
logic signed [7:0] w11 [16][32] ;

logic signed [31:0] mul_1 ;
logic signed [31:0] mul_2 ;
logic signed [31:0] mul_3 ;
logic signed [31:0] mul_4 ;
logic signed [31:0] mul_5 ;
logic signed [31:0] mul_6 ;
logic signed [31:0] mul_7 ;
logic signed [31:0] mul_8 ;
logic signed [31:0] mul_9 ;
logic signed [31:0] mul_sum ;

logic signed [31:0] cb_1 ;
logic signed [31:0] cb_2 ;
logic signed [31:0] cb_3 ;
logic signed [31:0] cb_4 ;
logic signed [31:0] cb_ex ;
logic signed [7:0] cb_sum ;
logic signed [31:0] cb_sum_ex ;

logic signed [31:0] sram_ex ;
logic signed [31:0] sram_sum ;

wire signed [7:0] ob1 ;
wire signed [7:0] ob2 ;
wire signed [7:0] ob3 ;
wire signed [7:0] ob4 ;
wire signed [7:0] ob5 ;
wire signed [7:0] ob6 ;
wire signed [7:0] ob7 ;
wire signed [7:0] ob8 ;
wire signed [7:0] ob1_33_ch1 ;
wire signed [7:0] ob2_33_ch1 ;
wire signed [7:0] ob3_33_ch1 ;
wire signed [7:0] ob4_33_ch1 ;
wire signed [7:0] ob1_33_ch2 ;
wire signed [7:0] ob2_33_ch2 ;
wire signed [7:0] ob3_33_ch2 ;
wire signed [7:0] ob4_33_ch2 ;
wire signed [7:0] ob1_33_ch3 ;
wire signed [7:0] ob2_33_ch3 ;
wire signed [7:0] ob3_33_ch3 ;
wire signed [7:0] ob4_33_ch3 ;
wire signed [7:0] ob1_33_ch4 ;
wire signed [7:0] ob2_33_ch4 ;
wire signed [7:0] ob3_33_ch4 ;
wire signed [7:0] ob4_33_ch4 ;

assign ob1_33_ch1 = conv_33[0][0][0] ;
assign ob2_33_ch1 = conv_33[0][0][1] ;
assign ob3_33_ch1 = conv_33[0][0][2] ;
assign ob4_33_ch1 = conv_33[0][0][3] ;
assign ob1_33_ch2 = conv_33[1][0][0] ;
assign ob2_33_ch2 = conv_33[1][0][1] ;
assign ob3_33_ch2 = conv_33[1][0][2] ;
assign ob4_33_ch2 = conv_33[1][0][3] ;
assign ob1_33_ch3 = conv_33[2][0][0] ;
assign ob2_33_ch3 = conv_33[2][0][1] ;
assign ob3_33_ch3 = conv_33[2][0][2] ;
assign ob4_33_ch3 = conv_33[2][0][3] ;
assign ob1_33_ch4 = conv_33[3][0][0] ;
assign ob2_33_ch4 = conv_33[3][0][1] ;
assign ob3_33_ch4 = conv_33[3][0][2] ;
assign ob4_33_ch4 = conv_33[3][0][3] ;

assign ob1 = conv_11[0][0][0] ;
assign ob2 = conv_11[0][0][1] ;
assign ob3 = conv_11[0][0][2] ;
assign ob4 = conv_11[0][0][3] ;
assign ob5 = conv_11[0][0][4] ;
assign ob6 = conv_11[0][0][5] ;
assign ob7 = conv_11[0][0][6] ;
assign ob8 = conv_11[0][0][7] ;

integer file_write ;


initial
begin
	$readmemb ( "D:/MONE/SoC/Final_project/goldenModel/goldenModel_SV/featureMap.txt" , fm_mem );
	$readmemb ( "D:/MONE/SoC/Final_project/goldenModel/goldenModel_SV/weight33.txt" , w33_mem );
	$readmemb ( "D:/MONE/SoC/Final_project/goldenModel/goldenModel_SV/weight11.txt" , w11_mem );
	file_write = $fopen("D:/MONE/SoC/Final_project/goldenModel/goldenModel_SV/output_sv.txt","w") ;
	for(int ch=0 ; ch<32 ; ch++)
	begin
		for(int r=0 ; r<114 ; r++)
			begin
				for(int c=0 ; c<114 ; c++)
					begin
						fm_padding[ch][r][c] = 8'b00000000 ;
					end
			end
	end
	for(int ch=0 ; ch<16 ; ch++)
	begin
		for(int r=0 ; r<112 ; r++)
			begin
				for(int c=0 ; c<112 ; c++)
					begin
						conv_11[ch][r][c] = 8'b00000000 ;
					end
			end
	end
	for(int ch=0 ; ch<32 ; ch++)
	begin
		for(int r=0 ; r<3 ; r++)
			begin
				for(int c=0 ; c<3 ; c++)
					begin
						w33[ch][r][c] = w33_mem[ch*9 + r*3 + c] ;
					end
			end
	end
	for(int ch_o=0 ; ch_o<16 ; ch_o++)
	begin
		for(int ch_i=0 ; ch_i<32 ; ch_i++)
			begin
				w11[ch_o][ch_i] = w11_mem[ch_o*32 + ch_i] ;
			end
	end

	for(int ch=0 ; ch<32 ; ch++)
	begin
		for(int r=0 ; r<112 ; r++)
			begin
				for(int c=0 ; c<112 ; c++)
					begin
						fm_padding[ch][r+1][c+1] = fm_mem[ch*112*112 + r*112 + c] ;
					end
			end
	end
	
	#10
	
	for(int ch=0 ; ch<32 ; ch++)
	begin
		for(int r=1 ; r<113 ; r++)
			begin
				for(int c=1 ; c<113 ; c++)
					begin
						mul_1 = w33[ch][2][2] * fm_padding[ch][r-1][c-1] ;
						mul_2 = w33[ch][2][1] * fm_padding[ch][r-1][c-0] ;
						mul_3 = w33[ch][2][0] * fm_padding[ch][r-1][c+1] ;
						mul_4 = w33[ch][1][2] * fm_padding[ch][r-0][c-1] ;
						mul_5 = w33[ch][1][1] * fm_padding[ch][r-0][c-0] ;
						mul_6 = w33[ch][1][0] * fm_padding[ch][r-0][c+1] ;
						mul_7 = w33[ch][0][2] * fm_padding[ch][r+1][c-1] ;
						mul_8 = w33[ch][0][1] * fm_padding[ch][r+1][c-0] ;
						mul_9 = w33[ch][0][0] * fm_padding[ch][r+1][c+1] ;
						mul_sum = mul_1 + mul_2 + mul_3 + mul_4 + mul_5 + mul_6 + mul_7 + mul_8 + mul_9 ;
						conv_33[ch][r-1][c-1] = {mul_sum[31],mul_sum[13:7]} ;
					end
			end
	end
	
	#10
	
	for(int ch=0 ; ch<32 ; ch++)
	begin
		for(int r=0 ; r<112 ; r++)
			begin
				for(int c=0 ; c<112 ; c++)
					begin
						if(conv_33[ch][r][c][7]==1'b1)
							conv_33[ch][r][c] = 8'b00000000 ;
					end
			end
	end
	
	
	#10
	for(int ch_o=0 ; ch_o<16 ; ch_o++)
	begin
		for(int r=0 ; r<112 ; r++)
		begin
			for(int c=0 ; c<112 ; c++)
			begin
				for(int ch_i=0 ; ch_i<8 ; ch_i++) // 8 = 32 / 4
				begin
					cb_1 = conv_33[ch_i*4+0][r][c] * w11[ch_o][ch_i*4+0] ;
					cb_2 = conv_33[ch_i*4+1][r][c] * w11[ch_o][ch_i*4+1] ;
					cb_3 = conv_33[ch_i*4+2][r][c] * w11[ch_o][ch_i*4+2] ;
					cb_4 = conv_33[ch_i*4+3][r][c] * w11[ch_o][ch_i*4+3] ;
					cb_ex = cb_1 + cb_2 + cb_3 + cb_4 ; 
					cb_sum = {cb_ex[31],cb_ex[13:7]} ;
					sram_ex = {{24{conv_11[ch_o][r][c][7]}},conv_11[ch_o][r][c][7:0]} ;
					cb_sum_ex = {{24{cb_sum[7]}},cb_sum[7:0]} ;
					sram_sum = sram_ex + cb_sum_ex ;
					conv_11[ch_o][r][c] = {sram_sum[31],sram_sum[6:0]} ;
				end
			end
		end
	end
	
	#10
	for(int ch_o=0 ; ch_o<16 ; ch_o++)
	begin
		for(int r=0 ; r<112 ; r++)
			begin
				for(int c=0 ; c<28 ; c++) // 28 = 112/4
					begin
						$fwrite(file_write,"%b",conv_11[ch_o][r][c*4+0]) ;
						$fwrite(file_write,"%b",conv_11[ch_o][r][c*4+1]) ;
						$fwrite(file_write,"%b",conv_11[ch_o][r][c*4+2]) ;
						$fwrite(file_write,"%b",conv_11[ch_o][r][c*4+3]) ;
						$fwrite(file_write,"\n") ;
					end
			end
	end
	
	
end





















endmodule