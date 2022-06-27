import sys

with open("./output_data_ref.txt", 'r') as f1:
    ref = []
    for line1 in f1.readlines():
        ref.append(line1.strip())

with open("./output_data_icb.txt", 'r') as f2:
    real = []
    for line2 in f2.readlines():
        real.append(line2.strip())

p = 0
f = 0

if(len(ref)!=len(real)):
    print("*********The number of output is wrong!!!********")
else:
    for i in range(50176):
        if(ref[i]==real[i]):
            p = p + 1
        else:
            f = f + 1
            print("the %s result is wrong" %(i+1))
    if(p==50176):
        print("--------The results are all correct!!!--------")
    else:
        print("********There are %d wrong results********" %f)
