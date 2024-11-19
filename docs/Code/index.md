# C++ 基础知识
记录学习算法过程中的一些知识点
## STL container
### Vector
- vector 底层仍是定长数组，善用 `resize()` 和 `reserve()` 可以使 `vector` 的效率与定长数组不会有太大差距。
### Array
- `array` 开满优化可以当成原生数组来看待
### Deque
- 有`insert()`方法, 可以在迭代器某个位置插入元素，并且可以插入多个
### list
- 迭代器，长度，元素增删和修改与`deque`相同。 
### set 
- 模板里边是可排序的东西
- `set` 自带的 `lower_bound` 和 `upper_bound` 的时间复杂度为$O(\log n)$。但使用 `algorithm` 库中的 `lower_bound` 和 `upper_bound` 函数对 ``set` 中的元素进行查询，时间复杂度为$O(n)$。
- `set`没有提供自带的`nth_element`。使用 `algorithm` 库中的`nth_element`查找第 k 大的元素时间复杂度为 $O(n)$。如果需要实现平衡二叉树所具备的 $O(\log n)$ 查找第 k 大元素的功能，需要自己手写平衡二叉树或权值线段树，或者选择使用 `pb_ds` 
- 可以自定义比较器例如。
```cpp linenums="1"
struct cmp {
  bool operator()(int a, int b) { return a > b; }
};
set<int, cmp> s;
```
### map
- 模板是键值对，key要支持`operator <`
- `map` 中不会存在键相同的元素，`multimap` 中允许多个元素拥有同一键。`multimap` 的使用方法与 `map` 的使用方法基本相同。
- 正是因为`multimap` 允许多个元素拥有同一键的特点，`multimap` 并没有提供给出键访问其对应值的方法。
- 在利用下标访问 `map` 中的某个元素时，如果 `map` 中不存在相应键的元素，会自动在 `map` 中插入一个新元素，并将其值设置为默认值（对于整数，值为零；对于有默认构造函数的类型，会调用默认构造函数进行初始化）。当下标访问操作过于频繁时，容器中会出现大量无意义元素，影响 `map` 的效率。因此一般情况下推荐使用`find()`函数来寻找特定键的元素。