#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include <string.h>
#include "encoding.h"
#include <unistd.h>
#include "stdatomic.h"

#define SLAVE_ADDR      0x50 // 7'b1010_000

void i2c_init(void);
uint8_t OV_WriteReg(uint8_t regID, uint8_t regDat);
uint8_t OV_ReadReg(uint8_t regID, uint8_t *regDat);

void handle_m_ext_interrupt(){
  printf("irq handle\n");
  I2C_REG(I2C_REG_CTR) = 0x80;//i2c enable and irq enable  //me:i2c enable and irq unenable
 }


void i2c_init(void)
{
  
  //printf("i2c init\n"); //scl频率配置
  I2C_REG(I2C_REG_PRERlo) = 0x7d ;//400KHZ
  I2C_REG(I2C_REG_PRERhi) = 0x00 ;//
  I2C_REG(I2C_REG_CTR) = 0xc0;//i2c enable and irq enable
}

//phase 1 读ID
//phase 2 写地址
//phase 3 写数据
//写8'h60,读为8'h61 , 8'h60即ID地址的读写控制位为0，8'h61即ID地址的读写控制位为1
//
//配置寄存器
uint8_t OV_WriteReg(uint8_t regID, uint8_t regDat)
{
        printf("write addr : %x ,write data :%x \n",regID,regDat);
        //phase 1
        I2C_REG(I2C_REG_TXR)= SLAVE_ADDR<<1 +0 ;// 0 = write
        I2C_REG(I2C_REG_CR) = 0x90;     //1001 0000   // start bit and WR bit
        while ((I2C_REG(I2C_REG_SR)&0x02)!=0x00)
        {

        }
        printf("phase 1 cmd sent\n");

        //phase 2
        I2C_REG(I2C_REG_TXR)= regID ;//将要发送的ID装进寄存器
        I2C_REG(I2C_REG_CR) = 0x10;
        while ((I2C_REG(I2C_REG_SR)&0x02)!=0x00)
        { }
        printf("phase 2 cmd sent\n");

        //phase 3
        I2C_REG(I2C_REG_TXR)=regDat; //将要发送的数据写进寄存器
        I2C_REG(I2C_REG_CR) = 0x10;
        while ((I2C_REG(I2C_REG_SR)&0x02)!=0x00)
        { }

        // phase 4
        I2C_REG(I2C_REG_CR)=0x40; 
        printf("stop \n");

        return 0;
}

//读寄存器分两次两个阶段

 //   写器件地址，写要读的寄存器地址
 //   写器件地址+1（表示读命令），读取数据，最后在发送NA信号
uint8_t OV_ReadReg(uint8_t regID, uint8_t *regDat)
{
        //phase 1
        I2C_REG(I2C_REG_TXR)= SLAVE_ADDR<<1 + 1 ;// 1 = read
        I2C_REG(I2C_REG_CR) = 0x98;//发送start标志
        while (I2C_REG(I2C_REG_SR)&0x02!=0x00)
        {

        }// 0 means transfer done

        //phase 2
        I2C_REG(I2C_REG_TXR)=regID;//将要发送的ID装进寄存器
        I2C_REG(I2C_REG_CR) = 0x10;
        while ((I2C_REG(I2C_REG_SR)&0x02)!=0x00)
        {

        }

        I2C_REG(I2C_REG_TXR)=(0x43);
        I2C_REG(I2C_REG_CR) = 0x90;
        while ((I2C_REG(I2C_REG_SR)&0x02)!=0x00)
        {

        }
        I2C_REG(I2C_REG_CR) = 0x20;
        while ((I2C_REG(I2C_REG_SR)&0x02)!=0x00)
        {

        }

        *regDat=I2C_REG(I2C_REG_RXR);

        I2C_REG(I2C_REG_CR) = 0x68;


        return 0;
} 

typedef unsigned char byte;
int main(int argc, char **argv)
{
	set_csr(mie,MIP_MEIP);
	set_csr(mstatus,MSTATUS_MIE);
	//int a;
	//i2c_init();
        //SPI0_REG(0x00)=0xff;
	//SPI0_REG(0x00) = 0x30000100;
	//SPI0_REG(0x10) = 0x30000000;
	//SPI0_REG(0x0c) = 0x30000000;
	//SPI0_REG(0x08) = 1; //start signal
        
        //SRAM_REG(0x00) = 0x13e90300;
        //SRAM_REG(0x10) = 0xf4e4e406;
        SPI0_REG(0x08) = 1; //start signal
        //a = SPI0_REG(0x00);
        //uint8_t regDat = 0x80;
	//OV_WriteReg(0x12,regDat);
        
        //CPU run test
        /*int feature_size = 28;
        byte sum;
	byte data[32][feature_size][feature_size];
	byte out_data[32][feature_size][feature_size];
	byte out_data1x1[16][feature_size][feature_size];
	byte weight3x3[32][3][3];
	byte weight1x1[16][32];
	printf("start\n");
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
					sum += data[c][i+n][j+m]*weight3x3[c][n][m];
				}
			}
			out_data[c][i][j] = sum>=128?0:sum;
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
					sum += out_data[m][i][j]*weight1x1[n][m];
					
				}
				out_data1x1[n][i][j] = sum;
			}
		}
	}
	printf("done\n");*/
	return 0;
}
