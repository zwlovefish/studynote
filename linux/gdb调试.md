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

<table>
	<tr>
    	<th>命令</th>
        <th>含义</th>
    <tr>
    <tr>
    	<th>set logging on</th>
        <th>经屏幕输出同时输出到log文件中，默认输出到当前目录下的gdb.txt文件</th>
    <tr>
        <tr>
    	<th>set logging off</th>
        <th>关闭log</th>
    <tr>
        <tr>
    	<th>set logging file file</th>
        <th>默认输出为gdb.txt,这样将当前输出的默认log文件改名</th>
    <tr>
        <tr>
    	<th>set logging overwrite</th>
        <th>默认情况下GDB日志输出是附加到log文件中的。设置为overwrite时，每次均重写一个全新的文件			</th>
    <tr>
        <tr>
    	<th>show logging </th>
        <th>输出当前日志的设置</th>
    <tr>
</table>

## 启动调试命令总结

<table>
	<tr>
    	<th>run</th>
        <th>启动调试程序，后面可以加启动参数</th>
    </tr>
    <tr>
    	<th>attach</th>
        <th>关联到正在运行中的进程</th>
    </tr>
        <tr>
    	<th>set args</th>
        <th>设置程序启动时的参数。如果没有跟着参数将设置参数为空</th>
    </tr>
        <tr>
    	<th>show args</th>
        <th>显示启动参数</th>
    </tr>
    <tr>
    	<th>set environment</th>
        <th>设置环境变量，这对已开始执行的程序并没有影响</th>
    </tr>
        <tr>
    	<th>show environment</th>
        <th>如果没有参数显示所有的环境变量</th>
    </tr>
    <tr>
    	<th>unset environment</th>
        <th>取消环境变量设置，这对已开始执行的程序没有影响</th>
    </tr>
    <tr>
    	<th>help</th>
        <th>获取帮助，没有参数将输出命令分类列表</th>
    </tr>
    <tr>
    	<th>help</th>
        <th>获取帮助，没有参数将输出命令分类列表</th>
    </tr>
    <tr>
    	<th>apropos</th>
        <th>搜索命令帮助</th>
    </tr>
</table>

# 断点管理
## 设置断点
设置断点的命令为break，可以缩写为b
命令格式为：break [LOCATION] [thread THREADNUM][if CONDITION]   
其中LOCATION可以是代码行号，函数名，或者一个带有\*号的地址    
THREADNUM是线程号，可以用info threads命令来查看线程号。CONDITION是一个布尔表达式   
tbreak用于设置一个临时断点，和“break”命令相似，唯一不同的是它所设置的断点为临时断点，当命中这个断点后将删除断点。   
显示断点的信息的是 info break [n...] 输出所有断点、观察点和捕获点。   

-  断点编号：GDB将指令断点，观察点和捕获点三者统一顺序编号，编号从1开始
- 类型：是指令断点、观察点、还是捕获点。
- 部署：当执行到断点以后，是删除断点还是不在运行等。
- 使能状态：断点的使能状态，y表示断点能用，n表示不能用
- 地址：断点的内存地址，如果断点的地址是未知的，显示“\<PENDING\>”
- 位置：断点在程序源代码中的位置，例如文件和行号
## 删除断点 delete clear
1. clear带有一个可选的参数，参数可以为代码行号，函数名或者带星号的地址。如果指定行号，该行所有的断点均被移除。如果指定函数，则函数起始位置的所有断点将被移除。如果指定地址，该地址的断点均被移除。如果没有参数，则在所选择的栈帧当前位置删除所有断点。
2. delete用于删除断点。如果不指定参数，将删除所有断点。参数为断点编号或者范围
3. **比以上俩者都好用的方法是disable，这样断点将不生效但是断点位置的信息得到了保留，可以在稍后再次启用它。命令格式如下 ：disable [breakpoints][range...], enable [breakpoints][range...],其中，breakpoints如断点编号**

# 单步调试
当程序被停止执行时，可以用continue命令恢复程序执行，直至程序结束，或者下一个断点的到来。也可以使用step或者next命令单步跟踪程序。

1. continue[ignore-count]：从断点停止的地方恢复程序执行。命令可以缩写为c。ignore-count则表示忽略这个位置的断点次序。程序继续执行直至遇到下一个断点。
2. step:继续执行程序直到控制到达不同的源代码行，然后停止执行并返回控制到GDB。后面可以加一个参数，表示执行count次step命令。
3. next：同样为单步跟踪，继续执行同一函数的下一行代码，这和step命令相似，但如果有函数调用，**他不会进入该函数内部**。后面可以加数字N，表示一次执行n条命令。
4. finish：继续运行程序知道当前选择则的栈帧返回，并输出返回值，命令缩写为fin
5. until：执行程序知道大于当前已经执行的代码行，在程序循环时经常会用到它，即循环体如果执行过一次，使用until命令将循环体完成之后下一行代码处停止它。

# 断点管理和单步调试命令总结：
<table>
	<tr>
		<th>命令<th>
        <th>含义</th>
	</tr>
    	<tr>
		<th>break<th>
        <th>在指定行或函数处设置断点</th>
	</tr>
    	<tr>
		<th>tbreak<th>
        <th>设置临时断点，在命中执行一次后就自动删除该断点</th>
	</tr>
    	<tr>
		<th>clear<th>
        <th>在所选择的栈帧中当前位置删除所有断点</th>
	</tr>
    	<tr>
		<th>delete breakpoints<th>
        <th>删除断点，如果不指定参数将删除所有的断点</th>
	</tr>
    	<tr>
		<th>disable breakpoints<th>
        <th>是断点失效，但任保存在断点数据库中，例如disable breakpoint1</th>
	</tr>
    	<tr>
		<th>enable<th>
        <th>启动断点，例如 enable breakpoint1</th>
	</tr>
    	<tr>
		<th>watch<th>
        <th>设置观察点，当表达式的值发生改变时程序停止运行</th>
	</tr>
    	<tr>
		<th>rwatch<th>
        <th>设置读观察点，当表达式的值读取时，程序停止执行</th>
	</tr>
    	<tr>
		<th>awatch<th>
        <th>设置访问观察点，当表达式的值读或写时，将停止执行程序</th>
	</tr>
    	<tr>
		<th>step<th>
        <th>执行下一行代码，如果遇到函数则进入函数内部</th>
	</tr>
    	<tr>
		<th>next<th>
        <th>执行下一行代码，遇到函数不进入函数内部</th>
	</tr>
    	<tr>
		<th>finish<th>
        <th>继续运行程序知道当前选择的栈帧返回，并输出返回值，命令缩写为fin</th>
	</tr>
    	<tr>
		<th>continue<th>
        <th>继续程序的执行，知道程序结束或者遇到下一个断点</th>
	</tr>
    	<tr>
		<th>until<th>
        <th>执行直到程序到达大于当前或指定位置。这种遇到循环时非常有用，可以跳出当前循环</th>
	</tr>
</table>

# 查看程序运行转态
## 查看栈帧信息
栈帧：当程序执行函数调用时，关于这次调用的信息(包含调用的代码位置，传递的参数，函数的局部变量等信息)均保存到了一段内存中，这段内存被称为栈帧或者帧。所有的栈帧组合称为调用栈。   

1. backtrace [full]/[number]:将输出当前的整个函数调用栈的信息，整个栈的每个帧一行显示。可以缩写为bt。如果带有“full”限定符，将输出所有局部变量值，参数number可以是一个正整数或者负整数，表示只打印栈顶/栈底n层的栈信息。
(gdb)backtrace
#0 read\_conf (hello=0x804a080 <hello>) at hello.c:31
#1 0x080489e1 in main(argc=1,argv=0xbffff064) at hello.c:57
调用栈的每一行包含4部分，包含帧编号，函数名，函数逇参数名称和传入的实参，调用的源代码文件名和行号。程序在hello.c文件第31行处停止执行。函数的调用顺序信息为：main()----->read_conf();   
 frame：选择和输出栈帧。如果没有参数，输出当前选择的栈帧。如果有参数，表示选择这个指定的栈帧。参数可以是栈帧编号或者地址。打印出的信息有栈帧的层编号、当前的函数名、函数参数值、函数所在文件及行号，以及函数当前执行到的代码行语句。 
 up：选择和输出栈帧，不带参数表示选择向上移动一层栈帧。可以带有参数来移动多层。   
 down：不带参数表示选择向下移动一层栈帧。可以带有参数移动多层。   
 return：返回到当前栈帧的调用处。   
 info frame：显示栈帧的所有信息。 
 栈帧调用关系只能在同一个线程中查看，如果一个程序有多个线程同时执行，可以输入thread命令和参数线程编号来在线程之间切换。经常使用的线程命令有查询所有线程命令“info thread”和切换线程命令thread。
 
## 查看运行中的源程序信息
list 如果没有参数，输出当前10行代码或者紧接着上次的代码。   
list- 输出当前位置之前的10行代码，注意- ，和list命令相反。  
list命令参数可以是一个代码行或者函数名：如果为代码行，则列出指定行的代码，如果为函数名，则列出函数名附近的代码。   

## 查看运行时数据
使用print命令可以输出执行程序时的运行数据，例如表达式的值，但是需要在你的调用栈环境下，例如全局变量，静态全局变量和局部变量。可以用print和x命令来查看表达式和地址的内容。   
print /fmt exp表示输出表达式的内容。如果局部变量和全局变量名称相同，则默认为输出局部变量打的内容，如果需要输出全局变量的内容，则需要加全局限定符(::).如果变量为数组，则需要@字符配合才能输出数组内容。@的左侧为数组的地址，右侧是数字的长度。如果是静态数组，可以直接用print数组名，就可以显示数组中所有数据的内容。    
**注意:<br>如果程序变量的值不能被输出，是因为程序打开了编译优化功能。需要关闭优化功能**   
x /FMT ADDRESS表示查看内存地址中的值。  
ADDRESS 是一个内存地址    
FMT是格式字符串和多少个同样格式的内容联系在一起

**注意:<br>GDB会根据变量的类型输出变量的值。也可以自定义print的输出格式，格式如c语言**   
程序执行过程中，有一些专用的GDB变量可以用来检查和修改计算机的通用寄存器，GDB提供了目前每一台计算机中实际使用的4个寄存器的标准名字。   

- $pc:程序计数器
- $fp:帧指针(当前堆栈帧)
- $sp:栈指针
- $ps:处理器状态

# 查看程序运行状态命令总结
<table>
	<tr>
    	<th>命令</th>
        <th>含义</th>
    </tr>
    	<tr>
    	<th>backtrace</th>
        <th>输出堆栈调用信息</th>
    </tr>
    <tr>
    	<th>bt full</th>
        <th>显示栈的详细信息</th>
    </tr>
    <tr>
    	<th>info frame</th>
        <th>显示所选栈帧的所有信息</th>
    </tr>
        	<tr>
    	<th>list</th>
        <th>显示源代码，如果没有参数将显示当前位置的10行代码</th>
    </tr>
    <tr>
    	<th>print</th>
        <th>输出变量的内容</th>
    </tr>
    <tr>
    	<th>x</th>
        <th>显示内存地址内容，命令格式为x /FMT ADDRESS</th>
    </tr>
    <tr>
    	<th>info registers</th>
        <th>列出寄存器及内容</th>
    </tr>
    <tr>
    	<th>frame</th>
        <th>选择和输出栈帧信息</th>
    </tr>
    <tr>
    	<th>up</th>
        <th>不带参数表示选择向上移动一层栈帧。可以带有参数来向上移动多层</th>
    </tr>
    <tr>
    	<th>down</th>
        <th>不带参数表示选择则向下移动一层栈帧。可以带有参数来向下移动多层</th>
    </tr>
  <tr>
    	<th>info threads</th>
        <th>输出程序中所有的线程。可以带有一个参数仅输出指定线程</th>
    </tr>
    <tr>
    	<th>thread</th>
        <th>在多个线程之间切换。线程编号从1开始，带有一个数字参数来指定要切换的线程</th>
    </tr>
</table>

# 动态改变程序的执行
修改变量的值，跳到其他地址处执行   
<table>
<tr>
	<th>命令</th>
    <th>含义</th>
</tr>
<tr>
	<th>print</th>
    <th>输出修改程序值</th>
</tr>
<tr>
	<th>set</th>
    <th>修改程序值</th>
</tr>
<tr>
	<th>jump</th>
    <th>跳转到指定行或地址来继续执行，最好在同一函数内部跳转</th>
</tr>
<tr>
	<th>signal</th>
    <th>向程序发信号，例如signal 9 将发出杀掉进程的信号</th>
</tr>
<tr>
	<th>return</th>
    <th>强制函数返回，不会继续执行函数的剩余代码</th>
</tr>
<tr>
	<th>call</th>
    <th>调用函数，不输出函数返回值</th>
</tr>
</table>

> B智能路由器开发指南