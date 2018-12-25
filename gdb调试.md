# GDB调试
1. 如何启动程序调试
- 编译时，指定-g即可产生调试信息。把程序交给客户时通常会使用-O选项进行编译优化(有些编译器不能同时使用这俩个参数，但是GCC可以)
# 使用GDB调试
1. 常见启动GDB的方式是带有一个可执行程序名称的参数：gdb hello
2. 也可以带俩个参数来启动GDB，一个是可执行程序，一个是进程崩溃后的生成的文件:gdb hello core
3. 调试正在运行的程序，则带上进程号，**程序进程号使用ps查看** gdb hello 1234；   
    或者，启动后，使用attach命令关联上正在运行的待调试进程，解关联是deattach
4. 退出时，使用quit命令
5. set args 用于指定程序启动时的参数，如果没有跟着参数，设置为空
6. show args用于显示程序启动时的参数
## 环境变量设置
- show paths
- show environment HOME:显示系统的环境变量
- set environment varnamevalue]:设置环境变量，这个环境变量仅仅在GDB启动的程序中有效，不会影响到系统环境变量：(gdb) set env  CONFIGDIR = /etc/config
| 命令 | 含义|
| --------- |------|
