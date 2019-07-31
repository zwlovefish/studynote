
<!-- MarkdownTOC -->

- [1.为什么集合类没有实现Cloneable和Serializable接口](#1为什么集合类没有实现cloneable和serializable接口)
- [2.什么是迭代器](#2什么是迭代器)
- [3.Iterator和ListIterator的区别是什么](#3iterator和listiterator的区别是什么)
- [4.快速失败\(fail-fast\)和安全失败\(fail-safe\)的区别是什么](#4快速失败fail-fast和安全失败fail-safe的区别是什么)
- [5.ArrayList和LinkedList有什么区别](#5arraylist和linkedlist有什么区别)
- [6.ArrayList,Vector,LinkedList的存储性能和特性是什么](#6arraylistvectorlinkedlist的存储性能和特性是什么)
- [7.Collection 和 Collections的区别](#7collection-和-collections的区别)
- [8.List,Set,Map是否继承自Collection接口](#8listsetmap是否继承自collection接口)
- [9.List,Map,Set三个接口存取元素时,各有什么特点](#9listmapset三个接口存取元素时各有什么特点)
- [10.多线程中的i++线程安全吗,为什么](#10多线程中的i线程安全吗为什么)
- [11.如何线程安全的实现一个计数器](#11如何线程安全的实现一个计数器)
- [12.多线程同步的方法](#12多线程同步的方法)
- [13.介绍一下生产者消费者模式](#13介绍一下生产者消费者模式)
- [14.线程,进程,然后线程创建有很大开销,怎么优化](#14线程进程然后线程创建有很大开销怎么优化)
- [15.线程池运行流程,参数,策略](#15线程池运行流程参数策略)
- [16.讲一下AQS吧](#16讲一下aqs吧)
    - [acquire\(int\)](#acquireint)
    - [release\(int\)](#releaseint)
    - [acquireShared\(int\)](#acquiresharedint)
    - [releaseShared\(\)](#releaseshared)
- [17.创建线程的方法,哪个更好,为什么](#17创建线程的方法哪个更好为什么)
- [18.Java中有几种线程池](#18java中有几种线程池)
- [19.线程池有什么好处](#19线程池有什么好处)
- [20.cyclicbarrier和countdownlatch的区别](#20cyclicbarrier和countdownlatch的区别)
- [21.如何理解Java多线程回调方法](#21如何理解java多线程回调方法)
- [22.概括的解释下线程的几种可用状态](#22概括的解释下线程的几种可用状态)

<!-- /MarkdownTOC -->


# 1.为什么集合类没有实现Cloneable和Serializable接口
集合类接口指定了一组叫做元素的对象。集合类接口的每一种具体的实现类都可以选择以它 自己的方式对元素进行保存和排序。有的集合类允许重复的键，有些不允许。   
克隆(cloning)或者序列化(serialization)的语义和含义是跟具体的实现相关的。因此，应该由集合类的具体实现来决定如何被克隆或者是序列化。
>https://blog.csdn.net/dragon901/article/details/79919965 

# 2.什么是迭代器
Iterator接口提供了很多对集合元素进行迭代的方法。每一个集合类都包括了可以返回迭代器实例的迭代方法。迭代器可以在迭代过程中删除底层集合的元素，但是不可以直接调用集合的remove(Object obj)删除，可以通过迭代器的remove()方法删除
>https://blog.csdn.net/qq_18433441/article/details/78223502

# 3.Iterator和ListIterator的区别是什么
凡是实现了Collection接口的集合类，都有一个Iterator方法，用于返回一个实现了Iterator接口的对象，用于遍历集合；（Iterator接口定义了3个方法分别是hasNext（），next（），remove（））

我们在使用List,Set的时候，为了实现对其数据的遍历，我们经常使用到了Iterator(迭代器)。使用迭代器，你不需要干涉其遍历的过程，只需要每次取出一个你想要的数据进行处理就可以了。

但是在使用的时候也是有不同的。List和Set都有iterator()来取得其迭代器。对List来说，你也可以通过listIterator()取得其迭代器，两种迭代器在有些时候是不能通用的，Iterator和ListIterator主要区别在以下方面：

1. iterator()方法在set和list接口中都有定义，但是ListIterator（）仅存在于list接口中（或实现类中）；
2. ListIterator有add()方法，可以向List中添加对象，而Iterator不能
3. ListIterator和Iterator都有hasNext()和next()方法，可以实现顺序向后遍历，但是ListIterator有hasPrevious()和previous()方法，可以实现逆向（顺序向前）遍历。Iterator就不可以。
4. ListIterator可以定位当前的索引位置，nextIndex()和previousIndex()可以实现。Iterator没有此功能。
5. 都可实现删除对象，但是ListIterator可以实现对象的修改，set()方法可以实现。Iierator仅能遍历，不能修改。　

# 4.快速失败(fail-fast)和安全失败(fail-safe)的区别是什么
1. 什么是同步修改？   
当一个或多个线程正在遍历一个集合Collection，此时另一个线程修改了这个集合的内容（添加，删除或者修改）。这就是并发修改
2. 什么是 fail-fast 机制？   
fail-fast机制在遍历一个集合时，当集合结构被修改，会抛出Concurrent Modification Exception。   
fail-fast会在以下两种情况下抛出ConcurrentModificationException：
    1. 单线程环境   
     集合被创建后，在遍历它的过程中修改了结构。   
     注意 remove()方法会让expectModcount和modcount 相等，所以是不会抛出这个异常   
     2. 多线程环境   
     当一个线程在遍历这个集合，而另一个线程对这个集合的结构进行了修改。
<font color="red">注意，迭代器的快速失败行为无法得到保证，因为一般来说，不可能对是否出现不同步并发修改做出任何硬性保证。快速失败迭代器会尽最大努力抛出 ConcurrentModificationException。因此，为提高这类迭代器的正确性而编写一个依赖于此异常的程序是错误的做法：迭代器的快速失败行为应该仅用于检测 bug。</font>
3. fail-fast机制是如何检测的   
迭代器在遍历过程中是直接访问内部数据的，因此内部的数据在遍历的过程中无法被修改。为了保证不被修改，迭代器内部维护了一个标记 “mode” ，当集合结构改变（添加删除或者修改），标记"mode"会被修改，而迭代器每次的hasNext()和next()方法都会检查该"mode"是否被改变，当检测到被修改时，抛出Concurrent Modification Exception
4. fail-safe机制   
fail-safe任何对集合结构的修改都会在一个复制的集合上进行修改，因此不会抛出ConcurrentModificationException。fail-safe机制有两个问题:
    1. 需要复制集合，产生大量的无效对象，开销大
    2. 无法保证读取的数据是目前原始数据结构中的数据
5. fail-fast和 fail-safe 的区别

| |Fail Fast Iterator|Fail Safe Iterator|
|------|----------|-----------|
|Throw ConcurrentModification Exception|Yes|No|
|Clone object|No|Yes|
|Memory Overhead|No|Yes|
|Examples|HashMap,Vector,ArrayList,HashSet | CopyOnWriteArrayList, ConcurrentHashMap

>https://blog.csdn.net/ch717828/article/details/46892051

# 5.ArrayList和LinkedList有什么区别
1. ArrayList是实现了基于动态数组的数据结构，LinkedList基于链表的数据结构。 （LinkedList是双向链表，有next也有previous）
2. 对于随机访问get和set，ArrayList觉得优于LinkedList，因为LinkedList要移动指针。
3. 对于新增和删除操作add和remove，LinedList比较占优势，因为ArrayList要移动数据。

ArrayList和LinkedList在性能上各有优缺点，都有各自所适用的地方，总的说来可以描述如下：

1. 对ArrayList和LinkedList而言，在列表末尾增加一个元素所花的开销都是固定的。对ArrayList而言，主要是在内部数组中增加一项，指向所添加的元素，偶尔可能会导致对数组重新进行分配；而对LinkedList而言，这个开销是统一的，分配一个内部Entry对象。 
2. 在ArrayList的中间插入或删除一个元素意味着这个列表中剩余的元素都会被移动；而在LinkedList的中间插入或删除一个元素的开销是固定的
3. LinkedList不支持高效的随机元素访问
4. ArrayList的空间浪费主要体现在在list列表的结尾预留一定的容量空间，而LinkedList的空间花费则体现在它的每一个元素都需要消耗相当的空间

或者说当操作是在一列数据的后面添加数据而不是在前面或中间,并且需要随机地访问其中的元素时,使用ArrayList会提供比较好的性能；当你的操作是在一列数据的前面或中间添加或删除数据,并且按照顺序访问其中的元素时,就应该使用LinkedList了
>https://www.cnblogs.com/Jacck/p/8034900.html
# 6.ArrayList,Vector,LinkedList的存储性能和特性是什么

ArrayList 和Vector都是使用<font color="red">数组方式存储数据</font>，此数组元素数大于实际存储的数据以便增加和插入元素，它们都允许直接按序号索引元素，但是插入元素要涉及数组元素移动等内存操作，所以索引数据快而插入数据慢，Vector中的方法由于添加了synchronized修饰，因此Vector是线程安全的容器，但性能上较ArrayList差，因此已经是Java中的遗留容器。

LinkedList使用<font color="red">双向链表实现存储</font>（将内存中零散的内存单元通过附加的引用关联起来，形成一个可以按序号索引的线性结构，这种链式存储方式与数组的连续存储方式相比，内存的利用率更高），按序号索引数据需要进行前向或后向遍历，但是插入数据时只需要记录本项的前后项即可，所以<font color="red">插入速度较快</font>。

 Vector属于遗留容器（Java早期的版本中提供的容器，除此之外，Hashtable、Dictionary、BitSet、Stack、Properties都是遗留容器），已经不推荐使用，但是由于ArrayList和LinkedListed都是非线程安全的，如果遇到多个线程操作同一个容器的场景，则可以通过工具类Collections中的synchronizedList方法将其转换成线程安全的容器后再使用（这是对装潢模式的应用，将已有对象传入另一个类的构造器中创建新的对象来增强实现）。

补充：遗留容器中的Properties类和Stack类在设计上有严重的问题，Properties是一个键和值都是字符串的特殊的键值对映射，在设计上应该是关联一个Hashtable并将其两个泛型参数设置为String类型，但是Java API中的Properties直接继承了Hashtable，这很明显是对继承的滥用。这里复用代码的方式应该是Has-A关系而不是Is-A关系，另一方面容器都属于工具类，继承工具类本身就是一个错误的做法，使用工具类最好的方式是Has-A关系（关联）或Use-A关系（依赖）。同理，Stack类继承Vector也是不正确的。
>https://blog.csdn.net/qq_38216661/article/details/82355647

# 7.Collection 和 Collections的区别
1. java.util.Collection 是一个<font color="red">集合接口</font>。它提供了对集合对象进行基本操作的通用接口方法。Collection接口在Java 类库中有很多具体的实现。Collection接口的意义是为各种具体的集合提供了最大化的统一操作方式。
 Collection   
├List   
│├LinkedList   
│├ArrayList   
│└Vector   
│　└Stack   
└Set
2. java.util.Collections是一个<font color="red">包装类</font>。它包含有各种有关集合操作的<font color="red">静态多态方法</font>。此类<font color="red">不能实例化</font>，就像一个<font color="red">工具类</font>，服务于Java的Collection框架。
>https://pengcqu.iteye.com/blog/492196

    1. 排序(Sort)。使用sort方法可以根据元素的自然顺序 对指定列表按升序进行排序。列表中的所有元素都必须实现 Comparable 接口。此列表内的所有元素都必须是使用指定比较器可相互比较的
    2. 混排（Shuffling)。混排算法所做的正好与 sort 相反: 它打乱在一个 List 中可能有的任何排列的踪迹。也就是说，基于随机源的输入重排该 List, 这样的排列具有相同的可能性（假设随机源是公正的）。这个算法在实现一个碰运气的游戏中是非常有用的。例如，它可被用来混排代表一副牌的 Card 对象的一个 List 。另外，在生成测试案例时，它也是十分有用的。
    3. 反转(Reverse)。使用Reverse方法可以根据元素的自然顺序 对指定列表按降序进行排序。
    4. 替换所以的元素(Fill)。使用指定元素替换指定列表中的所有元素。
    5. 拷贝(Copy)。用两个参数，一个目标 List 和一个源 List, 将源的元素拷贝到目标，并覆盖它的内容。目标 List 至少与源一样长。如果它更长，则在目标 List 中的剩余元素不受影响。
    6. 返回Collections中最小元素(min)。根据指定比较器产生的顺序，返回给定 collection 的最小元素。collection 中的所有元素都必须是通过指定比较器可相互比较的。
    7. 返回Collections中最小元素(max)。根据指定比较器产生的顺序，返回给定 collection 的最大元素。collection 中的所有元素都必须是通过指定比较器可相互比较的。
    8. lastIndexOfSubList。返回指定源列表中最后一次出现指定目标列表的起始位置
    9. IndexOfSubList。返回指定源列表中第一次出现指定目标列表的起始位置
    10. Rotate。根据指定的距离循环移动指定列表中的元素。Collections.rotate(list,-1);如果是负数，则正向移动，正数则方向移动
>https://www.cnblogs.com/cathyqq/p/5279859.html

# 8.List,Set,Map是否继承自Collection接口
Collection 

　　├List 

　　│├LinkedList 

　　│├ArrayList 

　　│└Vector 

　　│　└Stack 

　　└Set 

　　Map 

　　├Hashtable 

　　├HashMap 

　　└WeakHashMap 
Collection是最基本的集合接口，一个Collection代表一组Object，即Collection的元素。一些Collection允许相同的元素而另一些不行。一些能排序而另一些不行。Java JDK不能提供直接继承自Collection的类，Java JDK提供的类都是继承自Collection的"子接口"，如:List和Set。   
注意：Map没有继承Collection接口，Map提供key到value的映射。一个Map中不能包含相同key，每个key只能映射一个value。Map接口提供3种集合的视图，Map的内容可以被当做一组key集合，一组value集合，或者一组key-value映射。 

详细介绍：

1. List特点：元素有放入顺序，元素可重复 
2. Map特点：元素按键值对存储，无放入顺序 
3. Set特点：元素无放入顺序，元素不可重复（注意：元素虽然无放入顺序，但是元素在set中的位置是有该元素的HashCode决定的，其位置其实是固定的） 
4. List接口有三个实现类：LinkedList，ArrayList，Vector 
5. LinkedList：底层基于链表实现，链表内存是散乱的，每一个元素存储本身内存地址的同时还存储下一个元素的地址。链表增删快，查找慢 
6. ArrayList和Vector的区别：ArrayList是非线程安全的，效率高；Vector是基于线程安全的，效率低 
7. Set接口有两个实现类：HashSet(底层由HashMap实现)，LinkedHashSet 
8. SortedSet接口有一个实现类：TreeSet（底层由平衡二叉树实现） 
9. Query接口有一个实现类：LinkList 
10. Map接口有三个实现类：HashMap，HashTable，LinkeHashMap 
11. HashMap非线程安全，高效，支持null；HashTable线程安全，低效，不支持null 
12. SortedMap有一个实现类：TreeMap    

其实最主要的是，list是用来处理序列的，而set是用来处理集的。Map存储的是键值对 
set一般无序不重复map是kv结构list 有序 
>https://blog.csdn.net/wzw591455350/article/details/48749185 

# 9.List,Map,Set三个接口存取元素时,各有什么特点
List与Set都是单列元素的集合，它们有一个功共同的父接口Collection。

Set里面不允许有重复的元素

存元素：add方法有一个boolean的返回值，当集合中没有某个元素，此时add方法可成功加入该元素时，则返回true；当集合含有与某个元素equals相等的元素时，此时add方法无法加入该元素，返回结果为false。

取元素：没法说取第几个，只能以Iterator接口取得所有的元素，再逐一遍历各个元素。

List表示有先后顺序的集合

存元素：多次调用add(Object)方法时，每次加入的对象按先来后到的顺序排序，也可以插队，即调用add(int index,Object)方法，就可以指定当前对象在集合中的存放位置。

取元素：

1. Iterator接口取得所有，逐一遍历各个元素。   
2. 调用get(index i)来明确说明取第几个。

Map是双列的集合，存放用put方法:put(obj key,obj value)，每次存储时，要存储一对key/value，不能存储重复的key，这个重复的规则也是按equals比较相等。

取元素：用get(Object key)方法根据key获得相应的value。也可以获得所有的key的集合，还可以获得所有的value的集合，还可以获得key和value组合成的Map.Entry对象的集合。

List以特定次序来持有元素，可有重复元素。Set 无法拥有重复元素,内部排序。Map 保存key-value值，value可多值。
>https://www.cnblogs.com/areyouready/p/7580489.html

# 10.多线程中的i++线程安全吗,为什么
![JMM 模型中对共享变量的读写原理](../images/JVM模型中对共享变量的读写原理.png)    
每个线程都有自己的工作内存，每个线程需要对共享变量操作时必须先把共享变量从主内存load到自己的工作内存，等完成对共享变量的操作时再 save 到主内存   
i++：先赋值再自加。   
++i：先自加再赋值。

i++和++i的线程安全分为两种情况：

1. 如果i是局部变量（在方法里定义的），那么是线程安全的。因为局部变量是线程私有的，别的线程访问不到，其实也可以说没有线程安不安全之说，因为别的线程对他造不成影响。
2. 如果i是全局变量，则同一进程的不同线程都可能访问到该变量，因而是线程不安全的，
会产生脏读。
>https://www.jianshu.com/p/0be2689550e7

# 11.如何线程安全的实现一个计数器

在java中volatile关键字可以保证共享数据的可见性，它会把更新后的数据从工作内存刷新进共享内存，并使其他线程中工作内存中的数据失效，进而从主存中读入最新值来保证共享数据的可见性，实现线程安全的计数器通过循环CAS操作来实现。就是先获取一个旧期望值值，再比较获取的值与主存中的值是否一致，一致的话就更新，不一致的话接着循环，直到成功为止。

```JAVA
package com.zhou;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
public class ThreadSafeCount{
    private int count = 0;
    private AtomicInteger atomicI = new AtomicInteger(0);
    public static void main(String[] args){
        final ThreadSafeCount cas = new ThreadSafeCount();
        List<Thread> list = new ArrayList<Thread>();
        long start = System.currentTimeMillis();
        for(int j=0;j<100;j++){
            Thread t = new Thread(new Runnable(){
                @Override
                public void run(){
                    for(int i=0;i<1000;i++){
                        cas.count();
                        cas.safeCount();
                    }
                }
            });
            list.add(t);
        }
        //启动线程
        for(Thread t:list){
            t.start();
        }
        //等待所有线程执行完毕
        for(Thread t:list){
            try{
                t.join();
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        System.out.println("线程不安全:"+cas.count);
        System.out.println("线程安全:"+cas.atomicI.get());
        System.out.println("耗时:"+(System.currentTimeMillis() - start));
    }
    /**线程不安全的计数器*/
    public void count(){
        count++;
    }
    /**线程安全的计数器，循环CAS*/
    public void safeCount(){
        for(;;){
            int temp = atomicI.get();
            if(atomicI.compareAndSet(temp,++temp))
                break;
        }
    }
}
```
>http://www.php.cn/java-article-412095.html

# 12.多线程同步的方法

- 同步方法   

即有synchronized关键字修饰的方法。由于java的每个对象都有一个内置锁，当用此关键字修饰方法时，内置锁会保护整个方法。在调用该方法前，需要获得内置锁，否则就处于阻塞状态。
```JAVA
public synchronized void save(){}
```
<font color="red">synchronized关键字也可以修饰静态方法，此时如果调用该静态方法，将会锁住整个类</font>

- 同步代码块   

即有synchronized关键字修饰的语句块。被该关键字修饰的语句块会自动被加上内置锁，从而实现同步
```JAVA 
    synchronized(object){ 
    }
```
<font color="red">注：同步是一种高开销的操作，因此应该尽量减少同步的内容。通常没有必要同步整个方法，使用synchronized代码块同步关键代码即可</font>

- 使用特殊域变量(volatile)实现线程同步
    - volatile关键字为域变量的访问提供了一种免锁机制， 
    - 使用volatile修饰域相当于告诉虚拟机该域可能会被其他线程更新， 
    - 因此每次使用该域就要重新计算，而不是使用寄存器中的值 
    - volatile不会提供任何原子操作，它也不能用来修饰final类型的变量
```JAVA
//只给出要修改的代码，其余代码与上同
        class Bank {
            //需要同步的变量加上volatile
            private volatile int account = 100;

            public int getAccount() {
                return account;
            }
            //这里不再需要synchronized 
            public void save(int money) {
                account += money;
            }
        ｝
```
<font color="red">   注：多线程中的非同步问题主要出现在对域的读写上，如果让域自身避免这个问题，则就不需要修改操作该域的方法。用final域，有锁保护的域和volatile域可以避免非同步的问题。</font>

- 使用重入锁实现线程同步
在JavaSE5.0中新增了一个java.util.concurrent包来支持同步。ReentrantLock类是可重入、互斥、实现了Lock接口的锁，它与使用synchronized方法和快具有相同的基本行为和语义，并且扩展了其能力。

ReenreantLock类的常用方法有：
        1. ReentrantLock() : 创建一个ReentrantLock实例 
        2. lock() : 获得锁 
        3. unlock() : 释放锁 
<font color="red">注：ReentrantLock()还有一个可以创建公平锁的构造方法，但由于能大幅度降低程序运行效率，不推荐使用
</font>

```JAVA
//只给出要修改的代码，其余代码与上同
        class Bank {
            
            private int account = 100;
            //需要声明这个锁
            private Lock lock = new ReentrantLock();
            public int getAccount() {
                return account;
            }
            //这里不再需要synchronized 
            public void save(int money) {
                lock.lock();
                try{
                    account += money;
                }finally{
                    lock.unlock();
                }
                
            }
        ｝
```
<font color="red">
    注：关于Lock对象和synchronized关键字的选择：    
         a. 最好两个都不用，使用一种java.util.concurrent包提供的机制，能够帮助用户处理所有与锁相关的代码。    
         b. 如果synchronized关键字能满足用户的需求，就用synchronized，因为它能简化代码    
         c. 如果需要更高级的功能，就用ReentrantLock类，此时要注意及时释放锁，否则会出现死锁，通常在finally代码释放锁   
</font>

- 使用局部变量实现线程同步

如果使用ThreadLocal管理变量，则每一个使用该变量的线程都获得该变量的副本，副本之间相互独立，这样每一个线程都可以随意修改自己的变量副本，而不会对其他线程产生影响。

ThreadLocal 类的常用方法：

ThreadLocal() : 创建一个线程本地变量    
get() : 返回此线程局部变量的当前线程副本中的值    
initialValue() : 返回此线程局部变量的当前线程的"初始值"    
set(T value) : 将此线程局部变量的当前线程副本中的值设置为value   

```JAVA
//只改Bank类，其余代码与上同
        public class Bank{
            //使用ThreadLocal类管理共享变量account
            private static ThreadLocal<Integer> account = new ThreadLocal<Integer>(){
                @Override
                protected Integer initialValue(){
                    return 100;
                }
            };
            public void save(int money){
                account.set(account.get()+money);
            }
            public int getAccount(){
                return account.get();
            }
        }
```
<font color="red">
  注：ThreadLocal与同步机制    
        a.ThreadLocal与同步机制都是为了解决多线程中相同变量的访问冲突问题。    
        b.前者采用以"空间换时间"的方法，后者采用以"时间换空间"的方式。   
</font>

- 使用阻塞队列实现线程同步

前面5种同步方式都是在底层实现的线程同步，但是我们在实际开发当中，应当尽量远离底层结构。使用javaSE5.0版本中新增的java.util.concurrent包将有助于简化开发。本小节主要是使用LinkedBlockingQueue<E>来实现线程的同步LinkedBlockingQueue<E>是一个基于已连接节点的，范围任意的blocking queue。

   LinkedBlockingQueue 类常用方法 ：   
    LinkedBlockingQueue() : 创建一个容量为Integer.MAX_VALUE的LinkedBlockingQueue    
    put(E e) : 在队尾添加一个元素，如果队列满则阻塞    
    size() : 返回队列中的元素个数     
    take() : 移除并返回队头元素，如果队列空则阻塞    
```JAVA
package com.xhj.thread;

import java.util.Random;
import java.util.concurrent.LinkedBlockingQueue;

/**
 * 用阻塞队列实现线程同步 LinkedBlockingQueue的使用
 * 
 * @author XIEHEJUN
 * 
 */
public class BlockingSynchronizedThread {
    /**
     * 定义一个阻塞队列用来存储生产出来的商品
     */
    private LinkedBlockingQueue<Integer> queue = new LinkedBlockingQueue<Integer>();
    /**
     * 定义生产商品个数
     */
    private static final int size = 10;
    /**
     * 定义启动线程的标志，为0时，启动生产商品的线程；为1时，启动消费商品的线程
     */
    private int flag = 0;

    private class LinkBlockThread implements Runnable {
        @Override
        public void run() {
            int new_flag = flag++;
            System.out.println("启动线程 " + new_flag);
            if (new_flag == 0) {
                for (int i = 0; i < size; i++) {
                    int b = new Random().nextInt(255);
                    System.out.println("生产商品：" + b + "号");
                    try {
                        queue.put(b);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    System.out.println("仓库中还有商品：" + queue.size() + "个");
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            } else {
                for (int i = 0; i < size / 2; i++) {
                    try {
                        int n = queue.take();
                        System.out.println("消费者买去了" + n + "号商品");
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    System.out.println("仓库中还有商品：" + queue.size() + "个");
                    try {
                        Thread.sleep(100);
                    } catch (Exception e) {
                        // TODO: handle exception
                    }
                }
            }
        }
    }

    public static void main(String[] args) {
        BlockingSynchronizedThread bst = new BlockingSynchronizedThread();
        LinkBlockThread lbt = bst.new LinkBlockThread();
        Thread thread1 = new Thread(lbt);
        Thread thread2 = new Thread(lbt);
        thread1.start();
        thread2.start();

    }

}
```

<font color="red">
注：BlockingQueue<E>定义了阻塞队列的常用方法，尤其是三种添加元素的方法，我们要多加注意，当队列满时：   
　　add()方法会抛出异常   
　　offer()方法返回false   
　　put()方法会阻塞   
</font>

- 使用原子变量实现线程同步
需要使用线程同步的根本原因在于对普通变量的操作不是原子的。   
那么什么是原子操作呢？   
原子操作就是指将读取变量值、修改变量值、保存变量值看成一个整体来操作，即-这几种行为要么同时完成，要么都不完成。
在java的util.concurrent.atomic包中提供了创建了原子类型变量的工具类，使用该类可以简化线程同步。   
其中AtomicInteger 表可以用原子方式更新int的值，可用在应用程序中(如以原子方式增加的计数器)，但不能用于替换Integer；可扩展Number，允许那些处理机遇数字类的工具和实用工具进行统一访问。   
AtomicInteger类常用方法：   
AtomicInteger(int initialValue) : 创建具有给定初始值的新的AtomicInteger   
addAddGet(int dalta) : 以原子方式将给定值与当前值相加   
get() : 获取当前值   

```JAVA
class Bank {
        private AtomicInteger account = new AtomicInteger(100);

        public AtomicInteger getAccount() {
            return account;
        }

        public void save(int money) {
            account.addAndGet(money);
        }
    }
```

<font color="red">
补充--原子操作主要有：   
　　对于引用变量和大多数原始变量(long和double除外)的读写操作；   
　　对于所有使用volatile修饰的变量(包括long和double)的读写操作。    
</font>
>https://www.cnblogs.com/XHJT/p/3897440.html

# 13.介绍一下生产者消费者模式
在实际的软件开发过程中，经常会碰到如下场景：某个模块负责产生数据，这些数据由另一个模块来负责处理（此处的模块是广义的，可以是类、函数、线程、进程等）。产生数据的模块，就形象地称为生产者；而处理数据的模块，就称为消费者。     
单单抽象出生产者和消费者，还够不上是生产者／消费者模式。该模式还需要有一个缓冲区处于生产者和消费者之间，作为一个中介。生产者把数据放入缓冲区，而消费者从缓冲区取出数据。大概的结构如下图。
![生产者消费者](../images/生产者消费者.png)     

# 14.线程,进程,然后线程创建有很大开销,怎么优化
进程概念：

进程是表示资源分配的基本单位，又是调度运行的基本单位。例如，用户运行自己的程序，系统就创建一个进程，并为它分配资源，包括各种表格、内存空间、磁盘空间、I/O设备等。然后，把该进程放人进程的就绪队列。进程调度程序选中它，为它分配CPU以及其它有关资源，该进程才真正运行。所以，进程是系统中的并发执行的单位。

在Mac、Windows NT等采用微内核结构的操作系统中，进程的功能发生了变化：它只是资源分配的单位，而不再是调度运行的单位。在微内核系统中，真正调度运行的基本单位是线程。因此，实现并发功能的单位是线程。


进程的两个基本属性：

1. 进程是一个可拥有资源的独立单位；
2. 进程同时又是——个可以独立调度和分派的基本单位。正是由于进程具有这两个基本属性，才使之成为一个能独立运行的基本单位，从而也就构成了进程并发执行的基础。


线程概念

线程是进程中执行运算的最小单位，亦即执行处理机调度的基本单位。如果把进程理解为在逻辑上操作系统所完成的任务，那么线程表示完成该任务的许多可能的子任务之一。例如，假设用户启动了一个窗口中的数据库应用程序，操作系统就将对数据库的调用表示为一个进程。假设用户要从数据库中产生一份工资单报表，并传到一个文件中，这是一个子任务；在产生工资单报表的过程中，用户又可以输人数据库查询请求，这又是一个子任务。这样，操作系统则把每一个请求――工资单报表和新输人的数据查询表示为数据库进程中的独立的线程。线程可以在处理器上独立调度执行，这样，在多处理器环境下就允许几个线程各自在单独处理器上进行。操作系统提供线程就是为了方便而有效地实现这种并发性。

进程和线程的关系

1. 一个线程只能属于一个进程，而一个进程可以有多个线程，但至少有一个线程。线程是操作系统可识别的最小执行和调度单位。
2. 资源分配给进程，同一进程的所有线程共享该进程的所有资源。 同一进程中的多个线程共享代码段(代码和常量)，数据段(全局变量和静态变量)，扩展段(堆存储)。但是每个线程拥有自己的栈段，栈段又叫运行时段，用来存放所有局部变量和临时变量。
3. 处理机分给线程，即真正在处理机上运行的是线程。
4. 线程在执行过程中，需要协作同步。不同进程的线程间要利用消息通信的办法实现同步。

引入线程的好处

1. 易于调度。
2. 提高并发性。通过线程可方便有效地实现并发性。进程可创建多个线程来执行同一程序的不同部分。
3. 开销少。创建线程比创建进程要快，所需开销很少。。
4. 利于充分发挥多处理器的功能。通过创建多线程进程（即一个进程可具有两个或更多个线程），每个线程在一个处理器上运行，从而实现应用程序的并发性，使每个处理器都得到充分运行。

然而为使程序能并发执行，系统还必须进行以下的一系列操作：

1. 创建进程。系统在创建进程时，必须为之分配其所必需的、除处理机以外的所有资源。如内存空间、I／0设备以及建立相应的PCB。
2. 撤消进程。系统在撤消进程时，又必须先对这些资源进行回收操作，然后再撤消PCB。
3. 进程切换。在对进程进行切换时，由于要保留当前进程的CPU环境和设置新选中进程的CPU环境，为此需花费不少处理机时间。

多线程在以下方面会带来开销：

1. 切换上下文。   
产生原因举例：多线程竞争锁时被阻塞，该线程就会阻塞，会被jvm挂起，造成上下文切换，目的是为了新线程分配新的资源。如果线程数多于cpu内核数多会引起上下文的切换。   
如何分析上下文切换开销太大：unix系列的vmstat及windows系统的perfmon都能报告上下文切换占用时间，如果超过内核的10%时间，那就很有可能是线程阻塞或者竞争锁引起。
vmstat命令各个列的含义如下表：

    |列名|含义|
    |------|------|
    |r|运行队列的长度，即等待执行的线程数目|
    |b|处于阻塞状态或者等待IO完成状态的线程数目|
    |in|系统中断的数目|
    |cs|上下文切换的数目|
    |us|CPU执行用户态线程的时间占比|
    |sys|CPU执行系统态线程占用的时间占比，包含内核和中断两部分|
    |wa|CPU处于等待状态的时间占比（CPU等待状态即所有线程都处于被阻塞或者等待IO完成状态）|
    |id|CPU处于完全空闲状态的时间占比|

2. 内存同步   
synchronized，volatile会设置memory barrier（内存关卡），要求必需使用内存关卡来进行缓存刷新，缓存无效，形成性能瓶颈，影响重排序，如何进行优化：逃逸分析方法，简单的理解就是看该本地对象是否未被堆中对象引用，如果没有就可进行锁消除等操作，很多工作实际在jvm中的jit进行优化编译时就会做掉，比如常用的锁优化机制：自旋锁、锁消除、锁粗化、偏向锁等。

3.  阻塞   
 非竞争的同步由jvm完全掌控，而竞争的同步可能会需要os的活动，从而引起较大的开销，既然有竞争，竞争失败的线程肯定会引起阻塞。如何处理阻塞；

    两种方式：   
    自旋、挂起自旋应用场景：等待时间短   
    挂起：适合等待时间长

通过线程池优化

# 15.线程池运行流程,参数,策略

__线程池参数详解__
```JAVA
public ThreadPoolExecutor(int corePoolSize,
                          int maximumPoolSize,
                          long keepAliveTime,
                          TimeUnit unit,
                          BlockingQueue<Runnable> workQueue,
                          ThreadFactory threadFactory,
                          RejectedExecutionHandler handler)
```
- corePoolSize：核心线程数量，线程池初始化的时候，就创建好相当数量的线程
- maximumPoolSize：最大线程数量
- keepAliveTime：非核心线程的存活时间，当核心线程都用上后，后续请求将有可能创建非核心线程（newSingleThreadExecutor、newFixedThreadPool不会创建非核心线程）， 非核心线程执行完任务后，闲置时间超过keepAliveTime，则会被回收掉。如果ThreadPoolExecutor的allowCoreThreadTimeOut属性设置为true，则该参数也表示核心线程的超时时长。
    - executorService.allowCoreThreadTimeOut(true);
        - true：keepAliveTime同样影响核心线程，最终线程池线程数量为0
        - false：keepAliveTime只影响非核心线程
- unit：keepAliveTime的时间单位。
- workQueue：任务队列，该队列主要用来存储已经被提交但是尚未执行的任务。
- threadFactory：为线程池提供自定义功能，一般用来自定义线程池的名称。
- handler：拒绝策略，当线程无法执行新任务时（一般是由于线程池中的线程数量已经达到最大数或者线程池关闭导致的），默认情况下，当线程池无法处理新线程时，会抛出一个RejectedExecutionException。

线程池还有一个隐藏参数概念，就是非核心线程：   
<font color="red">
非核心线程数 = 最大线程数 - 核心线程数
</font>

- 任务来了，当正在执行任务的线程数 < 核心线程数，则任务直接交由核心线程执行
- 任务来了，当核心线程都在执行任务，并且队列workQueue未满，则任务会先放到队列中等待执行
- 任务来了，当核心线程都在执行任务，并且队列workQueue也满了，则开启一个非核心线程执行任务
- 任务来了，当核心线程都在执行任务，并且队列workQueue也满了，也达到了线程池允许的最大线程数量，则触发handler拒绝策略默认抛出RejectExecutionException异常

__workQueue__   
有界表示数组或链表有大小，无界表示无上限

- __有界队列__

    - ArrayBlockingQueue ：一个由数组结构组成的有界阻塞队列。
    - LinkedBlockingQueue ：一个由链表结构组成的有界阻塞队列。

- __无界队列__
    - PriorityBlockingQueue ：一个支持优先级排序的无界阻塞队列。
    - DelayQueue： 一个使用优先级队列实现的无界阻塞队列。
    - SynchronousQueue： 一个不存储元素的阻塞队列。
    - LinkedTransferQueue： 一个由链表结构组成的无界阻塞队列。【MAX:2147483647】
    - LinkedBlockingDeque： 一个由链表结构组成的双向阻塞队列。

__handler__   
线程无法执行新任务时的拒绝策略

    - ThreadPoolExecutor.AbortPolicy:丢弃任务并抛出RejectedExecutionException异常。
    - ThreadPoolExecutor.DiscardPolicy：也是丢弃任务，但是不抛出异常。
    - ThreadPoolExecutor.DiscardOldestPolicy：丢弃队列最前面的任务，然后重新尝试执行任务（重复此过程）
    - ThreadPoolExecutor.CallerRunsPolicy：只要线程池不关闭，该策略直接在调用者线程中，运行当前被丢弃的任务

这4中策略不友好，最好自己定义拒绝策略，实现RejectedExecutionHandler接口。

# 16.讲一下AQS吧
AbstractQueuedSynchronizer(抽象的队列式同步器，AQS)，AQS定义了一套多线程访问共享资源的同步器框架，许多同步类实现都依赖于它，如常用的ReentrantLock/Semaphore/CountDownLatch...。
![AQS](../images/AQS.png)   
它维护了一个volatile int state（代表共享资源）和一个FIFO线程等待队列（多线程争用资源被阻塞时会进入此队列）。这里volatile是核心关键词，具体volatile的语义，在此不述。state的访问方式有三种:

- getState()
- setState()
- compareAndSetState()

AQS定义两种资源共享方式：Exclusive（独占，只有一个线程能执行，如ReentrantLock）和Share（共享，多个线程可同时执行，如Semaphore/CountDownLatch）。

不同的自定义同步器争用共享资源的方式也不同。自定义同步器在实现时只需要实现共享资源state的获取与释放方式即可，至于具体线程等待队列的维护（如获取资源失败入队/唤醒出队等），AQS已经在顶层实现好了。

自定义同步器实现时主要实现以下几种方法：

- isHeldExclusively()：该线程是否正在独占资源。只有用到condition才需要去实现它。
- tryAcquire(int)：独占方式。尝试获取资源，成功则返回true，失败则返回false。
- tryRelease(int)：独占方式。尝试释放资源，成功则返回true，失败则返回false。
- tryAcquireShared(int)：共享方式。尝试获取资源。负数表示失败；0表示成功，但没有剩余可用资源；正数表示成功，且有剩余资源。
- tryReleaseShared(int)：共享方式。尝试释放资源，如果释放后允许唤醒后续等待结点返回true，否则返回false。

以ReentrantLock为例:state初始化为0，表示未锁定状态。A线程lock()时，会调用tryAcquire()独占该锁并将state+1。此后，其他线程再tryAcquire()时就会失败，直到A线程unlock()到state=0（即释放锁）为止，其它线程才有机会获取该锁。当然，释放锁之前，A线程自己是可以重复获取此锁的（state会累加），这就是可重入的概念。但要注意，获取多少次就要释放多么次，这样才能保证state是能回到零态的。

再以CountDownLatch以例，任务分为N个子线程去执行，state也初始化为N（注意N要与线程个数一致）。这N个子线程是并行执行的，每个子线程执行完后countDown()一次，state会CAS减1。等到所有子线程都执行完后(即state=0)，会unpark()主调用线程，然后主调用线程就会从await()函数返回，继续后余动作。

一般来说，自定义同步器要么是独占方法，要么是共享方式，他们也只需实现tryAcquire-tryRelease、tryAcquireShared-tryReleaseShared中的一种即可。但AQS也支持自定义同步器同时实现独占和共享两种方式，如ReentrantReadWriteLock。
## acquire(int)
此方法是独占模式下线程获取共享资源的顶层入口。如果获取到资源，线程直接返回，否则进入等待队列，直到获取到资源为止，且整个过程忽略中断的影响。这也正是lock()的语义，当然不仅仅只限于lock()。获取到资源后，线程就可以去执行其临界区代码了。下面是acquire()的源码：


```JAVA
public final void acquire(int arg) {
     if (!tryAcquire(arg) &&
         acquireQueued(addWaiter(Node.EXCLUSIVE), arg))
         selfInterrupt();
}
```

1. 调用自定义同步器的tryAcquire()尝试直接去获取资源，如果成功则直接返回；
2. 没成功，则addWaiter()将该线程加入等待队列的尾部，并标记为独占模式；
3. acquireQueued()使线程在等待队列中休息,有机会时(轮到自己,会被unpark()会去尝试获取资源。获取到资源后才返回。如果在整个等待过程中被中断过，则返回true，否则返回false。
4. 如果线程在等待过程中被中断过，它是不响应的。只是获取资源后才再进行自我中断selfInterrupt()，将中断补上。
![acquire](../images/acquire.png)

## release(int)
此方法是独占模式下线程释放共享资源的顶层入口。它会释放指定量的资源，如果彻底释放了（即state=0），它会唤醒等待队列里的其他线程来获取资源。这也正是unlock()的语义，当然不仅仅只限于unlock()。下面是release()的源码：

```JAVA
public final boolean release(int arg) {
    if (tryRelease(arg)) {
        Node h = head;//找到头结点
        if (h != null && h.waitStatus != 0)
            unparkSuccessor(h);//唤醒等待队列里的下一个线程
        return true;
    }
    return false;
}
```

```JAVA
private void unparkSuccessor(Node node) {
    //这里，node一般为当前线程所在的结点。
    int ws = node.waitStatus;
    if (ws < 0)//置零当前线程所在的结点状态，允许失败。
        compareAndSetWaitStatus(node, ws, 0);

    Node s = node.next;//找到下一个需要唤醒的结点s
    if (s == null || s.waitStatus > 0) {//如果为空或已取消
        s = null;
        for (Node t = tail; t != null && t != node; t = t.prev)
            if (t.waitStatus <= 0)//从这里可以看出，<=0的结点，都是还有效的结点。
                s = t;
    }
    if (s != null)
        LockSupport.unpark(s.thread);//唤醒
}
```

用unpark()唤醒等待队列中最前边的那个未放弃线程，这里我们也用s来表示吧。此时，再和acquireQueued()联系起来，s被唤醒后，进入if(p==head&&tryAcquire(arg))的判断（即使p!=head也没关系,它会再进入shouldParkAfterFailedAcquire()寻找一个安全点。这里既然s已经是等待队列中最前边的那个未放弃线程了，那么通过shouldParkAfterFailedAcquire()的调整，s也必然会跑到head的next结点，下一次自旋p==head就成立啦），然后s把自己设置成head标杆结点，表示自己已经获取到资源了，acquire()也返回了！

release()是独占模式下线程释放共享资源的顶层入口.它会释放指定量的资源,如果彻底释放了(即state=0),它会唤醒等待队列里的其他线程来获取资源。

## acquireShared(int)
此方法是共享模式下线程获取共享资源的顶层入口。它会获取指定量的资源，获取成功则直接返回，获取失败则进入等待队列，直到获取到资源为止，整个过程忽略中断。下面是acquireShared()的源码：

```JAVA
public final void acquireShared(int arg) {
    if (tryAcquireShared(arg) < 0)
        doAcquireShared(arg);
}
```

acquireShared()流程：

- tryAcquireShared()尝试获取资源，成功则直接返回；
- 失败则通过doAcquireShared()进入等待队列park()，直到被unpark()/interrupt()并成功获取到资源才返回。整个等待过程也是忽略中断的。

## releaseShared()
上一小节已经把acquireShared()说完了，这一小节就来讲讲它的反操作releaseShared()吧。此方法是共享模式下线程释放共享资源的顶层入口。它会释放指定量的资源，如果成功释放且允许唤醒等待线程，它会唤醒等待队列里的其他线程来获取资源。下面是releaseShared()的源码：

```JAVA
public final boolean releaseShared(int arg) {
    if (tryReleaseShared(arg)) {//尝试释放资源
        doReleaseShared();//唤醒后继结点
        return true;
    }
    return false;
}
```

释放掉资源后，唤醒后继。跟独占模式下的release()相似，但有一点稍微需要注意：独占模式下的tryRelease()在完全释放掉资源（state=0）后，才会返回true去唤醒其他线程，这主要是基于独占下可重入的考量；而共享模式下的releaseShared()则没有这种要求，共享模式实质就是控制一定量的线程并发执行，那么拥有资源的线程在释放掉部分资源时就可以唤醒后继等待结点。

以AQS源码里的Mutex为例，讲一下AQS的简单应用。

Mutex是一个不可重入的互斥锁实现。锁资源（AQS里的state）只有两种状态：0表示未锁定，1表示锁定。下边是Mutex的核心源码：

```JAVA
class Mutex implements Lock, java.io.Serializable {
    // 自定义同步器
    private static class Sync extends AbstractQueuedSynchronizer {
        // 判断是否锁定状态
        protected boolean isHeldExclusively() {
            return getState() == 1;
        }

        // 尝试获取资源，立即返回。成功则返回true，否则false。
        public boolean tryAcquire(int acquires) {
            assert acquires == 1; // 这里限定只能为1个量
            if (compareAndSetState(0, 1)) {//state为0才设置为1，不可重入！
                setExclusiveOwnerThread(Thread.currentThread());//设置为当前线程独占资源
                return true;
            }
            return false;
        }

        // 尝试释放资源，立即返回。成功则为true，否则false。
        protected boolean tryRelease(int releases) {
            assert releases == 1; // 限定为1个量
            if (getState() == 0)//既然来释放，那肯定就是已占有状态了。只是为了保险，多层判断！
                throw new IllegalMonitorStateException();
            setExclusiveOwnerThread(null);
            setState(0);//释放资源，放弃占有状态
            return true;
        }
    }

    // 真正同步类的实现都依赖继承于AQS的自定义同步器！
    private final Sync sync = new Sync();

    //lock<-->acquire。两者语义一样：获取资源，即便等待，直到成功才返回。
    public void lock() {
        sync.acquire(1);
    }

    //tryLock<-->tryAcquire。两者语义一样：尝试获取资源，要求立即返回。成功则为true，失败则为false。
    public boolean tryLock() {
        return sync.tryAcquire(1);
    }

    //unlock<-->release。两者语文一样：释放资源。
    public void unlock() {
        sync.release(1);
    }

    //锁是否占有状态
    public boolean isLocked() {
        return sync.isHeldExclusively();
    }
}
```

同步类在实现时一般都将自定义同步器（sync）定义为内部类，供自己使用；而同步类自己（Mutex）则实现某个接口，对外服务。当然，接口的实现要直接依赖sync，它们在语义上也存在某种对应关系！！而sync只用实现资源state的获取-释放方式tryAcquire-tryRelelase，至于线程的排队、等待、唤醒等，上层的AQS都已经实现好了，我们不用关心。

　　除了Mutex，ReentrantLock/CountDownLatch/Semphore这些同步类的实现方式都差不多，不同的地方就在获取-释放资源的方式tryAcquire-tryRelelase。掌握了这点，AQS的核心便被攻破了。
>http://www.cnblogs.com/waterystone/p/4920797.html

# 17.创建线程的方法,哪个更好,为什么
1. 继承Thread类（真正意义上的线程类），是Runnable接口的实现。
2. 实现Runnable接口，并重写里面的run方法。
3. 实现Callable接口通过FutureTask包装器来创建Thread线程
4. 使用ExecutorService、Callable、Future实现有返回结果的线程

Runnable接口有如下好处：

1. 避免点继承的局限，一个类可以继承多个接口。
2. 适合于资源的共享


Thread的常用方法：

- start()：启动线程并执行相应的run()方法
- run():子线程要执行的代码放入run()方法中
- currentThread()：静态的，调取当前的线程
- getName():获取此线程的名字
- setName():设置此线程的名字
- yield():调用此方法的线程释放当前CPU的执行权（很可能自己再次抢到资源）
- join():在A线程中调用B线程的join()方法，表示：当执行到此方法，A线程停止执行，直至B线程执行完毕，
- A线程再接着join()之后的代码执行
- isAlive():判断当前线程是否还存活
- sleep(long l):显式的让当前线程睡眠l毫秒  (只能捕获异常，因为父类run方法没有抛异常)
- 线程通信（方法在Object类中）：wait()   notify()  notifyAll()
- 设置线程的优先级（非绝对，只是相对几率大些）
- getPriority()：返回线程优先值
- setPriority(int newPriority)：改变线程的优先级

# 18.Java中有几种线程池
- newCachedThreadPool

    创建一个可缓存线程池，如果线程池长度超过处理需要，可灵活回收空闲线程，若无可回收，则新建线程。     
    这种类型的线程池特点是：    

    - 工作线程的创建数量几乎没有限制(其实也有限制的,数目为Interger. MAX_VALUE), 这样可灵活的往线程池中添加线程。
    - 如果长时间没有往线程池中提交任务，即如果工作线程空闲了指定的时间(默认为1分钟)，则该工作线程将自动终止。终止后，如果你又提交了新的任务，则线程池重新创建一个工作线程。
    - 在使用CachedThreadPool时，一定要注意控制任务的数量，否则，由于大量线程同时运行，很有会造成系统瘫痪。

```JAVA
package test;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
public class ThreadPoolExecutorTest {
 public static void main(String[] args) {
  ExecutorService cachedThreadPool = Executors.newCachedThreadPool();
  for (int i = 0; i < 10; i++) {
   final int index = i;
   try {
    Thread.sleep(index * 1000);
   } catch (InterruptedException e) {
    e.printStackTrace();
   }
   cachedThreadPool.execute(new Runnable() {
    public void run() {
     System.out.println(index);
    }
   });
  }
 }
}
```

- newFixedThreadPool

创建一个指定工作线程数量的线程池。每当提交一个任务就创建一个工作线程，如果工作线程数量达到线程池初始的最大数，则将提交的任务存入到池队列中。

FixedThreadPool是一个典型且优秀的线程池，它具有线程池提高程序效率和节省创建线程时所耗的开销的优点。但是，在线程池空闲时，即线程池中没有可运行任务时，它不会释放工作线程，还会占用一定的系统资源。

```JAVA
package test;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
public class ThreadPoolExecutorTest {
 public static void main(String[] args) {
  ExecutorService fixedThreadPool = Executors.newFixedThreadPool(3);
  for (int i = 0; i < 10; i++) {
   final int index = i;
   fixedThreadPool.execute(new Runnable() {
    public void run() {
     try {
      System.out.println(index);
      Thread.sleep(2000);
     } catch (InterruptedException e) {
      e.printStackTrace();
     }
    }
   });
  }
 }
}
```

- newSingleThreadExecutor
创建一个单线程化的Executor，即只创建唯一的工作者线程来执行任务，它只会用唯一的工作线程来执行任务，保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行。如果这个线程异常结束，会有另一个取代它，保证顺序执行。单工作线程最大的特点是可保证顺序地执行各个任务，并且在任意给定的时间不会有多个线程是活动的。

```JAVA
package test;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
public class ThreadPoolExecutorTest {
 public static void main(String[] args) {
  ExecutorService singleThreadExecutor = Executors.newSingleThreadExecutor();
  for (int i = 0; i < 10; i++) {
   final int index = i;
   singleThreadExecutor.execute(new Runnable() {
    public void run() {
     try {
      System.out.println(index);
      Thread.sleep(2000);
     } catch (InterruptedException e) {
      e.printStackTrace();
     }
    }
   });
  }
 }
}
```

- newScheduleThreadPool
创建一个定长的线程池，而且支持定时的以及周期性的任务执行，支持定时及周期性任务执行。

```JAVA
package test;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
public class ThreadPoolExecutorTest {
 public static void main(String[] args) {
  ScheduledExecutorService scheduledThreadPool = Executors.newScheduledThreadPool(5);
  scheduledThreadPool.schedule(new Runnable() {
   public void run() {
    System.out.println("delay 3 seconds");
   }
  }, 3, TimeUnit.SECONDS);
 }
}
```

# 19.线程池有什么好处
线程池的好处

1. 通过重复利用已创建的线程，减少在创建和销毁线程上所花的时间以及系统资源的开销。 
2. 提高响应速度，当任务到达时，任务可以不需要等到线程创建就可以立即执行。 
3. 提高线程的可管理性，使用线程池可以对线程进行统一的分配和监控。 
4. 如果不使用线程池，有可能造成系统创建大量线程而导致消耗完系统内存。

线程池的注意事项：

1. 线程池的大小：多线程应用并非线程越多越好。需要根据系统运行的硬件环境以及应用本身的特点决定线程池的大小。一般来说，如果代码结构合理，线程数与cpu数量相适合即可。如果线程运行时可能出现阻塞现象，可相应增加池的大小、如果有必要可采用自适应算法来动态调整线程池的大小。以提高cpu的有效利用率和系统的整体性能。 
2. 并发错误：多线程应用要特别注意并发错误，要从逻辑上保证程序的正确性，注意避免死锁现象的发生。 
3. 线程泄露：这是线程池应用中的一个严重的问题、当任务执行完毕而线程没能返回池中就会发生线程泄露现象。

# 20.cyclicbarrier和countdownlatch的区别
__ CountDownLatch__

Countdownlatch是一个同步工具类；用来协调多个线程之间的同步；     
这个工具通常用来控制线程等待；它可以让某一个线程等待知道倒计时结束，在开始执行；

__CountDownLatch的两种用法：__

- 某一线程在开始运行前等待n个线程执行完毕；将CountDownLatch的计数器初始化为n：new CountDownLatch(n);每当一个任务线程执行完毕，就将计数器减1，CountDownLatch.Countdown；当计数器的值变为0时；在CountDownLatch上await()的线程就会被唤醒。一个典型应用场景就是启动一个服务时，主线程需要等待多个组件加载完毕；
- 实现多个线程开始执行任务的最大并行性；注意是并行性；而不是并发性；强调的是多个线程在某一时刻同时执行，类似于赛跑；将多个线程放到起点；等待发令枪响；然后同时开跑；做法是初始化一个共享的CountDownLatch对象；将其计数器初始化为1：new CountdownLatch（1）；多个线程在开始执行任务前首先CountDownLatch.await（）,当主线程调用countdownl时，计数器变为0；多个线程同时被唤醒；
```JAVA
package com.practice.test;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CountDownLatchExample1 {
    public static final int threadCount = 550;

    public static void main(String[] args) throws InterruptedException {
        ExecutorService threadpool = Executors.newFixedThreadPool(300);
        final CountDownLatch cl = new CountDownLatch(threadCount);
        for (int i = 0; i < threadCount; i++) {
            final int threadnum = i;
            threadpool.execute(() -> {
                try {
                    test(threadnum);
                } catch (InterruptedException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } finally {
                    cl.countDown();
                }
            });
        }
        cl.await();
        threadpool.shutdown();
        System.out.println("finish");
    }

    public static void test(int threadnum) throws InterruptedException {
        Thread.sleep(1000);
        System.out.println("threadnum" + threadnum);
        Thread.sleep(1000);
    }

}
```
- Countdownlatch的不足

Countdownlatch是一次性的，计数器的值只能在构造方法中初始化一次，之后没有任何机制再次对其设置值，当CountDownLatch使用完毕后，他不能再次被使用

__CyclicBarrier__

CyclicBarrier和CountDownLatch非常类似，他也可以实现线程间的技术等待，但是它的功能比CountDownLatch更加强大和复杂。主要应用场景和CountDownLatch类似

CyclicBarrier的字面意思是可循环使用的屏障，它要做的事情是，让一组线程到达一个屏障时被阻塞，直到最后一个线程到达屏障时，屏障才会开门，所有被屏障拦截的线程才会继续干活。CyclicBarrier默认的构造方法时CyclicBarrier（int parties），其参数表示屏障拦截的线程数量，每个线程调用await方法告诉CyclicBarrier我已经到达了屏障。然后当前线程被阻塞；

```JAVA
package com.practice.test;

import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

public class CyclicBarrierExample2 {
    private static final int threadcount = 550;
    private static final CyclicBarrier cyb = new CyclicBarrier(5);

    public static void main(String[] args) throws InterruptedException {
        ExecutorService threadpool = Executors.newFixedThreadPool(10);
        for (int i = 0; i < threadcount; i++) {
            final int num = i;
            Thread.sleep(1000);
            threadpool.execute(() -> {
                try {
                    try {
                        test(num);
                    } catch (TimeoutException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                } catch (InterruptedException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (BrokenBarrierException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }

            });
        }
        threadpool.shutdown();
    }

    public static void test(int threadnum) throws InterruptedException, BrokenBarrierException, TimeoutException {
        System.out.println("threadnum" + threadnum + "is ready");
        try {
        cyb.await(2000, TimeUnit.MILLISECONDS);
        } catch (Exception e) {
            System.out.println("CyclicBarrier");
        }
        System.out.println("threadnum" + threadnum + "isFinish");
    }
}
```

__CyclicBarrier的应用场景__

CyclicBarrier可以用于多线程计算数据，最后合并结果的应用场景。比如我们用一个Excel保存了用户所有银行流水，每个Sheet保存每一个账户近一年的每一笔银行流水，现在需要统计用户的日均银行流水，先用多线程处理每个sheet里的银行流水，都执行完之后，得到每个sheet的日均银行流水，最后，使用barrierAction用这些线程的计算结果，计算出整个Excel的日均银行流水；

CyclicBarrier（int parties，Runnable BarrierAction），在线程到达屏障时，优先执行BarrierAction，方便处理更复杂的业务场景；

```JAVA
package com.practice.test;

import java.util.concurrent.CyclicBarrier;

public class CyclicBarrierTest {
    public static void main(String[] args) {
        CyclicBarrier cyl = new CyclicBarrier(5, () -> {
            System.out.println("线程组执行结束");

        });
        for (int i = 0; i < 5; i++) {
            new Thread(new Readnum(i, cyl)).start();
        }
    }

    static class Readnum implements Runnable {
        private int id;
        private CyclicBarrier cdl;

        public Readnum(int id, CyclicBarrier cdl) {
            super();
            this.id = id;
            this.cdl = cdl;
        }

        @Override
        public void run() {
            synchronized (this) {
                System.out.println(Thread.currentThread().getName() + "id");
                try {
                    cdl.await();
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                System.out.println(Thread.currentThread().getName() + id + "结束了");

            }
        }
    }
}
```

CyclicBarrier和CountDownLatch的区别

|CountDownLatch|CyclicBarrier|
|----------------------|------------------|
|减计数方式|加计数方式|
|计数为0时，释放所有等待的线程|计数达到指定值时释放所有等待的线程|
|计数为0时，无法重置|计数达到指定值时，计数置为0重新开始|
|调用countDown()方法计数减1，调用await()方法只进行阻塞，对计数没有任何影响|调用await()方法，计数+1，若加1之后的值不等于构造方法的值，则线程阻塞|
|不可重复利用|可重复利用|

CountDownLatch是计数器，只能使用一次，而CyclicBarrier的计数器提供reset功能，可以多次使用。     
JavaDoc中的定义：     
CountDownLatch：一个或者多个线程，等待其他线程完成某件事情之后，等待其他多个线程完成某件事情之后才能执行；       
CyclicBarrier：多个线程互相等待，直到到达同一个同步点，再继续一起执行；     
对于CountDownLatch来说，重点是一个线程（多个线程）等待”,而其他的N个线程在完成”某件事情“之后，可以终止，也可以等待，而对于CyclicBarrier，重点是多个线程，在任意一个线程没有完成，所有的线程都必须等待；        
CountDownLatch是计数器，线程完成一个记录一个，只不过计数不是递增而是递减，而CyclicBarrier更像是一个阀门，需要所有线程都要到达，阀门才能打开，然后继续执行；     
>https://www.cnblogs.com/yjxs/p/9911903.html

# 21.如何理解Java多线程回调方法

回答者的类

```JAVA
package com.xykj.thread;
public class XiaoZhang extends Thread {
    // 回答1+1，很简单的问题不需要线程
    public int add(int num1, int num2) {
       return num1 + num2;
    }
 
    // 重写run方法
    @Override
    public void run() {
       // 回答地球为什么是圆的
       askquestion();
       super.run();
    }
 
    // 回调接口的创建，里面要有一个回调方法
    //回调接口什么时候用呢？这个思路是最重要的
    //
   
    public static interface CallPhone {
       public void call(String question);
    }
 
    // 回调接口的对象
    CallPhone callPhone;
 
    // 回答地球为什么是圆的
    private void askquestion() {
       System.err.println("开始查找资料！");
       try {
           sleep(3000);// 思考3天
       } catch (InterruptedException e) {
           e.printStackTrace();
       }
       // 把答案返回到回调接口的call方法里面
       if (callPhone!=null) {//提问者实例化callPhone对象，相当于提问者已经告诉我，我到时用什么方式回复答案
           //这个接口的方法实现是在提问者的类里面
           callPhone.call("知道了，！！！~~~~百度有啊");
       }     
    }
}
```

提问者的类

```JAVA
package com.xykj.thread;
import com.xykj.thread.XiaoZhang.CallPhone;
public class MainClass {
    /**
     * java回调方法的使用
     * 实际操作时的步骤：（以本实例解释）
     * 1.在回答者的类内创建回调的接口
     * 2.在回答者的类内创建回调接口的对象，
     * 3.在提问者类里面实例化接口对象，重写接口方法
     * 2.-3.这个点很重要，回调对象的实例化，要在提问者的类内实例化，然后重写接口的方法
     * 相当于提问者先把一个联络方式给回答者，回答者找到答案后，通过固定的联络方式，来告诉提问者答案。
     * 4.调用开始新线程的start方法
     * 5.原来的提问者还可以做自己的事
     * */
    public static void main(String[] args) {
       // 小王问小张1+1=？，线程同步
       XiaoZhang xiaoZhang = new XiaoZhang();
       int i = xiaoZhang.add(1, 1);//回答1+1的答案
 
       // 问小张地球为什么是圆的？回调方法的使用
       //这相当于先定好一个返答案的方式，再来执行实际操作
      
       // 实例化回调接口的对象
       CallPhone phone = new CallPhone() {
           @Override
           public void call(String question) {
              //回答问题者，回答后，才能输出答案
              System.err.println(question);
           }
       };
      
       //把回调对象赋值给回答者的回调对象，回答问题者的回调对象才能回答问题
       xiaoZhang.callPhone = phone;
      
       System.out.println("交代完毕！");
       //相关交代完毕之后再执行查询操作
       xiaoZhang.start();
      
       //小王做自己的事！
       System.out.println("小王做自己的事！");
    }
 
}
```

>https://blog.csdn.net/wenzhi20102321/article/details/52512536?utm_source=blogxgwz1

# 22.概括的解释下线程的几种可用状态

1. 新建（new）：新建一个线程对象。
2. 可运行状态（runnable）：线程对象创建后，其他线程调用该对象的start()方法，该状态的线程位于可运行线程池中，等待线程调度选中，获取CPU使用权。
3. 运行状态（running）：可运行状态的线程获取到了cpu时间片（timeslice），执行程序代码。
4. 阻塞（block）：运行状态的线程因为某些原因放弃了CPU的使用权，也即让出了cpu timeslice，暂时停止运行。直到线程进入可运行状态，才有机会再次获得cpu timeslice转到运行状态。阻塞的情况分为三种：
    1. 等待阻塞：运行状态的线程对象执行了wait()方法，JVM会把该线程放入等待队列（waitting queue）中。
    2. 同步阻塞：运行状态的线程对象要获取同步锁时，若该同步锁被别的线程占用，则JVM就会把该线程放入锁池（lock pool）中。
    3. 其他阻塞：运行状态的线程对象调用了sleep()、join()方法或者发出了I/O请求时，JVM会把该线程置为阻塞状态。当sleep()状态超时、join()等待线程终止或者超时、I/O处理完毕时，线程转入可运行状态。
5. 死亡（dead）：线程run()、main()方法执行结束，或者因异常退出了run()方法，则该线程结束生命周期。死亡的线程不可复生。

![线程状态](../images/线程状态.png)
>https://blog.csdn.net/qq_24192465/article/details/78085563
