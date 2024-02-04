记录学习变形金刚的心得
- Layernorm 和Batch norm的区别    
layernorm 更针对样本来计算,计算时是以个体为中心来计算. 而batchnorm则是针对某一特征,计算整个batch的内容, 计算的结果在面临抖动时会引入不必要的误差.

- mask multi-head attention
attention是可以看到所有输入的一个东西,但是在实际场景中,decoder不应该看到未来的东西, 所以decoder要通过一个mask机制来对未来的东西做修正
