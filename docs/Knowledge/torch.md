# torch入门
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
torch.take(src,tensor) # 将输入的src当成一维的,然后按照tensor中提供的索引取对应位置的元素,所得数组大小和tensor一样
torch.tile(input,tuple) #将input按照元组中每个维度copy相应次数
torch.transpose() #按照对应维度进行转置
torch.unbind(input,dim) # 按照某一个维度进行切片, 返回一个张量元组
torch.unsqueeze(input,dim)  # 对张量进行升维
torch.where(condition,x,y)  # 条件判断, 根据判断结果选择输出的值
```
### 随机种子
```python
torch.manual_seed() # 便于复现,只能保证torch和torchcuda是同一随机种子,如有numpy 需要另外设置
torch.bernoulli(input) # input是一个概率张量,输出和输入的张量大小相同,输出全是1或0
torch.normal() # 高斯分布 有不同的输入方式, 可以具体查看
torch.rand()  # 返回一个 [0,1)均匀分布的张量
torch.randint() # 返回一个整数,需要提供上下界
torch.randn()  # 返回的是高斯分布的浮点数
torch.randperm() # 返回一个(0,n-1)的随机组合
```
## Datasets & DataLoaders
### datalodars 原理
没看懂,回头再说吧
### transform
将数据进行处理,比如将label转化为one-hot值,这样以来就可以方便后续训练

## nn模块
- tips: 可以使用torchsummary实现像tensorflow一样的网络展示

```shell
pip install torchsummary
```

```python
nn.flatten() # 将start_dim 到 end_dim 合并成单一维度,默认只保留dim_0, 其他全部展开
nn.Linear()  # 就是一个仿射变换,访问weight和bias 可以通过Linear.weight和Linear.bias
#父类有一个attribute   named_parameters()

a._moudule   # 可以查看该模型的属性, 返回的是一个dict, dict里有层的名字和对应的配置信息(输入输出, 偏差等)
a.state_dict() #返回一个字典,可以查看内置的参数信息
a.parameters() # 该函数可以返回一个迭代器(不是列表, 无法用len()方法), 后面可以用一个for循环print出来,这样也可以查看数值
a.modules( )   # 同上,是用来看函数结构的
a.to(device, dtype,....) # 可以进行修改 
```

## 模型的存储与加载
```python
# 模型的保存
torch.save({
    'epoch':EPOCH,
    'model_state_dict':model.state_dict(),
    'optimizer_state_dict':optimizer.state_dict(),
    'loss':LOSS
},Path)
# 模型的读取
checkout= torch.load(PATH)
model.load_state_dict(checkpoint['model_state_dict'])
optimizer.load_state_dict(checkpoint['optimizer_state_dict'])
epoch=checkpoint['epoch']
loss=checkpoint['loss']
# 加载
model.eval()  # 可以让training参数false, 和 model.require_grad = False
```
## sequential
```python
nn.Sequential() # 可以用orderdict进行赋值,也可以直接往里填模块,用字典可以给每个层用键值命名
nn.ModuleList() # 就是把一些module放到了一起
```

- Sequential 和 ModuleList的区别主要在于, ModuleList是一个无序的列表, 只是把模块给装在一起, Sequential 是默认带有顺序的,并且自带forward方法, 而 ModuleList需要自己构造.

## Autograd
```python
# 如果a是标量无所谓,但如果a是向量的话需要传入一个和输出等大小的jacob矩阵
# 同时也要记得对向量进行梯度置零   
# 在推理时,可以整体使用 with torch.no_grad():
vec.grad.zero_()
a.backward() 
# jacob计算
jacobian(function, x)  # function 是调用函数名称(不需要加括号), x 是函数的输入
x.grad = y.backward( torch.ones_like(y))= torch.ones_like(y) @ jacobian( y,x) # @ 表示矩阵相乘
```

## train
```python
def train_loop(dataloader, model, loss_fn, optimizer):
    size = len (dataloader.dataset)
    for batch, (X, y) in enumerate (dataloader):
    # Compute prediction and loss
        pred = model (X)
        loss = loss_fn(pred, y)
        # Backpropagation
        optimizer.zez_grad()
        loss. backward
        optimizer.step()
        if batch % 100 == 0:
            loss, current = loss.item(), batch * len(X)
            print(f"loss: {loss:>7f} [{current:>5d}/{size:>5d}]")
def test_loop(dataloader, model, loss_fn):
    size = len (dataloader.dataset)
    num_batches = len (dataloader)
    test_loss, correct = 0, 0
    with torch.no_grad():
        for X, y in dataloader:
            pred = model (X)
            test_loss += loss_fn(pred, y).item()
            correct += (pred.argmax (1) == y). type(torch.float).sum().item()
            test_loss /= num_batches
            correct /= size
            print(f"Test Error: \n Accuracy: {(100*correct):>0.1f}%, Avg loss: {test_loss:>8f}\n")
```
## Embedding
对于传统的 one-hot编码,在输入较多的情况下会有一些问题
- 输入序列过长
- 较稀疏,冗余信息过多,表征能力不强
可以当作是一种全连接网络, 可以把输入的one-hot 转化为一个浮点的vector

## Dropout 机制
初衷是为了防止overfitting. 为了保证训练和推理过程中参数的期望一致, 本来是
$$
w_{infer}=pw
$$
为了保证推理时的计算较少, 将计算负担增加到训练侧, 加一个scaler
$$
w_{train} = \frac{1}{1-p} w
$$
在 transformer 中, 输出结果时会加一个dropout
## 一些loss
### Crossentropy