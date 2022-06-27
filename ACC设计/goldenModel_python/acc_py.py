import torch.nn as nn
import torch
import numpy as np
import torch.nn.functional as F

input = torch.randint(-10, 10, [1, 64, 56, 56])
print(input.shape)
print('input', input)
input1 = np.array(input)
input2 = input1.reshape(-1, 1)
np.savetxt('input.txt', input2)

kernel3x3 = torch.randint(-10, 10, [64, 64, 3, 3])
print('kernel3x3', kernel3x3)
a = np.array(kernel3x3)
b = a.reshape(-1, 1)
np.savetxt('kernel3x3.txt', b)

kernel1x1 = torch.randint(-10, 10, [64, 64, 1, 1])
print('kernel1x1', kernel1x1)
c = np.array(kernel1x1)
d = c.reshape(-1, 1)
np.savetxt('kernel1x1.txt', d)

branch3x3 = F.conv2d(input, kernel3x3, stride=1, padding=1)
branch1x1 = F.conv2d(input, kernel1x1, stride=1, padding=0)
output = input + branch3x3 + branch1x1

print(output.shape)
print('output', output)
e = np.array(output)
f = e.reshape(-1, 1)
np.savetxt('output.txt', f)



