 
# loss function
## Cross entropy

$$
H(p,q)=-\int_{\mathcal{X}}P(x)\log Q(x)dr(x)
$$

```python
# input shape = [batch_size, num_class, dimension(用于描述更多变量维度下的分布)]
# target shape
# 1. batchsize大小的只标记index(上界为num_class)的数组
# 2. input形状相同的概率分布
loss = nn.crossentropy(input, target)
```
## Negative log likelihood
负对数似然和交叉熵某种意义上是同一个东西

$$
L= \sum -\omega_{y_n}\log(\Pr (x_n ,y_n))  
$$

```python
# input 需要是对数概率
# target 只能是index 整型
loss=nn.NLLLoss(input, target)
```
## Kullback-Leibler divergence
对于相同概率空间$\mathcal{X}$上的离散的概率分布$P$和 $Q$, 采用KL散度来衡量从$Q$到$P$的相对熵,其中 $P(x)$是真实分布, $Q(x)$是预测分布 

\begin{aligned}
D_{\mathrm{KL}}(P\parallel Q) &=\sum_{x\in\mathcal{X}}P(x)\log\biggl(\frac{P(x)}{Q(x)}\biggr)\\
&=-\sum_{x\in\mathcal{X}}P(x)\log\biggl(\frac{Q(x)}{P(x)}\biggr)\\
L(y_\mathrm{pred},\mathrm{~}y_\mathrm{true}) &=y_\mathrm{true}\cdot\log\frac{y_\mathrm{true}}{y_\mathrm{pred}}=y_\mathrm{true}\cdot(\log y_\mathrm{true}-\log y_\mathrm{pred})
\end{aligned}

```python
# input 和 target是形状相同的两个概率分布张量
loss= nn.KLDivLoss(input , target)
```
!!! note "交叉熵和KL散度之间的关系"
    \begin{aligned}
        CE &= IE + D_{\mathrm{KL}}(P\parallel Q)\\
        CE &= H(P,Q)\\
        IE &= \sum_{x\in \mathcal{X}}P(x)\log P(x)
    \end{aligned}

    因为信息熵是const,所以损失函数采用交叉熵和KL散度没太大关系
## Binary cross entropy
$$
l_n= \omega _n ( y_n \log x_n + (1- y_n ) \log(1- x_n ))
$$
```python
# target 和 input 形状相同, 
# input经过sigmoid处理,多用于二元分类的情况
# target 是整型索引
loss= nn.BCELoss(input, target)
```
