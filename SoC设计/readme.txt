1. 替换原有的platform.h
位置：/home/riscv/soc/demo_e200/hbird-e-sdk-master/bsp/hbird-e200/env
2.替换/home/riscv/soc/demo_e200/hbird-e-sdk-master/software中的demo_i2c文件夹
3.替换/home/riscv/soc/demo_e200/rtl/e203/中的subsys文件夹（加速器相关文件包含其中）
4.在/home/riscv/soc/demo_e200/rtl/e203/general中添加sram1.v和sram2.v
5.替换/home/riscv/soc/demo_e200中的tb文件夹
=====================================================
**
在test_result中的compare.py用于将实际写回SRAM1的数据与理论输出数据相比较，结果均正确。
**
波形文件位于fsdb文件夹中。