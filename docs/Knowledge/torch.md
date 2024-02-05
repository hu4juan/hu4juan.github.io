# Torch入门
## conda基础
```shell
conda env list
conda list 
conda create -n env-name python=3.6
conda remove -n env-name --all
```
## tensor基础
### tensor的生成
```python
a=[[1,2.],[3,4]]
# 将列表转化为 tensor, a可以是numpy array 或者 list 
b=torch.tensor(a)    #torch.from_numpy()  没有必要,可以直接用torch.tensor()
```
### tensor的查看
```python
# tensor的属性
a.dtype  # 数据类型
a.shape  # 形状
a.device # 在哪个设备上

# tensor的一些查看函数
torch.is_tensor(a)  
torch.is_complex(a)
torch.is_nonzero(a)
torch.is_floating_point(a)
torch.numel(a)  # 返回tensor中元素的个数
torch.set_default_tensor_type()# 设置默认数据类型
```
### tensor的一些操作
```python
# 生成形状相同的tensor
a=torch.ones_like(b)
a=torch.zeros_like(b)
a=torch.rand_like(b)
# 生成目标形状的tensor  m可以是元组也可以是列表
a=torch.rand(m)
a=torch.ones(m)
a=torch.zeros(m)
#生成一个索引数组,返回的是一个 1-D tensor,前闭后开,但是range会比arange多生成一个
torch.arange()   # 默认是int
torch.range()    # 默认是float
torch.linspace() # 线性
torch.logspace() # 对数的
# 创建矩阵
torch.eye()  # 创建二维单位阵
torch.full(size,fill_value)   # 创建一个用fill_value填充的,大小为size的矩阵
torch.full_like(a,fill_value) # 创建一个用fill_value填充的,大小和a相同的矩阵
# 矩阵拼接,合成等
torch.cat() # 需要除了拼接的维度以外,其他维度是same的. 根据dim选取维度, 个人理解,dim就是中括号的层数,从外往里, 从0开始加
torch.chunk() # 把tensor按照dim均等分割,除不尽就剩着  
torch.gather(tensor,dim,index) # 对一个矩阵进行操作 output[i][j][k]= input[index[i][j][k]][j][k]  对于选定的index维度按照index进行指定,从左往右,从零开始依次增大
torch.reshape(tensor, list/tuple ) # 重新排列, (-1,) 表示变成1-D
```
