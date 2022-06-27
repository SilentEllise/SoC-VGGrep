#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include <string.h>
#include "encoding.h"
#include <unistd.h>
#include "stdatomic.h"


typedef   unsigned   char   byte;
int main(int argc, char **argv)
{
	// cpu run
	byte feature_size = 10;
	byte sum,a;
	byte weight3x3[32][3][3];
	byte weight1x1[16][32];
	printf("start\n");
	for (int m=0;m<32;m++) {
		for(int n=0;n<3;n++) {
			for(int k=0;k<3;k++){
				a = SRAM0_REG(0x00);
				weight3x3[m][n][k]=a;
			}
		}
	}
	for (int m=0;m<16;m++) {
		for(int n=0;n<32;n++) {
			a = SRAM0_REG(0x00);
			weight1x1[m][n] = a;
		}
	}
	for(int c = 0; c < 32; c++)
	{
	for (int i = 0; i < feature_size; i++)
	{
		for (int j = 0; j < feature_size; j++)
		{
			sum = 0;
			for (int n = 0; n < 3; n++)
			{
				for (int m = 0; m < 3; m++)
				{	
					a = SRAM0_REG(0x00);
					sum += a*weight3x3[c][n][m];
				}
			}
			SRAM0_REG(0x00) = sum;
		}
	}
	}

	for (int i = 0; i < feature_size; i++)
	{
		for (int j = 0; j < feature_size; j++)
		{
			for (int n = 0; n < 16; n++)
			{
				sum = 0;
				for (int m = 0; m < 32; m++)
				{
					a = SRAM0_REG(0x00);
					sum += a*weight1x1[n][m];
					
				}
				SRAM0_REG(0x00) = sum;
			}
		}
	}
	printf("done\n");
	return 0;
}

