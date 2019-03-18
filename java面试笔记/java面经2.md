# 关键字
# 1.介绍一下Syncronized锁，如果用这个关键字修饰一个静态方法，锁住了什么？如果修饰成员方法，锁住了什么?
对于普通的同步方法:锁是当前的对象    
对于静态函数的同步方法:锁是指引用当前类的class对象   
对于同步方法块的内容:锁是指Synchonized括号里配置的对象   
什么是synchronized？   
它是Java中的关键字，是一种同步锁。它修饰的对象有以下几种：   
1. 修饰一个代码块，被修饰的代码块称为同步语句块，其作用的范围是大括号{}括起来的代码，作用的对象是调用这个代码块的对象；   
2. 修饰一个方法，被修饰的方法称为同步方法，其作用的范围是整个方法，作用的对象是调用这个方法的对象；    
3. 修改一个静态的方法，其作用的范围是整个静态方法，作用的对象是这个类的所有对象；   
4. 修改一个类，其作用的范围是synchronized后面括号括起来的部分，作用的对象是这个类的所有对象。   
java中共有两种类型的锁：   
（1）类锁：只有synchronized修饰静态方法或者修饰一个类的class对象时，才是类锁。   
（2）对象锁：除了类锁，所有其他的上锁方式都认为是对象锁。比如synchronized修饰普通方法或者synchronized（this)给代码块上锁等    
规则:   
（1）加了相同锁的东西，它们的访问规则是相同的，即当某个访问者获得该锁时，它们一起向该访问者开放访问，向其他没有获得该锁的访问者关闭访问；   
（2）加了不同锁的东西访问互相不干扰   
（3）而没有加锁的东西随时都可以任意访问，不受任何限制。   
怎么判断是一把相同的锁，遵循下面的规则：   
（1）不同类型的锁不是同一把锁。    
（2）加的是对象锁，那么必须是同一个对象实例才是同一把锁   
（3）加的是类锁，那必须是同一类才是同一把锁。   
#  2.介绍一下volatile？
概念：

1. 原子性：即一个操作或者多个操作 要么全部执行并且执行的过程不会被任何因素打断，要么就都不执行。Java内存模型只保证了基本读取和赋值是原子性操作，如果要实现更大范围操作的原子性，可以通过synchronized和Lock来实现。由于synchronized和Lock能够保证任一时刻只有一个线程执行该代码块，那么自然就不存在原子性问题了，从而保证了原子性。
<font color="red">必须是将数字赋值给某个变量，变量之间的相互赋值不是原子操作</font>>
2. 可见性是指当多个线程访问同一个变量时，一个线程修改了这个变量的值，其他线程能够立即看得到修改的值。当一个共享变量被volatile修饰时，它会保证修改的值会立即被更新到主存，当有其他线程需要读取时，它会去内存中读取新值。而普通的共享变量不能保证可见性，因为普通共享变量被修改之后，什么时候被写入主存是不确定的，当其他线程去读取时，此时内存中可能还是原来的旧值，因此无法保证可见性。通过synchronized和Lock也能够保证可见性，synchronized和Lock能保证同一时刻只有一个线程获取锁然后执行同步代码，并且在释放锁之前会将对变量的修改刷新到主存当中。因此可以保证可见性。
3. 有序性：即程序执行的顺序按照代码的先后顺序执行。在Java内存模型中，允许编译器和处理器对指令进行重排序，但是重排序过程不会影响到单线程程序的执行，却会影响到多线程并发执行的正确性。另外可以通过synchronized和Lock来保证有序性，很显然，synchronized和Lock保证每个时刻是有一个线程执行同步代码，相当于是让线程顺序执行同步代码，自然就保证了有序性。

**happens-before原则:**

- 程序次序规则：一个线程内，按照代码顺序，书写在前面的操作先行发生于书写在后面的操作
- 锁定规则：一个unLock操作先行发生于后面对同一个锁的lock操作
- volatile变量规则：对一个变量的写操作先行发生于后面对这个变量的读操作
- 传递规则：如果操作A先行发生于操作B，而操作B又先行发生于操作C，则可以得出操作A先行发生于操作C
- 线程启动规则：Thread对象的start()方法先行发生于此线程的每个一个动作
- 线程中断规则：对线程interrupt()方法的调用先行发生于被中断线程的代码检测到中断事件的发生
- 线程终结规则：线程中所有的操作都先行发生于线程的终止检测，我们可以通过Thread.join()方法结束、Thread.isAlive()的返回值手段检测到线程已经终止执行
- 对象终结规则：一个对象的初始化完成先行发生于他的finalize()方法的开始

第一条规则：一段程序代码的执行在单个线程中看起来是有序的。注意，虽然这条规则中提到“书写在前面的操作先行发生于书写在后面的操作”，这个应该是程序看起来执行的顺序是按照代码顺序执行的，因为虚拟机可能会对程序代码进行指令重排序。虽然进行重排序，但是最终执行的结果是与程序顺序执行的结果一致的，它只会对不存在数据依赖性的指令进行重排序。因此，在单个线程中，程序执行看起来是有序执行的，这一点要注意理解。事实上，这个规则是用来保证程序在单线程中执行结果的正确性，但无法保证程序在多线程中执行的正确性。
第二条规则也比较容易理解，也就是说无论在单线程中还是多线程中，同一个锁如果出于被锁定的状态，那么必须先对锁进行了释放操作，后面才能继续进行lock操作。   
第二条规则：无论在单线程中还是多线程中，同一个锁如果出于被锁定的状态，那么必须先对锁进行了释放操作，后面才能继续进行lock操作。   
第三条规则：如果一个线程先去写一个变量，然后一个线程去进行读取，那么写入操作肯定会先行发生于读操作。   
第四条规则：happens-before原则具备传递性。   

1. volatile关键字的两层语义。 一旦一个共享变量（类的成员变量、类的静态成员变量）被volatile修饰之后，那么就具备了两层语义：   
    - 保证了不同线程对这个变量进行操作时的可见性，即一个线程修改了某个变量的值，这新值对其他线程来说是立即可见的。   
    -  禁止进行指令重排序。

```java
public class Test {
    public volatile int inc = 0;
     
    public void increase() {
        inc++;
    }
     
    public static void main(String[] args) {
        final Test test = new Test();
        for(int i=0;i<10;i++){
            new Thread(){
                public void run() {
                    for(int j=0;j<1000;j++)
                        test.increase();
                };
            }.start();
        }
         
        while(Thread.activeCount()>1)  //保证前面的线程都执行完
            Thread.yield();
        System.out.println(test.inc);
    }
}

```

结果会小于10000，原因在于，当inc为10时，线程1从主存当中读取inc的值，然后线程1阻塞，线程2从主存当中读取inc的值，由于线程1只进行对变量的读操作，没有对变量修改，不会导致线程2的工作内存中缓存变量inc的缓存行无效，所以线程2会直接去主存读取inc的值,进行+1运算，并写入主存中，然后线程1重新获得cpu资源，也进行+1操作，并写入主存中，此时，inc进行俩次+1，但是写入到主存当中的值却只加了一次。注意，<font color="red">线程1对变量进行读取操作之后，被阻塞了的话，并没有对inc值进行修改。然后虽然volatile能保证线程2对变量inc的值读取是从内存中读取的，但是线程1没有进行修改，所以线程2根本就不会看到修改的值。</font>根源就在这里，自增操作不是原子性操作，而且volatile也无法保证对变量的任何操作都是原子性的。   

volatile关键字禁止指令重排序有两层意思:   
     1). 当程序执行到volatile变量的读操作或者写操作时，在其前面的操作的更改肯定全部已经进行，且结果已经对后面的操作可见；在其后面的操作肯定还没有进行;   
     2). 在进行指令优化时，不能将在对volatile变量访问的语句放在其后面执行，也不能把volatile变量后面的语句放到其前面执行。
volatile使用场景：   
synchronized关键字是防止多个线程同时执行一段代码，那么就会很影响程序执行效率，而volatile关键字在某些情况下性能要优于synchronized，但是要注意volatile关键字是无法替代synchronized关键字的，因为volatile关键字无法保证操作的原子性。通常来说，使用volatile必须具备以下2个条件：   
　　1）对变量的写操作不依赖于当前值   
　　2）该变量没有包含在具有其他变量的不变式中   
实际上，这些条件表明，可以被写入 volatile 变量的这些有效值独立于任何程序的状态，包括变量的当前状态。   
> 转载自https://www.cnblogs.com/dolphin0520/p/3920373.html

# 3. 锁有了解嘛，说一下Synchronized和lock?
锁类型   
可重入锁：在执行对象中所有同步方法不用再次获得锁。如果锁具备可重入性，则称作为可重入锁。synchronized和ReentrantLock都是可重入锁，可重入性实际上表明了锁的分配机制：基于线程的分配，而不是基于方法调用的分配。比如，当一个线程执行到method1 的synchronized方法时，而在method1中会调用另外一个synchronized方法method2，此时该线程不必重新去申请锁，而是可以直接执行方法method2。   
可中断锁：在等待获取锁过程中可中断。可中断锁，即可以中断的锁。在Java中，synchronized就不是可中断锁，而Lock是可中断锁。
如果某一线程A正在执行锁中的代码，另一线程B正在等待获取该锁，可能由于等待时间过长，线程B不想等待了，想先处理其他事情，我们可以让它中断自己或者在别的线程中中断它，这种就是可中断锁。Lock接口中的lockInterruptibly()方法就体现了Lock的可中断性。   
公平锁： 按等待获取锁的线程的等待时间进行获取，等待时间长的具有优先获取锁权利。公平锁即尽量以请求锁的顺序来获取锁。同时有多个线程在等待一个锁，当这个锁被释放时，等待时间最久的线程（最先请求的线程）会获得该锁，这种就是公平锁。
非公平锁即无法保证锁的获取是按照请求锁的顺序进行的，这样就可能导致某个或者一些线程永远获取不到锁。
synchronized是非公平锁，它无法保证等待的线程获取锁的顺序。对于ReentrantLock和ReentrantReadWriteLock，默认情况下是非公平锁，但是可以设置为公平锁。  
读写锁：对资源读取和写入的时候拆分为2部分处理，读的时候可以多线程一起读，写的时候必须同步地写。读写锁将对一个资源的访问分成了2个锁，如文件，一个读锁和一个写锁。正因为有了读写锁，才使得多个线程之间的读操作不会发生冲突。ReadWriteLock就是读写锁，它是一个接口，ReentrantReadWriteLock实现了这个接口。可以通过readLock()获取读锁，通过writeLock()获取写锁。   
Lock锁有如下方法：
```java
public interface Lock {
    void lockInterruptibly() throws InterruptedException;  
    boolean tryLock();  
    boolean tryLock(long time, TimeUnit unit) throws InterruptedException;  
    void unlock();  
    Condition newCondition();
}
```
lock：用来获取锁，如果锁被其他线程获取，处于等待状态。如果采用Lock，必须主动去释放锁，并且在发生异常时，不会自动释放锁。因此一般来说，使用Lock必须在try{}catch{}块中进行，并且将释放锁的操作放在finally块中进行，以保证锁一定被被释放，防止死锁的发生。   
lockInterruptibly：通过这个方法去获取锁时，如果线程正在等待获取锁，则这个线程能够响应中断，即中断线程的等待状态。   
tryLock：tryLock方法是有返回值的，它表示用来尝试获取锁，如果获取成功，则返回true，如果获取失败（即锁已被其他线程获取），则返回false，也就说这个方法无论如何都会立即返回。在拿不到锁时不会一直在那等待。   
tryLock（long，TimeUnit）：与tryLock类似，只不过是有等待时间，在等待时间内获取到锁返回true，超时返回false。   
unlock：释放锁，一定要在finally块中释放。      
synchronized与Lock的区别：   
Lock是一个接口，而synchronized是Java中的关键字，synchronized是内置的语言实现；   
synchronized在发生异常时，会自动释放线程占有的锁，因此不会导致死锁现象发生；而Lock在发生异常时，如果没有主动通过unLock()去释放锁，则很可能造成死锁现象，因此使用Lock时需要在finally块中释放锁；   
Lock可以让等待锁的线程响应中断，而synchronized却不行，使用synchronized时，等待的线程会一直等待下去，不能够响应中断；   
通过Lock可以知道有没有成功获取锁，而synchronized却无法办到。   
Lock可以提高多个线程进行读操作的效率。（可以通过readwritelock实现读写分离）   
性能上来说，在资源竞争不激烈的情形下，Lock性能稍微比synchronized差点（编译程序通常会尽可能的进行优化synchronized）。但是当同步非常激烈的时候，synchronized的性能一下子能下降好几十倍。而ReentrantLock确还能维持常态。      
>  https://juejin.im/post/5a43ad786fb9a0450909cb5f
# 4. 讲一讲Java里面的final关键字怎么用的？
final可以修饰变量，方法，类。final变量是只读的。如果将引用声明作final，你将不能改变这个引用。方法前面加上final关键字，代表这个方法不可以被子类的方法重写。final类通常功能是完整的，它们不能被继承。   
final修饰的成员变量为基本数据类型是，在赋值之后无法改变。当final修饰的成员变量为引用数据类型时，在赋值后其指向地址无法改变，但是对象内容还是可以改变的。   
final修饰的成员变量在赋值时可以有三种方式。1、在声明时直接赋值。2、在构造器中赋值。3、在初始代码块中进行赋值。   
关于final的重要知识点   
1. final关键字可以用于成员变量、本地变量、方法以及类。  
2. final成员变量必须在声明的时候初始化或者在构造器中初始化，否则就会报编译错误。   
3. 你不能够对final变量再次赋值。   
4. 本地变量必须在声明时赋值。   
5. 在匿名类中所有变量都必须是final变量。   
6. final方法不能被重写。   
7. final类不能被继承。   
8. final关键字不同于finally关键字，后者用于异常处理。   
9. final关键字容易与finalize()方法搞混，后者是在Object类中定义的方法，是在垃圾回收之前被JVM调用的方法。   
10. 接口中声明的所有变量本身是final的。   
11. final和abstract这两个关键字是反相关的，final类就不可能是abstract的。   
12. final方法在编译阶段绑定，称为静态绑定(static binding)。   
13. 没有在声明时初始化final变量的称为空白final变量(blank final variable)，它们必须在构造器中初始化，或者调用this()初始化。不这么做的话，编译器会报错“final变量(变量名)需要进行初始化”。   
14. 将类、方法、变量声明为final能够提高性能，这样JVM就有机会进行估计，然后优化。   
15. 对于集合对象声明为final指的是引用不能被更改，但是你可以向其中增加，删除或者改变内容
> 转载自http://www.importnew.com/7553.html

# 5. wait方法底层原理
# 6. Java有哪些特性，举个多态的例子。
封装、继承以及多态，其中方法的重写和重载都和多态有关
# 7. String为啥不可变？
![String类](../images/String.png)
java内存中，String中的字符是由value字符数组存储的。被private final修饰，不能变。
但是也不是不能变。可以通过反射的原理改变。

``` java

public static void testReflection() throws Exception {
     
    //创建字符串"Hello World"， 并赋给引用s
    String s = "Hello World"; 
     
    System.out.println("s = " + s); //Hello World
     
    //获取String类中的value字段
    Field valueFieldOfString = String.class.getDeclaredField("value");
     
    //改变value属性的访问权限
    valueFieldOfString.setAccessible(true);
     
    //获取s对象上的value属性的值
    char[] value = (char[]) valueFieldOfString.get(s);
     
    //改变value所引用的数组中的第5个字符
    value[5] = '_';
     
    System.out.println("s = " + s);  //Hello_World
}

```
# 8. 类和对象的区别
对象是类的一个实例化。

# 9. 请列举你所知道的Object类的方法
所有方法:
1. getClass()
2. hashCode()
3. equals()
4. toString()
5. clone()
6. wait()...
7. notify()
8. notifyAll()
9. finalize()
方法摘要
protected Object clone() 创建并返回此对象的一个副本。
boolean equals(Object obj) 指示某个其他对象是否与此对象“相等”。
protected void finalize() 当垃圾回收器确定不存在对该对象的更多引用时，由对象的垃圾回收器调用此方法。
Class<? extendsObject> getClass() 返回一个对象的运行时类。
int hashCode() 返回该对象的哈希码值。
void notify() 唤醒在此对象监视器上等待的单个线程。
void notifyAll() 唤醒在此对象监视器上等待的所有线程。
String toString() 返回该对象的字符串表示。
void wait() 导致当前的线程等待，直到其他线程调用此对象的 notify() 方法或 notifyAll() 方法。
void wait(long timeout) 导致当前的线程等待，直到其他线程调用此对象的 notify() 方法或 notifyAll() 方法，或者超过指定的时间量。
void wait(long timeout, int nanos) 导致当前的线程等待，直到其他线程调用此对象的 notify()
# 10.重载和重写的区别？相同参数不同返回值能重载吗？
重载是父子类之间的，重写是在同类之间的   
方法的重写（override）两同两小一大原则：    
方法名相同，参数类型相同
子类返回类型小于等于父类方法返回类型，   
子类抛出异常小于等于父类方法抛出异常，    
子类访问权限大于等于父类方法访问权限。   

方法的重载：   
方法重载的定义：同一个类或与他的派生类中，方法名相同，而参数列表不同的方法。其中参数列表不同指的是参数的类型，数量，类型的顺序这三种至少有一种不同。    
构造方法也可以重载   
方法的重写：   
方法的重写的定义：在继承关系的子类中，定义一个与父类相同的方法   
判断是否重写的方式：在方法之前加上@ Override   

# 11.”static”关键字是什么意思？Java中是否可以覆盖(override)一个private或者是static的方法？
“static”关键字表明一个成员变量或者是成员方法可以在没有所属的类的实例变量的情况 下被访问。 Java 中 static 方法不能被覆盖，因为方法覆盖是基于运行时动态绑定的，而 static 方法是编 译时静态绑定的。static 方法跟类的任何实例都不相关，所以概念上不适用   
如果在父类中修饰了一个private的方法，子类继承之后，对子类也是不可见的。那么如果子类声明了一个跟父类中定义为private一样的方法，那么编译器只当作是你子类自己新增的方法，并不能算是继承过来的
> 原文：https://blog.csdn.net/qq_41436920/article/details/83104273 

# 12.String能继承吗？
不能，String是由final修饰的

# 13.StringBuffer和StringBuilder有什么区别，底层实现上呢？
[详情见java面经 #16](https://github.com/zwlovefish/studynote/blob/master/java学习笔记/java面经.md)

# 14.类加载机制，双亲委派模型，好处是什么？
![类加载机制](../images/类加载机制.png)
应用程序在使用类的时候，这个类的生命周期其实包括了如上图所示的七个阶段。   
**使用：**就是我们平时在编码过程中用new关键字去创建一个类的实例去使用这个类。   
**卸载：**虚拟机通过垃圾回收机制将这个类的信息和这个类相关的实例从虚拟机内存区域中移除。  

**加载：**通过这个类的全限定名找到这个类所在的位置，把它从一个文件或者一个字节流转化为虚拟机内存中的一个确确实实的对象。    
**验证：**验证是为了检查每个java文件所对应的class文件所形成的字节流中包含的信息符不符合虚拟机的要求，有没有危害虚拟机自身安全的代码。   
**准备：**准备阶段就是为类变量（static修饰）分配内存，并设置初始值（例如int为0）。   
**解析：**解析就是将常量值的引用替换为实际值的过程   
**初始化：**初始化是类加载的最后一步，在初始化阶段才开始真正执行类中所定义的java代码，注意这个初始化要和我们平时构造方法初始化（构造方法是在“使用”阶段用new关键字创建实例的时候才会调用）区分开来，**这个初始化动作会把类中所有用了static修饰的变量以及静态语句块执行一遍，按照我们的意愿把类变量赋给我们所定义的变量。**   
我们能影响的只有加载过程，负责加载动作的是“类加载器”，可以使用系统给我们提供的类加载器，也可以使用自定义的类加载器。自定义的类加载器常常用于部署时的热替换，还有类的加密和解密。在部署程序的时候可能会把我们的class文件进行加密，在实际运行的时候首先要把加密后的class文件通过自定义的类加载器进行解密然后交给虚拟机去执行。   

|类加载器|加载的范围|
|:-:|:-:|
|启动类加载器<br>BootStrap ClassLoader|存放在<JAVA_HOME>/lib目录中的，并且是虚拟机识别的类库加载到虚拟机内存中|
|扩展类加载器<br>Extension ClassLoader|存放在<JAVA_HOME>/lib/ext目录中的所有类库，开发者可以直接使用|
|应用程序类加载器<br>Application ClassLoader|加载用户类路径上指定的类库，开发者可以直接使用，一般情况下这个就是程序中默认的类加载器。|

启动类加载器Bootstrap ClassLoader，负责加载jdk安装目录<JAVA_HOME>下的lib目录下的jdk自身所带的java类，这个类加载器是我们的应用程序无法调用的。   
**双亲委派模型**

![双亲委派模型](../images/双亲委派模型.png)

当一个加载器不管是应用程序类加载器还是我们自定义的类加载器在进行类加载的时候它首先不会自己去加载，它首先会把加载任务委派给自己的父类加载器，比如现在有个类需要我们的自定义类加载器来加载，其实它首先会把它交给应用程序类加载器，应用程序类加载器又会把任务交给扩展类加载器，一直往上提交，直到启动类加载器。启动类加载器如果在自己的扫描范围内能找到类，它就会去加载，如果它找不到，它就会交给它的下一级子加载器去加载，以此类推，这就是双亲委派模型。  这里如果父类加载器能够完成加载任务就成功返回，否则就由自己去加载。  
为什么jdk里要提出双亲委派模型？   
可以保证我们的类有一个合适的优先级，例如Object类，它是我们系统中所有类的根类，采用双亲委派模型以后，不管是哪个类加载器来加载Object类，哪怕这个加载器是自定义类加载器，通过双亲委派模型，最终都是由启动类加载器去加载的，这样就可以保证Object这个类在程序的各个类加载器环境中都是同一个类。<font color="red">在虚拟机里觉得一个类是不是唯一有两个因素，**第一个就是这个类本身，第二个就是加载这个类的类加载器，**如果同一个类由不同的类加载器去加载，在虚拟机看来，这两个类是不同的类。</font>
> https://blog.csdn.net/aimashi620/article/details/84836245

类的加载过程    

加载阶段   
主要完成以下3件事情：   
1.通过“类全名”来获取定义此类的二进制字节流   
2.将字节流所代表的静态存储结构转换为方法区的运行时数据结构   
3.在java堆中生成一个代表这个类的java.lang.Class对象，作为方法区这些数据的访问入口   

验证阶段    
这个阶段目的在于确保Class文件的字节流中包含信息符合当前虚拟机要求，不会危害虚拟机自身安全。主要包括四种验证：   
1.文件格式验证：基于字节流验证，验证字节流是否符合Class文件格式的规范，并且能被当前虚拟机处理。   
2.元数据验证：基于方法区的存储结构验证，对字节码描述信息进行语义验证。   
3.字节码验证：基于方法区的存储结构验证，进行数据流和控制流的验证。   
4.符号引用验证：基于方法区的存储结构验证，发生在解析中，是否可以将符号引用成功解析为直接引用。

准备阶段   
仅仅为类变量(即static修饰的字段变量)分配内存并且设置该类变量的初始值即零值，这里不包含用final修饰的static，因为final在编译的时候就会分配了，同时这里也不会为实例变量分配初始化。类变量会分配在方法区中，而实例变量是会随着对象一起分配到Java堆中。   

解析阶段   
解析主要就是将常量池中的符号引用替换为直接引用的过程。符号引用就是一组符号来描述目标，可以是任何字面量，而直接引用就是直接指向目标的指针、相对偏移量或一个间接定位到目标的句柄。有类或接口的解析，字段解析，类方法解析，接口方法解析。这里要注意如果有一个同名字段同时出现在一个类的接口和父类中，那么编译器一般都会拒绝编译。   

初始化阶段   
初始化阶段依旧是初始化类变量和其他资源，这里将执行用户的static字段和静态语句块的赋值操作。这个过程就是执行类构造器方法的过程。

![类加载过程](../images/类加载过程.png)

#15 静态变量存在哪?
内存到底分几个区？   
1、栈区（stack）— 由编译器自动分配释放 ，存放函数的参数值，局部变量的值等。    
2、堆区（heap） — 一般由程序员分配释放， 若程序员不释放，程序结束时可能由os回收。注意它与数据结构中的堆是两回事，分配方式倒是类似于链表。   
3、全局区（静态区）（static）—全局变量和静态变量的存储是放在一块的，初始化的全局变量和静态变量在一块区域，未初始化的全局变量和未初始化的静态变量在相邻的另一块区域。程序结束后有系统释放。   
4、文字常量区 —常量字符串就是放在这里的。 程序结束后由系统释放。   
5、程序代码区—存放函数体的二进制代码。   
# 16. 讲讲什么是泛型？
# 17.解释extends 和super 泛型限定符-上界不存下界不取
extends 指定上界限，只能传入本类和子类      
super 指定下界限，只能传入本类和父类    
T<? super B>对于这个泛型，?代表容器里的元素类型，由于只规定了元素必须是B的超类，导致元素没有明确统一的“根”（除了Object这个必然的根），所以这个泛型你其实无法使用它，对吧，除了把元素强制转成Object。所以，对把参数写成这样形态的函数，你函数体内，只能对这个泛型做插入操作，而无法读     
T<? extends B>由于指定了B为所有元素的“根”，你任何时候都可以安全的用B来使用容器里的元素，但是插入有问题，由于供奉B为祖先的子树有很多，不同子树并不兼容，由于实参可能来自于任何一颗子树，所以你的插入很可能破坏函数实参，所以，对这种写法的形参，禁止做插入操作，只做读取     
PECS（Producer Extends Consumer Super）原则：   
频繁往外读取内容的，适合用上界Extends。   
经常往里插入的，适合用下界Super。 
> https://www.jianshu.com/p/276699764aa2
# 18. 是否可以在static环境中访问非static变量？
static变量是属于类的，在类加载的时候被初始化，这时候类还没有实例化，因此不可以访问。   

1. 这个要从java的内存机制去分析，首先当你New 一个对象的时候，并不是先在堆中为对象开辟内存空间，而是先将类中的静态方法（带有static修饰的静态函数）的代码加载到一个叫做方法区的地方，然后再在堆内存中创建对象。所以说静态方法会随着类的加载而被加载。当你new一个对象时，该对象存在于对内存中，this关键字一般指该对象，但是如果没有new对象，而是通过类名调用该类的静态方法也可以。   
2. 程序最终都是在内存中执行，变量只有在内存中占有一席之地时才会被访问，类的静态成员（变态和方法）属于类本身，在类加载的时候就会分配内存，可以通过类名直接去访问，非静态成员（变量和方法）属于类的对象，所以只有在类的对象禅师（创建实例）的时候才会分配内存，然后通过类的对象去访问。   
3. 在一个类的静态成员中去访问非静态成员之所以会出错是因为在类的非静态成员不存在的时候静态成员就已经存在了，访问一个内存中不存在的东西当然会出错。   
> https://blog.csdn.net/snail_xinl/article/details/53427572
# 19.谈谈如何通过反射创建对象？
假定有一个对象User
```java
package com.zhou.entity;

public class User {
    private Integer id;
    private String name;
    public User() {
        // TODO Auto-generated constructor stub
    }
    public User(Integer id, String name) {
        super();
        this.id = id;
        this.name = name;
    }
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + name + "]";
    }

}

```
```java
            Class<?> strClass = Class.forName("com.zhou.entity.User");
            Object   object = strClass.newInstance();
            System.out.println(object instanceof User);
```
打印结果为true。这种clz.newInstance()的方式，只能创建默认无参构造的对象。   
```java
            Class<?> strClass = Class.forName("com.zhou.entity.User");
            Constructor<?> constructor = strClass.getConstructor(Integer.class,String.class);
            Object object = constructor.newInstance(1,"周健伟");
            User user = (User)object;
            System.out.println(user.getId()+user.getName());
```
这种方式是通过有参构造器创建对象。   
这里获取构造器只能获取public的，对于私有的需要暴力反射：
```java
constructor.setAccessible(true);
```
> https://blog.csdn.net/qq_33236248/article/details/80347884
# 20.Java支持多继承么？
不支持。但是java能实现多继承是java当中的接口之间能实现多继承，而java当中的类是不能实现多继承的，类只能实现单继承；
类不能实现多继承的原因是： 如果类之间实现了多继承，将可能造成程序的紊乱，因为类与类之前可能存在相同的方法，程序在运行子类的对象或者子类调用某一方法，若父类中含有相同的方法，比如父类中都含有show()的方法，子类调用时系统将不知调用哪个父类的方法，从而程序报错，所以java的类与类之间是不能实现多继承的，只能实现单继承。接口之间能实现多继承；
# 21.接口和抽象类的区别是什么？
1. 抽象类和接口都不能直接实例化，如果要实例化，抽象类变量必须指向实现所有抽象方法的子类对象，接口变量必须指向实现所有接口方法的类对象。
2. 抽象类要被子类继承，接口要被类实现。
3. 接口只能做方法申明，抽象类中可以做方法申明，也可以做方法实现
4. 接口里定义的变量只能是公共的静态的常量，抽象类中的变量是普通变量。
5. 抽象类里的抽象方法必须全部被子类所实现，如果子类不能全部实现父类抽象方法，那么该子类只能是抽象类。同样，一个实现接口的时候，如不能全部实现接口方法，那么该类也只能为抽象类。
6. 抽象方法只能申明，不能实现，接口是设计的结果 ，抽象类是重构的结果
7. 抽象类里可以没有抽象方法
8. 如果一个类里有抽象方法，那么这个类只能是抽象类
9. 抽象方法要被实现，所以不能是静态的，也不能是私有的。
10. 接口可继承接口，并可多继承接口，但类只能单根继承。
# 22.Comparable和Comparator接口是干什么的？列出它们的区别。
相同点：他们都是java的一个接口, 并且是用来对自定义的class比较大小的。   
Comparator 和 Comparable 的区别：   
Comparable 定义在自定义类内部<font color="red">(覆盖compareTo()方法)</font>:
```java
class User implements Comparable<User>{
    private Integer id;
    private String name;
    
    public User(Integer id, String name) {
        super();
        this.id = id;
        this.name = name;
    }
    @Override
    public int compareTo(User o) {
        return this.id-o.id;
    }
    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + name + "]";
    }
    
    
}
```
对其排序用Collectins.Sort(User)   
Comparator定义在外部<font color="red">(覆盖compare()方法)</font>:
```java
class User{
    private Integer id;
    private String name;
    
    public User(Integer id, String name) {
        super();
        this.id = id;
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + name + "]";
    }
    
}
class UserComparator implements Comparator<User>{

    @Override
    public int compare(User o1, User o2) {
        // TODO Auto-generated method stub
        return  o1.getId() - o2.getId();//如果是o2.getId() - o1.getId()，则递减次序
    }
    
}
```
对齐排序用Collections.sort(users, new UserComparator());   
两种方法各有优劣, 用Comparable 简单, 只要实现Comparable 接口的对象直接就成为一个可以比较的对象,
但是需要修改源代码, 用Comparator 的好处是不需要修改源代码, 而是另外实现一个比较器, 当某个自定义
的对象需要作比较的时候,把比较器和对象一起传递过去就可以比大小了, 并且在Comparator 里面用户可以自
己实现复杂的可以通用的逻辑,使其可以匹配一些比较简单的对象,那样就可以节省很多重复劳动了。
>https://www.cnblogs.com/sunflower627/p/3158042.html