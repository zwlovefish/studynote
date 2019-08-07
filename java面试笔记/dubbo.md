# 一次完整的RPC调用流程
![RPC基本流程图](../images/RPC基本流程图.png)

1. 服务消费方(client)以本地方式调用服务
2. clent stub接收到调用后负责将方法、参数等组装成能够进行网络传输的消息体
3. client stub找到服务地址，并将消息发送到服务端
4. server stub收到消息后进行解码
5. server stub根据解码后的消息调用本地服务
6. 本地服务执行并将结果返回给server stub
7. server stub将返回结果打包成消息并发送至消费方
8. client stub接收到消息，并进行解码
9. 服务消费方得到最终结果

RPC框架的目的就是要将步骤2-8封装起来，这些细节对用户是透明的，不可见的。



