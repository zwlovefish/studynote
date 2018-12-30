源文件首先会生成中间目标文件，再由中间目标文件生成执行文件。在编译时，编译器只检测程序语法，和函数、变量是否被声明。如果函数未被声明，编译器会给出一个警告，但可以生成Object File。而在链接程序时，链接器会在所有的Object File中找寻函数的实现，如果找不到，那到就会报链接错误码（Linker Error），在VC下，这种错误一般是：Link 2001错误，意思说是说，链接器未能找到函数的实现。你需要指定函数的Object File.
   
# 编译规则：
- 如果这个工程没有编译过，那么我们的素有c文件都要编译并被链接
-	如果这个工程的某几个c文件被修改，那么我们只编译被修改的c文件，并链接目标程序
-	如果这个工程的头文件被改变了，那么我们需要编译应用了这几个头文件的c文件，并链接目标程序

# Makefile规则

target ... : prerequisites ...   
	command   
	...   
	...   
target也就是一个目标文件，可以是object File,也可以是执行文件。还可以是一个标签(Label)   
prerequistes就是要生成那个target所需要的文件或是目标   
command也就是make需要执行的命令。(任意的shell命令)   

这是一个文件的依赖关系，也就是说，target这一个或多个的目标文件依赖于prerequisites中的文件，其生成规则定义在command中。说白一点就是说，prerequisites中如果有一个以上的文件比target文件要新的话，command所定义的命令就会被执行。这就是Makefile的规则。也就是Makefile中最核心的内容。  
**注：<br>在看别人写的Makefile文件时，你可能会碰到以下三个变量$@,$^,$<他们所代表的含义分别是：<br>$@---目标文件，$^---所有的依赖文件，$<第一个依赖文件。**   

在定义好依赖关系后，后续的那一行定义了如何生成目标文件的<font color="red">操作系统命令</font>，一定要以<font color="red">一个Tab键作为开头</font>,记住，**make并不管命令是怎么工作的，他只管执行所定义的命令**。make会比较targets文件和prerequisites文件的修改日期，如果prerequisites文件的日期要比targets文件的日期要新，或者target不存在的话，那么，make就会执行后续定义的命令。

```例子
	edit : main.o kbd.o command.o display.o \

          insert.o search.o files.o utils.o

       cc -o edit main.o kbd.o command.o display.o \

          insert.o search.o files.o utils.o
      main.o : main.c defs.h

           cc -c main.c

   kbd.o : kbd.c defs.h command.h

           cc -c kbd.c

   command.o : command.c defs.h command.h

           cc -c command.c

   display.o : display.c defs.h buffer.h

           cc -c display.c

   insert.o : insert.c defs.h buffer.h

           cc -c insert.c

   search.o : search.c defs.h buffer.h

           cc -c search.c

   files.o : files.c defs.h buffer.h command.h

           cc -c files.c

   utils.o : utils.c defs.h

           cc -c utils.c

   clean :

           rm edit main.o kbd.o command.o display.o \

              insert.o search.o files.o utils.o
```

	
# Makefile是如何工作的
1. make会在当前目录下找名字叫Makefile或makefile的文件
2. 如果找到，他会找文件中的第一个目标文件，在上面的例子中，他会找到edit这个文件，并把这个文件作为最终的目标文件
3. 如果edit文件不存在，或是edit所依赖的后面的.o文件的文件修改时间要比edit这个文件新，那么，他就会执行后面所定义的命令来生成edit文件
4.  如果edit所依赖的.o文件也存在，那么make会在当前文件中找目标为.o文件的依赖性，如果找到则再根据那一个规则生成.o文件。（这有点像一个堆栈的过程）
5. 当然，你的C文件和H文件是存在的啦，于是make会生成 .o 文件，然后再用 .o 文件声明make的终极任务，也就是执行文件edit了。

## 在Makefile中使用变量
```
 objects = main.o kbd.o command.o display.o \
             insert.osearch.o files.o utils.o 
   edit : $(objects)
           cc -o edit $(objects)
   main.o : main.c defs.h
           cc -c main.c
   kbd.o : kbd.c defs.h command.h
           cc -c kbd.c
   command.o : command.c defs.h command.h
           cc -c command.c
   display.o : display.c defs.h buffer.h
           cc -c display.c
   insert.o : insert.c defs.h buffer.h
           cc -c insert.c
   search.o : search.c defs.h buffer.h
           cc -c search.c
   files.o : files.c defs.h buffer.h command.h
           cc -c files.c
   utils.o : utils.c defs.h
           cc -c utils.c
   clean :
           rm edit $(objects)
```
其中$(objects)就是使用的变量   

GNU的make很强大，它可以自动推导文件以及文件依赖关系后面的命令，于是我们就没必要去在每一个[.o]文件后都写上类似的命令，因为，我们的make会自动识别，并自己推导命令。只要make看到一个[.o]文件，它就会自动的把[.c]文件加在依赖关系中，如果make找到一个whatever.o，那么whatever.c，就会是whatever.o的依赖文件。并且 cc -c whatever.c 也会被推导出来   

```   
objects = main.o kbd.o command.o display.o \
             insert.o search.o files.o utils.o
 
   edit : $(objects)
           cc -o edit $(objects)
 
   main.o : defs.h
   kbd.o : defs.h command.h
   command.o : defs.h command.h
   display.o : defs.h buffer.h
   insert.o : defs.h buffer.h
   search.o : defs.h buffer.h
   files.o : defs.h buffer.h command.h
   utils.o : defs.h
 
   .PHONY : clean
   clean :
           rm edit $(objects)
           
```
这种方法，也就是make的“隐晦规则”。上面文件内容中，“.PHONY”表示，clean是个伪目标文件。   
make可以自动推导命令,看到那堆[.o]和[.h]的依赖就有点不爽，那么多的重复的[.h]，也能把其收拢起来

```
 objects = main.o kbd.o command.o display.o \
             insert.o search.o files.o utils.o
 
   edit : $(objects)
           cc -o edit $(objects)
 
   $(objects) : defs.h
   kbd.o command.o files.o : command.h
   display.o insert.o search.o files.o : buffer.h
 
   .PHONY : clean
   clean :
           rm edit $(objects)
```
这种风格，让我们的makefile变得很简单，但我们的文件依赖关系就显得有点凌乱了。鱼和熊掌不可兼得。还看你的喜好了。   

#清空目标文件的规则

```
 clean:

           rm edit $(objects)
```
更为稳健的做法是：

```
.PHONY : clean

       clean :

               -rm edit $(objects)
```
.PHONY意思表示clean是一个“伪目标”，。而在rm命令前面加了一个小减号的意思就是，也许某些文件出现问题，但不要管，继续做后面的事。当然，clean的规则不要放在文件的开头，不然，这就会变成make的默认目标，相信谁也不愿意这样。不成文的规矩是——“clean从来都是放在文件的最后”。

#引用其它的Makefile

 在Makefile使用include关键字可以把别的Makefile包含进来，这很像C语言的#include，被包含的文件会原模原样的放在当前文件的包含位置

```
include<filename>
filename可以是当前操作系统Shell的文件模式（可以保含路径和通配符）

```
<font color="red">在include前面可以有一些空字符，但是绝不能是[Tab]键开始。include和可以用一个或多个空格隔开。</font>   
举个例子，你有这样几个Makefile：a.mk、b.mk、c.mk，还有一个文件叫foo.make，以及一个变量$(bar)，其包含了e.mk和f.mk，那么，下面的语句：```
include foo.make *.mk $(bar)   ```等价于
```   include foo.make a.mk b.mk c.mk e.mk f.mk ```

make命令开始时，会把找寻include所指出的其它Makefile，并把其内容安置在当前的位置。就好像C/C++的#include指令一样。如果文件都没有指定绝对路径或是相对路径的话，make会在当前目录下首先寻找，如果当前目录下没有找到，那么，make还会在下面的几个目录下找：

1. 如果make执行时，有“-I”或“--include-dir”参数，那么make就会在这个参数所指定的目录下去寻找。
2. 如果目录/include（一般是：/usr/local/bin或/usr/include）存在的话，make也会去找。

如果有文件没有找到的话，make会生成一条警告信息，但不会马上出现致命错误。它会继续载入其它的文件，一旦完成makefile的读取，make会再重试这些没有找到，或是不能读取的文件，如果还是不行，make才会出现一条致命信息。如果你想让make不理那些无法读取的文件，而继续执行，你可以在include前加一个减号“-”。如：

```
-include<filename>
```
其表示，无论include过程中出现什么错误，都不要报错继续执行。和其它版本make兼容的相关命令是sinclude，其作用和这一个是一样的。


#GNU的make工作时的执行步骤：
1. 读入所有的Makefile。
2. 读入被include的其它Makefile。
3. 初始化文件中的变量。
4. 推导隐晦规则，并分析所有规则。
5. 为所有的目标文件创建依赖关系链。
6. 根据依赖关系，决定哪些目标要重新生成。
7. 执行生成命令

1-5步为第一个阶段，6-7为第二个阶段。第一个阶段中，如果定义的变量被使用了，那么，make会把其展开在使用的位置。但make并不会完全马上展开，make使用的是拖延战术，如果变量出现在依赖关系的规则中，那么仅当这条依赖被决定要使用了，变量才会在其内部展开。

#Makefile书写规则
规则包含两个部分，一个是依赖关系，一个是生成目标的方法。   
在Makefile中，规则的顺序是很重要的，因为，Makefile中只应该有一个最终目标，其它的目标都是被这个目标所连带出来的，所以一定要让make知道你的最终目标是什么。一般来说，定义在Makefile中的目标可能会有很多，但是第一条规则中的目标将被确立为最终的目标。如果第一条规则中的目标有很多个，那么，第一个目标会成为最终的目标。make所完成的也就是这个目标。

#在规则中使用通配符
1. "~"  
“~”字符在文件名中也有比较特殊的用途。如果是“~/test”，这就表示当前用户的$HOME目录下的test目录。而“~hchen/test”则表示用户hchen的宿主目录下的test目录。（这些都是Unix下的小知识了，make也支持）而在Windows或是MS-DOS下，用户没有宿主目录，那么波浪号所指的目录则根据环境变量“HOME”而定。
2. "\*"
通配符代替了你一系列的文件，如“\*.c”表示所以后缀为c的文件。一个需要我们注意的是，如果我们的文件名中有通配符，如：“\*”，那么可以用转义字符“\\”，如“\*”来表示真实的“\*”字符，而不是任意长度的字符串。

# 文件搜寻
在一些大的工程中，有大量的源文件，我们通常的做法是把这许多的源文件分类，并存放在不同的目录中。所以，当make需要去找寻文件的依赖关系时，你可以在文件前加上路径，但最好的方法是把一个路径告诉make，让make在自动去找。Makefile文件中的特殊变量“VPATH”就是完成这个功能的，如果没有指明这个变量，make只会在当前的目录中去找寻依赖文件和目标文件。如果定义了这个变量，那么，make就会在当当前目录找不到的情况下，到所指定的目录中去找寻文件了。
```
VPATH = src:../headers
```
上面的的定义指定两个目录，“src”和“../headers”，make会按照这个顺序进行搜索。目录由“冒号”分隔。（当然，当前目录永远是最高优先搜索的地方）     
另一个设置文件搜索路径的方法是使用make的“vpath”关键字（注意，它是全小写的），这不是变量，这是一个make的关键字，这和上面提到的那个VPATH变量很类似，但是它更为灵活。它可以指定不同的文件在不同的搜索目录中。这是一个很灵活的功能。它的使用方法有三种：<font color="red">

1. vpath < pattern> < directories>为符合模式< pattern>的文件指定搜索目录<directories>。
2. vpath < pattern>清除符合模式< pattern>的文件的搜索目录。
3. vpath 清除所有已被设置好了的文件搜索目录

</font>

vapth使用方法中的< pattern>需要包含“%”字符。“%”的意思是匹配零或若干字符，例如，“%.h”表示所有以“.h”结尾的文件。< pattern>指定了要搜索的文件集，而< directories>则指定了的文件集的搜索的目录。例如:  
```  
vpath %.h ../headers
```   
该语句表示，要求make在“../headers”目录下搜索所有以“.h”结尾的文件。（如果某文件在当前目录没有找到的话）   
我们可以连续地使用vpath语句，以指定不同搜索策略。如果连续的vpath语句中出现了相同的< pattern>，或是被重复了的< pattern>，那么，make会按照vpath语句的先后顺序来执行搜索。如：

```

 vpath %.c foo
  
 vpath % blish
 
 vpath %.c bar   
 
```
其表示“.c”结尾的文件，先在“foo”目录，然后是“blish”，最后是“bar”目录。   

```
vpath %.c foo:bar

vpath %   blish
   
```
而上面的语句则表示“.c”结尾的文件，先在“foo”目录，然后是“bar”目录，最后才是“blish”目录。   

# 伪目标  .PHONY
伪目标一般没有依赖的文件。但是，我们也可以为伪目标指定所依赖的文件。伪目标同样可以作为“默认目标”，只要将其放在第一个。一个示例就是，如果你的Makefile需要一口气生成若干个可执行文件，但你只想简单地敲一个make完事，并且，所有的目标文件都写在一个Makefile中，那么你可以使用“伪目标”这个特性：

```
all : prog1 prog2 prog3

   .PHONY : all

 

   prog1 : prog1.o utils.o

           cc -o prog1 prog1.o utils.o

 

   prog2 : prog2.o

           cc -o prog2 prog2.o

 

   prog3 : prog3.o sort.o utils.o

           cc -o prog3 prog3.o sort.o utils.o


```

我们知道，Makefile中的第一个目标会被作为其默认目标。我们声明了一个“all”的伪目标，其依赖于其它三个目标。由于伪目标的特性是，总是被执行的，所以其依赖的那三个目标就总是不如“all”这个目标新。所以，其它三个目标的规则总是会被决议。也就达到了我们一口气生成多个目标的目的。“.PHONY : all”声明了“all”这个目标为“伪目标”。   
随便提一句，从上面的例子我们可以看出，目标也可以成为依赖。所以，伪目标同样也可成为依赖。看下面的例子：

```
PHONY: cleanall cleanobj cleandiff
   cleanall : cleanobj cleandiff
           rm program
   cleanobj :
           rm *.o
   cleandiff :
           rm *.diff
```
makeclean”将清除所有要被清除的文件。“cleanobj”和“cleandiff”这两个伪目标有点像“子程序”的意思。我们可以输入“makecleanall”和“make cleanobj”和“makecleandiff”命令来达到清除不同种类文件的目的

# 多目标
Makefile的规则中的目标可以不止一个，其支持多目标，有可能我们的多个目标同时依赖于一个文件，并且其生成的命令大体类似。于是我们就能把其合并起来。当然，多个目标的生成规则的执行命令是同一个，这可能会可我们带来麻烦，不过好在我们的可以使用一个自动化变量“$@”（关于自动化变量，将在后面讲述），这个变量表示着目前规则中所有的目标的集合，这样说可能很抽象，还是看一个例子吧。

```
bigoutput littleoutput : text.g
           generate text.g -$(subst output,,$@) > $@
```

等价于

```
bigoutput : text.g
           generate text.g -big > bigoutput
   littleoutput : text.g
           generate text.g -little > littleoutput
```

其中，-$(subst output,,$@)中的“$”表示执行一个Makefile的函数，函数名为subst，后面的为参数。关于函数，将在后面讲述。这里的这个函数是截取字符串的意思，“$@”表示目标的集合，就像一个数组，“$@”依次取出目标，并执于命令。

#静态模式
静态模式可以更加容易地定义多目标的规则，可以让我们的规则变得更加的有弹性和灵活。我们还是先来看一下语法:
 
```
<targets...>: <target-pattern>: <prereq-patterns ...>
　　　<commands>
```
targets定义了一系列的目标文件，可以有通配符。是目标的一个集合。  
target-parrtern是指明了targets的模式，也就是的目标集模式。  
prereq-parrterns是目标的依赖模式，它对target-parrtern形成的模式再进行一次依赖目标的定义。   
这样描述这三个东西，可能还是没有说清楚，还是举个例子来说明一下吧。如果我们的<target-parrtern>定义成“%.o”，意思是我们的集合中都是以“.o”结尾的，而如果我们的<prereq-parrterns>定义成“%.c”，意思是对<target-parrtern>所形成的目标集进行二次定义，其计算方法是，取<target-parrtern>模式中的“%”（也就是去掉了[.o]这个结尾），并为其加上[.c]这个结尾，形成的新集合。   
所以，我们的“目标模式”或是“依赖模式”中都应该有“%”这个字符，如果你的文件名中有“%”那么你可以使用反斜杠“\”进行转义，来标明真实的“%”字符。   

```
objects = foo.o bar.o
   all: $(objects)
   $(objects): %.o: %.c
           $(CC) -c $(CFLAGS) $< -o $@
```

上面的例子中，指明了我们的目标从$object中获取，“%.o”表明要所有以“.o”结尾的目标，也就是“foo.o bar.o”，也就是变量$object集合的模式，而依赖模式“%.c”则取模式“%.o”的“%”，也就是“foobar”，并为其加下“.c”的后缀，于是，我们的依赖目标就是“foo.cbar.c”。而命令中的“$<”和“$@”则是自动化变量，“$<”表示所有的依赖目标集（也就是“foo.c bar.c”），“$@”表示目标集（也褪恰癴oo.o bar.o”）。于是，上面的规则展开后等价于下面的规则：   

```
 foo.o : foo.c
           $(CC) -c $(CFLAGS) foo.c -o foo.o
   bar.o : bar.c
           $(CC) -c $(CFLAGS) bar.c -o bar.o
```

试想，如果我们的“%.o”有几百个，那种我们只要用这种很简单的“静态模式规则”就可以写完一堆规则，实在是太有效率了。“静态模式规则”的用法很灵活，如果用得好，那会一个很强大的功能。再看一个例子：

```
files = foo.elc bar.o lose.o
   $(filter %.o,$(files)): %.o: %.c
           $(CC) -c $(CFLAGS) $< -o $@
   $(filter %.elc,$(files)): %.elc: %.el
           emacs -f batch-byte-compile $<
```
$(filter%.o,$(files))表示调用Makefile的filter函数，过滤“$filter”集，只要其中模式为“%.o”的内容。其的它内容，我就不用多说了吧。这个例字展示了Makefile中更大的弹性。




