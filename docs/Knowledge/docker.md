# Docker
记录docker的一些命令
## docker命令
### 帮助命令
```shell
docker version 
docker info
docker 命令 --help
``` 
### 镜像命令
```shell
docker images       # 显示主机上的所有镜像   
docker search 镜像名 # 在dockerhub 搜索镜像 
docker pull 镜像名   #下载镜像 
docker rmi          #删除镜像 
```
### 容器命令
```shell
docker run 镜像id   # 新建容器并启动
docker ps          # 列出所有运行的容器 
docker stats      # 查看cpu占用
docker rm 容器id    # 删除指定容器
	# 删除所有容器
    docker rm -f $(docker ps -aq)  	 #删除所有的容器
	docker ps -a -q|xargs docker rm  #删除所有的容器
#启动和停止容器
docker start 容器id	    # 启动容器
docker restart 容器id	# 重启容器
docker stop 容器id	    # 停止当前正在运行的容器
docker kill 容器id	    # 强制停止当前容器
#退出容器
exit 		# 容器停止并退出
ctrl +P +Q  # 容器不停止退出 
```
### 其他命令
```shell
docker logs 		  # 查看日志
docker inspect 容器id  # 查看镜像的元数据
docker run -d 镜像名   # 后台启动命令
docker top 容器id 	   # 查看容器中进程信息ps
docker exec 		  # 进入当前容器后开启一个新的终端，可以在里面操作。（常用）
docker attach 		  # 进入容器正在执行的终端
docker cp 容器id:容器内路径  主机目的路径 # 从容器内拷贝到主机上
```
### 实战
```shell
# -d 后台运行 -p 宿主机端口 : 容器内部端口
docker run -d --name 容器名 -p 主机端口:容器内端口 镜像名
# --rm 用完就删
docker run -it --rm tomcat:9.0
```
## 提交
```shell
# 容器ID是需要打包的容器的ID
docker commit -m="提交的信息" -a= "author" 容器ID 目标镜像名:[TAG]
```
## 容器数据卷
```shell
# docker run -it -v /home/ceshi:/home 如果本地没有这条命令执行后会自动创建  
docker run -it -v 主机目录:容器目录
-v 容器内路径           # 匿名挂载
-v 卷名:容器内路径       # 具名挂载
-v 宿主机路径:容器内路径  # 指定路径挂载
容器内路径:ro  #read only 容器只能读,修改要靠宿主机
容器内路径:rw  # read and write
--volumes-from 容器名 # 和别的容器公用挂载卷
```
## dockerfile

```shell
FROM       # 基础镜镜像，一切从这里开始构建
MAINTAINER # 镜像是谁写的，姓名+邮箱
RUN        # 镜像构建的时候需要运行的命令
COPY       # 把本地的东西copy进去, README.txt
ADD        # 添加内容
WORKDIR    # 镜像的工作目录
VOLUME     # 挂载的目录
EXPOSE     # 暴露端口配置
CMD        # 指定容器启动时运行的命令,只有最后一个会生效
ENTRYPOINT # 容器开始时要运行的命令, 可追加命令
ENV        # 构建的时候设置环境变量 
docker build -f 文件路径 -t 镜像名:tag . # 上下文路径,记得写 
docker push # 需要登录
```
## docker 网络 
采用了 veth-pair技术, 利用docker0构造网口对.可实现不同容器之间的直接相连 
```shell
# 查看内部内部的网络地址 ip addr
docker exec -it 容器名 ip addr
# --link 实现容器互联
docker -d -P --name 容器名1 --link 容器名2  镜像名
# 自定义网络 
docker network create --driver bridge --subnet 192.168.0.0/16 --gateway 192.168.0.1 netname  
# 利用自定义网络创建容器
docker run -d -P --name 容器名 --net netname 镜像名
# 将另一个网络中的容器和目标网络之间打通 
# 连通之后就是将该容器放到了目标网络中,给了对应的ip,一个容器,两个ip
docker network connect 网络名 容器名
```