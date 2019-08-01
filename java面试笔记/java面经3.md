<!-- MarkdownTOC -->

- [1.面向对象的特征有哪些方面](#1面向对象的特征有哪些方面)
- [2.final,finally,finalize的区别](#2finalfinallyfinalize的区别)
  - [finally](#finally)
  - [finalize](#finalize)
- [3.Overload和Override的区别.Overloaded的方法是否可以改变返回值的类型](#3overload和override的区别overloaded的方法是否可以改变返回值的类型)
- [4.Static Nested Class 和 Inner Class的不同](#4static-nested-class-和-inner-class的不同)
- [5.当一个对象被当作参数传递到一个方法后,此方法可改变这个对象的属性,并可返回变化后的结果,那么这里到底是值传递还是引用传递](#5当一个对象被当作参数传递到一个方法后此方法可改变这个对象的属性并可返回变化后的结果那么这里到底是值传递还是引用传递)
- [6.Java的接口和C++的虚类的相同和不同处](#6java的接口和c的虚类的相同和不同处)
- [7.JAVA语言如何进行异常处理,关键字:throws,throw,try,catch,finally分别代表什么意义,在try块中可以抛出异常吗](#7java语言如何进行异常处理关键字throwsthrowtrycatchfinally分别代表什么意义在try块中可以抛出异常吗)
- [8.内部类可以引用他包含类的成员吗,有没有什么限制](#8内部类可以引用他包含类的成员吗有没有什么限制)
  - [匿名内部类](#匿名内部类)
  - [内部类的访问规则](#内部类的访问规则)
  - [访问格式](#访问格式)
  - [在外部其他类中,如何直接访问static内部类的非静态成员呢](#在外部其他类中如何直接访问static内部类的非静态成员呢)
  - [在外部其他类中,如何直接访问static内部类的静态成员呢](#在外部其他类中如何直接访问static内部类的静态成员呢)
  - [使用场景](#使用场景)
- [9.两个对象值相同\(x.equals(y\) == true),但却可有不同的hashcode说法是否正确](#9两个对象值相同xequalsy--true但却可有不同的hashcode说法是否正确)
- [10.重载\(Overload\)和重写\(Override\)的区别.重载的方法能否根据返回类型进行区分](#10重载overload和重写override的区别重载的方法能否根据返回类型进行区分)
- [11.如何通过反射获取和设置对象私有字段的值](#11如何通过反射获取和设置对象私有字段的值)
- [12.谈一下面向对象的"六原则一法则"](#12谈一下面向对象的六原则一法则)
- [13.请问Query接口的list方法和iterate方法有什么区别？](#13请问query接口的list方法和iterate方法有什么区别？)
  - [区别](#区别)
  - [原因](#原因)
  - [结果集的处理方法不同](#结果集的处理方法不同)
- [13.Java中,什么是构造函数,什么是构造函数重载,什么是复制构造函数,](#13java中什么是构造函数什么是构造函数重载什么是复制构造函数)
- [14.Map和ConcurrentHashMap的区别](#14map和concurrenthashmap的区别)
  - [HashTable](#hashtable)
  - [HashMap](#hashmap)
  - [HashMap的初始值还要考虑加载因子](#hashmap的初始值还要考虑加载因子)
  - [HashMap和Hashtable都是用hash算法来决定其元素的存储，因此HashMap和Hashtable的hash表包含如下属性](#hashmap和hashtable都是用hash算法来决定其元素的存储，因此hashmap和hashtable的hash表包含如下属性)
  - [负载极限](#负载极限)
  - [ConcurrentHashMap](#concurrenthashmap)
  - [锁分段技术](#锁分段技术)
- [15.如果hashMap的key是一个自定义的类,怎么办](#15如果hashmap的key是一个自定义的类怎么办)
  - [重写hashcode和equals方法](#重写hashcode和equals方法)
  - [为什么还要重写这俩个方法](#为什么还要重写这俩个方法)
- [16.ArrayList和LinkedList的区别,如果一直在list的尾部添加元素,用哪个效率高](#16arraylist和linkedlist的区别如果一直在list的尾部添加元素用哪个效率高)
- [17.ConcurrentHashMap锁加在了哪些地方](#17concurrenthashmap锁加在了哪些地方)
- [18.TreeMap底层，红黑树原理](#18treemap底层，红黑树原理)
- [19.concurrenthashmap有啥优势,1.7,1.8区别](#19concurrenthashmap有啥优势1718区别)
- [20.ArrayList是否会越界](#20arraylist是否会越界)
- [21.Java集合类框架的基本接口有哪些](#21java集合类框架的基本接口有哪些)
  - [Java集合类里最基本的接口](#java集合类里最基本的接口)

<!-- /MarkdownTOC -->



# 1.面向对象的特征有哪些方面
继承，封装和多态
# 2.final,finally,finalize的区别
- final修饰变量，方法和类
- final修饰变量时，该变量不可变。修饰引用变量时，引用不用变，但是引用变量里面的值可以变
- final修饰方法时，该方法不可被覆盖
- final修饰类时，该类不可被继承

## finally
finally是在异常处理时提供finally块来执行任何清除操作的，如果try语句中发生了catch块中的异常，则跳转到catch中进行异常处理，而finally中的内容则是无论异常是否发生都要执行的。如果finally中有return，则会先执行finally再执行return，如果此时try中也有return，则try中的return不会执行，但是，如果只有try中有return也是先执行finally中的语句再执行return；
## finalize
要宣告一个对象有没有真正死亡，至少要经历俩次标记过程：如果对象在进行可达性分析后发现没有与GC Roots相连，那么他将第一次标记，并进行一次筛选，筛选的条件是对象有没有覆盖finalize方法或者改finalize方法有没有被调用过，如果没有覆盖或者已经执行过finalize之后，虚拟机将这俩种情况均视为没有必要执行。如果一个对象被判定为有必要执行finalize()方法，那么这个对象将会放置在一个F-Queue的队列中，并在稍后由一个虚拟机自动建立，低优先级的Finalizer线程去执行它，不保证等待它运行结束。这里引用深入理解java虚拟机上面的一段代码
```java
public class FinalizeEscapeGC{
	public static FinalizeEscapeGC SAVE_HOOK = null;
	public void isAlive(){
		System.out.println("yes, i am still alive :");
	}
	@Override
	protected void finalize () throws Throwable{
		super.finalize();
		System.out.println("finalize method executed");
		FinalizeEscapeGC.SAVE_HOOK = this;
	}
	public static void main(String[] args){
		SAVE_HOOK = new FinalizeEscapeGC();
		//对象第一次成功解救自己
		SAVE_HOOK = null；
		System.gc();
		//因为finalize方法优先级很低，所以暂停0.5秒等待它
		Thread.sleep(500);
		if(SAVE_HOOK != null){
			SAVE_HOOK.isAlive();
		}else{
			System.out.println("no, i am dead");
		}
		//下面这段代码和上面的完全相同，但是这次自救却失败了。
		SAVE_HOOK = null;
		System.gc();
		Thread.sleep(500);
		if(SAVE_HOOK != null){
			SAVE_HOOK.isAlive();
		}else{
			System.out.println("no, i am dead");
		}
	}
}
```

这里一次成功逃脱一次逃脱失败的原因是任何一个对象的finalize()方法都只会被系统自动调用一次。
# 3.Overload和Override的区别.Overloaded的方法是否可以改变返回值的类型
Overload是重载的意思，Override是覆盖的意思，也就是重写。   

重载Overload表示同一个类中可以有多个名称相同的方法，但这些方法的参数列表各不相同（即参数个数或类型不同）  

重写Override表示子类中的方法可以与父类中的某个方法的名称和参数完全相同，通过子类创建的实例对象调用这个方法时，将调用子类中的定义方法，这相当于把父类中定义的那个完全相同的方法给覆盖了，这也是面向对象编程的多态性的一种表现。子类覆盖父类的方法时，只能比父类抛出更少的异常，或者是抛出父类抛出的异常的子异常，因为子类可以解决父类的一些问题，不能比父类有更多的问题。子类方法的访问权限只能比父类的更大，不能更小。如果父类的方法是private类型，那么，子类则不存在覆盖的限制，相当于子类中增加了一个全新的方法。   

方法重载与下列无关：

- 与返回值类型无关
- 与访问修饰符无关
- 构造方法也可以重载

方法的重写的定义：

在继承关系的子类中，定义一个与父类相同的方法重写（override）原则:

- 方法名相同，参数类型相同    
- 子类返回类型小于等于父类方法返回类型//JDK1.5之前必须一样，JDK1.5之后返回类型可以是父类方法返回类型的子类   
- 子类抛出异常小于等于父类方法抛出异常   
- 子类访问权限大于等于父类方法访问权限
 
# 4.Static Nested Class 和 Inner Class的不同
- Static Nested是嵌套类，Inner Class是内部类
- Nested Class 一般是C++的说法，Inner Class 一般是JAVA的说法
- Nested class分为静态Static nested class 的和非静态的 inner class。静态的Static nested class是不可以直接调用它的外部类enclosing class的，但是可以通过外部类的引用来调用，非静态类inner class 可以自由的引用外部类的属性和方法，但是它与一个实例绑定在了一起，不可以定义静态的属性、方法。

Inner Class（内部类）定义在类中的类。Nested Class（嵌套类）是静态（static）内部类。

1. 要创建嵌套类的对象，并不需要其外围类的对象
2. 不能从嵌套类的对象中访问非静态的外围类对象

Anonymous Inner Class （匿名内部类）匿名的内部类是没有名字的内部类。匿名的内部类不能extends（继承）其它类，但一个内部类可以作为一个接口，由另一个内部类实现。

嵌套类可以作为接口的内部类。正常情况下，你不能在接口内部放置任何代码，但嵌套类可以作为接口的一部分，因为它是static 的。只是将嵌套类置于接口的命名空间内，这并不违反接口的规则。

在使用匿名内部类时，要记住以下几个原则:

- 匿名内部类不能有构造方法。   
- 匿名内部类不能定义任何静态成员、方法和类。   　
- 匿名内部类不能是public,protected,private,static。   
- 只能创建匿名内部类的一个实例。   
- 一个匿名内部类一定是在new的后面，用其隐含实现一个接口或实现一个类。   
- 因匿名内部类为局部内部类，所以局部内部类的所有限制都对其生效。

匿名类和内部类中的中的this :  有时候，我们会用到一些内部类和匿名类。当在匿名类中用this时，这个this则指的是匿名类或内部类本身。 这时如果我们要使用外部类的方法和变量的话，则应该加上外部类的类名。

# 5.当一个对象被当作参数传递到一个方法后,此方法可改变这个对象的属性,并可返回变化后的结果,那么这里到底是值传递还是引用传递
Java编程语言只有值传递参数。当一个对象实例作为一个参数被传递到方法中时，参数的值就是该对象的引用一个副本。指向同一个对象,对象的内容可以在被调用的方法中改变，但对象的引用(不是引用的副本)是永远不会改变的。

在 Java应用程序中永远不会传递对象，而只传递对象引用。因此是按引用传递对象。但重要的是要区分参数是如何传递的，这才是该节选的意图。Java应用程序按引用传递对象这一事实并不意味着Java 应用程序按引用传递参数。参数可以是对象引用，而 Java应用程序是按值传递对象引用的。

Java应用程序中的变量可以为以下两种类型之一：引用类型或基本类型。当作为参数传递给一个方法时，处理这两种类型的方式是相同的。两种类型都是按值传递的；没有一种按引用传递。

按值传递意味着当将一个参数传递给一个函数时，函数接收的是原始值的一个副本。因此，如果函数修改了该参数，仅改变副本，而原始值保持不变。按引用传递意味着当将一个参数传递给一个函数时，函数接收的是原始值的内存地址，而不是值的副本。因此，如果函数修改了该参数的值，调用代码中的原始值也随之改变。如果函数修改了该参数的地址,调用代码中的原始值不会改变。
  
当传递给函数的参数不是引用时，传递的都是该值的一个副本（按值传递）。区别在于引用。在 C++中当传递给函数的参数是引用时，您传递的就是这个引用，或者内存地址（按引用传递）。在 Java应用程序中，当对象引用是传递给方法的一个参数时，您传递的是该引用的一个副本（按值传递），而不是引用本身。

Java 应用程序按值传递参数(引用类型或基本类型)，其实都是传递他们的一份拷贝.而不是数据本身。(不是像 C++中那样对原始值进行操作。)
>https://blog.csdn.net/u012726702/article/details/72236968

# 6.Java的接口和C++的虚类的相同和不同处
C++虚类相当于java中的抽象类，与接口的不同处是:

1. 一个子类只能继承一个抽象类（虚类），但能实现多个接口
2. 一个抽象类可以有构造方法，接口没有构造方法
3. 一个抽象类中的方法不一定是抽象方法，即其中的方法可以有实现（有方法体），接口中的方法都是抽象方法，不能有方法体，只有方法声明
4. 一个抽象类可以是public、private、protected、default，接口只有public
5. 一个抽象类中的方法可以是public、private、protected、default，接口中的方法只能是public和default修饰，实际上都是public的abstract方法

相同之处是：都不能实例化。

补充：接口是一类特殊的抽象类，是更抽象的抽象类，你可以这样理解。抽象类是一个不完整的类，接口只定义了一些功能。

# 7.JAVA语言如何进行异常处理,关键字:throws,throw,try,catch,finally分别代表什么意义,在try块中可以抛出异常吗
- try 用来指定一块预防所有“异常”的程序
- catch 子句紧跟在 try 块后面，用来指定你想要捕捉的“异常”的类型
- throw 语句用来明确地抛出一个“异常”
- throws 用来标明一个成员函数可能抛出的各种“异常”
- Finally 为确保一段代码不管发生什么“异常”都被执行一段代码

# 8.内部类可以引用他包含类的成员吗,有没有什么限制
完全可以。如果不是静态内部类，那没有什么限制!一个内部类对象可以访问创建它的外部类对象的成员包括私有成员。<font color="red">如果你把静态嵌套类当作内部类的一种特例，那在这种情况下不可以访问外部类的普通成员变量，而只能访问外部类中的静态成员。</font>

1. __static内部类:__ 它只能访问外部类的静态方法或者成员变量
2. __成员内部类:__ 成员内部类是最普通的内部类，它可以无条件访问外内类的成员变量或者方法(包括私有成员和静态成员)。<font color='red'>当成员内部类拥有和外部类相同的成员变量或者方法时，会发生隐藏即默认访问的是成员内部类的成员。如果要访问外部的同名成员，需要外部类.this.成员变量以及外部类.this.成员方法</font>
3. __局部内部类:__ 局部内部类是定义在外部成员类的方法中的，在访问的时候，他可以直接访问外部类的所有成员，但是不能访问局部变量，除非这个局部变量是被final修饰的
```java
public void getinfo() {
         final int a = 0;//重点：这里如果没有final修饰的话，编译的时候就会报错

         class pps5 {
               public void test() {
                        System.out.println(a);
                }
        }
        new pps5().test();
}  
```

## 匿名内部类
- 匿名内部类是局部内部类的简写方式，只能用一次
- 定义匿名内部类的前提：匿名内部类必须是一个类或者是一个实现接口。
- 匿名内部类的格式：new 父类或者接口(){定义子类的内容}
- 匿名内部类就是一个匿名子类对象
- 匿名内部类的方法最好不要超过三个

```java
interface Person {

              public abstract void study();
         }
          
         class PersonDemo {
              public void method(Person p) {
                   p.study();
             }
         }
                
        class PersonTest {
              public static void main(String[] args) {
                  PersonDemo pd = new PersonDemo() {     //重点4：new 父类名或接口名() { 重写的方法体}

　　　    　    　　　　 @override
                　　　　public void study() {
                   　　　　  System.out.println("好好学习，天天向上");
               　　　　 }
              　　 });     //当调用匿名内部类次数比较少时，用这种方式，可以节省内存空间。
              }
        }
```

## 内部类的访问规则
1. 内部类可以直接访问外部类中的成员，包括私有。之所以可以直接访问外部类中的成员，是因为内部类中持有了一个外部类的引用，格式 外部类名.this
2. 外部类要访问内部类，必须建立内部类对象。

## 访问格式
1. 当内部类定义在外部类的成员位置上，而且非私有时，可以直接建立内部类对象，在外部其他类中进行访问，    
格式    
        外部类名.内部类名  变量名 = 外部类对象.内部类对象;    
        Outer.Inner in = new Outer().new Inner();

2. 当内部类在成员位置上，就可以被成员修饰符所修饰。比如:private：将内部类在外部类中进行封装。static:内部类就具备static的特性。

## 在外部其他类中,如何直接访问static内部类的非静态成员呢
new Outer.Inner().function();

## 在外部其他类中,如何直接访问static内部类的静态成员呢  
outer.Inner.function();

注意：当内部类中定义了静态成员，该内部类必须是static的。当外部类中的静态方法访问内部类时，内部类也必须是static的。  

## 使用场景 
当描述事物时，事物的内部还有事物，该事物用内部类来描述。因为内部事务在使用外部事物的内容。 

内部类定义在局部时：

1. 不可以被成员修饰符修饰
2. 可以直接访问外部类中的成员，因为还持有外部类中的引用。但是不可以访问它所在的局部中的变量。只能访问被final修饰的局部变量。
> http://www.cnblogs.com/dolphin0520/p/3811445.html

# 9.两个对象值相同(x.equals(y) == true),但却可有不同的hashcode说法是否正确
不对，hashcode相同，俩个对象值可能不同，俩个对象值相同，则hash code一定相同。
# 10.重载(Overload)和重写(Override)的区别.重载的方法能否根据返回类型进行区分
不能，重载对返回值类型没有要求
# 11.如何通过反射获取和设置对象私有字段的值
```java
/**
  * 数据字典转换
  * @param obj
  * @return
  */
public static Object dictConvert (Object obj) {
    try {
    //得到对象的所有私有属性
    Field fields[] = obj.getClass().getDeclaredFields();
    for (Field field : fields) {
        //获得注解
        FieldRemark fieldRemark = field.getAnnotation(FieldRemark.class);
        if (fieldRemark != null && StringUtils.isNotBlank(fieldRemark.dictType())) {

                 //如果accessible标志被设置为true，那么反射对象在使用的时候，不会去检查Java语言权限控制（如private）；
                 field.setAccessible(true);
                 //field.get(obj)为获取属性值
                 String dictVal = DictUtils.getDictLabel(field.get(obj).toString(),fieldRemark.dictType(), "");
                 field.setAccessible(true);
                 //通过反射给指定字段赋值
                 field.set(obj, dictVal);
        }
         }
    } catch (IllegalAccessException e) {
        e.printStackTrace();
    }
    return obj;
}
```
# 12.谈一下面向对象的"六原则一法则"
1. 单一职责原则：一个类只做它该做的事情
2. 开闭原则：软件实体应当对扩展开放，对修改关闭。
3. 依赖倒转原则：面向接口编程。
4. 接口隔离原则：接口要小而专，绝不能大而全。
5. 合成聚合复用原则：优先使用聚合或合成关系复用代码。
6. 迪米特法则：迪米特法则又叫最少知识原则，一个对象应当对其他对象有尽可能少的了解。

# 13.请问Query接口的list方法和iterate方法有什么区别？
## 区别
1. 返回的类型不一样，list()返回List,iterate()返回Iterator。
2. 获取数据的方式不一样，list()会直接查数据库,iterate()会先到数据库中把id都取出来，然后真正要遍历某个对象的时候先到缓存中找,如果找不到,以id为条件再发一条sql到数据库,这样如果缓存中没有数据,则查询数据库的次数为n+1。
3. iterate会查询2级缓存，list只会查询一级缓存。
4. list()中返回的List中每个对象都是原本的对象,iterate()中返回的对象是代理对象.

## 原因
list()方法在执行时，直接运行查询结果所需要的查询语句。   
iterator()方法则是先执行得到对象ID的查询，然后在根据每个ID值去取得所要查询的对象。   
因此：对于list()方式的查询通常只会执行一个SQL语句，而对于iterator()方法的查询则可能需要执行N+1条SQL语句(N为结果集中的记录数).  

## 结果集的处理方法不同   
list()方法会一次取出所有的结果集对象，而且他会依据查询的结果初始化所有的结果集对象。如果在结果集非常庞大的时候会占据非常多的内存，甚至会造成内存溢出的情况发生。   
iterator()方法在执行时不会一次初始化所有的对象，而是根据对结果集的访问情况来初始化对象。一次在访问中可以控制缓存中对象的数量，以避免占用过多的缓存，导致内存溢出情况的发生。   
>https://blog.csdn.net/x332175673/article/details/13032479 

# 13.Java中,什么是构造函数,什么是构造函数重载,什么是复制构造函数,
1. 当新对象被创建的时候，构造函数会被调用。每一个类都有构造函数。在程序员没有给类提供构造函数的情况下，Java编译器会为这个类创建一个默认的构造函数。
2. Java中构造函数重载和方法重载很相似。可以为一个类创建多个构造函数。每一个构造函数必须有它自己唯一的参数列表。
3. Java不支持像C++中那样的复制构造函数，这个不同点是因为如果你不自己写构造函数的情况下，Java不会创建默认的复制构造函数

# 14.Map和ConcurrentHashMap的区别
## HashTable 
- 底层数组+链表实现，无论key还是value都不能为null，线程安全，实现线程安全的方式是在修改数据时锁住整个HashTable，效率低，ConcurrentHashMap做了相关优化
- 初始size为11，扩容：newsize = olesize*2+1
- 计算index的方法：index = (hash & 0x7FFFFFFF) % tab.length

## HashMap
- 底层数组+链表实现，可以存储null键和null值，线程不安全
- 初始size为16，扩容：newsize = oldsize*2，size一定为2的n次幂
- 扩容针对整个Map，每次扩容时，原来数组中的元素依次重新计算存放位置，并重新插入
- 插入元素后才判断该不该扩容，有可能无效扩容（插入后如果扩容，如果没有再次插入，就会产生无效扩容）
- 当Map中元素总数超过Entry数组的75%，触发扩容操作，为了减少链表长度，元素分配更均匀
- 计算index方法：index = hash & (tab.length – 1)

## HashMap的初始值还要考虑加载因子

1. 哈希冲突：若干Key的哈希值按数组大小取模后，如果落在同一个数组下标上，将组成一条Entry链，对Key的查找需要遍历Entry链上的每个元素执行equals()比较
2. 加载因子：为了降低哈希冲突的概率，默认当HashMap中的键值对达到数组大小的75%时，即会触发扩容。因此，如果预估容量是100，即需要设定100/0.75＝134的数组大小。
3. 空间换时间：如果希望加快Key查找的时间，还可以进一步降低加载因子，加大初始大小，以降低哈希冲突的概率。

## HashMap和Hashtable都是用hash算法来决定其元素的存储，因此HashMap和Hashtable的hash表包含如下属性
- 容量（capacity）：hash表中桶的数量
- 初始化容量（initial capacity）：创建hash表时桶的数量，HashMap允许在构造器中指定初始化容量
- 尺寸（size）：当前hash表中记录的数量
- 负载因子（load factor）：负载因子等于“size/capacity”。负载因子为0，表示空的hash表，0.5表示半满的散列表，依此类推。轻负载的散列表具有冲突少、适宜插入与查询的特点（但是使用Iterator迭代元素时比较慢）

## 负载极限
除此之外，hash表里还有一个“负载极限”，“负载极限”是一个0～1的数值，“负载极限”决定了hash表的最大填满程度。当hash表中的负载因子达到指定的“负载极限”时，hash表会自动成倍地增加容量（桶的数量），并将原有的对象重新分配，放入新的桶内，这称为rehashing。
HashMap和Hashtable的构造器允许指定一个负载极限，HashMap和Hashtable默认的“负载极限”为0.75，这表明当该hash表的3/4已经被填满时，hash表会发生rehashing。

**负载极限**的默认值（0.75）是时间和空间成本上的一种折中：

- 较高的“负载极限”可以降低hash表所占用的内存空间，但会增加查询数据的时间开销，而查询是最频繁的操作（HashMap的get()与put()方法都要用到查询）
- 较低的“负载极限”会提高查询数据的性能，但会增加hash表所占用的内存开销

## ConcurrentHashMap

- 底层采用分段的数组+链表实现，线程安全
- 通过把整个Map分为N个Segment，可以提供相同的线程安全，但是效率提升N倍，默认提升16倍。(读操作不加锁，由于HashEntry的value变量是 volatile的，也能保证读取到最新的值。)
- Hashtable的synchronized是针对整张Hash表的，即每次锁住整张表让线程独占，ConcurrentHashMap允许多个修改操作并发进行，其关键在于使用了锁分离技术
- 有些方法需要跨段，比如size()和containsValue()，它们可能需要锁定整个表而而不仅仅是某个段，这需要按顺序锁定所有段，操作完毕后，又按顺序释放所有段的锁
- 扩容：段内扩容（段内元素超过该段对应Entry数组长度的75%触发扩容，不会对整个Map进行扩容），插入前检测需不需要扩容，有效避免无效扩容

## 锁分段技术
ConcurrentHashMap是使用了锁分段技术来保证线程安全的。

**锁分段技术**：首先将数据分成一段一段的存储，然后给每一段数据配一把锁，当一个线程占用锁访问其中一个段数据的时候，其他段的数据也能被其他线程访问。

ConcurrentHashMap提供了与Hashtable和SynchronizedMap不同的锁机制。Hashtable中采用的锁机制是一次锁住整个hash表，从而在同一时刻只能由一个线程对其进行操作；而ConcurrentHashMap中则是一次锁住一个桶。

ConcurrentHashMap默认将hash表分为16个桶，诸如get、put、remove等常用操作只锁住当前需要用到的桶。这样，原来只能一个线程进入，现在却能同时有16个写线程执行，并发性能的提升是显而易见的。   
>https://www.cnblogs.com/heyonggang/p/9112731.html

# 15.如果hashMap的key是一个自定义的类,怎么办
## 重写hashcode和equals方法
使用HashMap，如果key是自定义的类，就必须重写hashcode()和equals()。

HashMap是基于散列函数，以数组和链表的方式实现的。而对于每一个对象，通过其hashCode()方法可为其生成一个整形值（散列码），该整型值被处理后，将会作为数组下标，存放该对象所对应的Entry（存放该对象及其对应值）。equals()方法则是在HashMap中插入值或查询时会使用到。当HashMap中插入 值或查询值对应的散列码与数组中的散列码相等时，则会通过equals方法比较key值是否相等，所以想以自建对象作为HashMap的key，必须重写 该对象继承object的equals方法。
## 为什么还要重写这俩个方法
HashMap中，如果要比较key是否相等，要同时使用这两个函数！因为自定义的类的hashcode()方法继承于Object类，其hashcode码为默认的内存地址，这样即便有相同含义的两个对象，比较也是不相等的，例如:
```java
Student st1 = new Student("wei","man");   
Student st2 = new Student("wei","man"); 
```
正常理解这两个对象再存入到hashMap中应该是相等的，但如果你不重写hashcode（）方法的话，比较是其地址，不相等!

HashMap中的比较key是这样的，先求出key的hashcode(),比较其值是否相等，若相等再比较equals(),若相等则认为他们是相等 的。若equals()不相等则认为他们不相等。如果只重写hashcode()不重写equals()方法，当比较equals()时只是看他们是否为 同一对象（即进行内存地址的比较）,所以必定要两个方法一起重写。HashMap用来判断key是否相等的方法，其实是调用了HashSet判断加入元素 是否相等。
>https://blog.csdn.net/tuolaji8/article/details/48417031 

# 16.ArrayList和LinkedList的区别,如果一直在list的尾部添加元素,用哪个效率高
ArrayList底层数组实现，LinkedList底层单向链表，当一直在list尾部增加时，读写效率都是ArrayList高，但是当需要指定位置插入的时候（最坏的情况每次插入放在第一个位置）时，可能LinkedList插入效率高，但是读效率ArrayList始终高于LinkedList
# 17.ConcurrentHashMap锁加在了哪些地方
[很详细的一篇博客](https://blog.csdn.net/zlfprogram/article/details/77524326)
# 18.TreeMap底层，红黑树原理
[很详细的一篇博客](http://cmsblogs.com/?p=1013) 另外红黑树需要了解一下
# 19.concurrenthashmap有啥优势,1.7,1.8区别  
在JDK1.7版本中，ConcurrentHashMap的数据结构是由一个Segment数组和多个HashEntry组成，如下图所示：

![concurrenthashmap.png](../images/concurrenthashmap.png)

Segment数组的意义就是将一个大的table分割成多个小的table来进行加锁，也就是上面的提到的锁分离技术，而每一个Segment元素存储的是HashEntry数组+链表，这个和HashMap的数据存储结构一样

JDK1.8的实现已经摒弃了Segment的概念，而是直接用Node数组+链表+红黑树的数据结构来实现，并发控制使用Synchronized和CAS来操作，整个看起来就像是优化过且线程安全的HashMap，虽然在JDK1.8中还能看到Segment的数据结构，但是已经简化了属性，只是为了兼容旧版本。
[关于concurrenthashmap你必须要知道的事](https://www.jianshu.com/p/1a01d15df3f0)   
# 20.ArrayList是否会越界
ArrayList 底层是基于数组来实现容量大小动态变化的。

迭代集合每次remove后的size都会发生变化,如果迭代基数不根据remove后的size动态调整,则会发生索引越界异常或内容遍历不全等问题。
# 21.Java集合类框架的基本接口有哪些
总共有两大接口：Collection和Map ，一个元素集合，一个是键值对集合

其中List和Set接口继承了Collection接口，一个是有序元素集合，一个是无序元素集合；而ArrayList和 LinkedList 实现了List接口，HashSet实现了Set接口，这几个都比较常用；HashMap和HashTable实现了Map接口，并且HashTable是线程安全的，但是HashMap性能更好；

java.util.Collection [I]

|—java.util.List [I]

    |—java.util.ArrayList [C]

    |—java.util.LinkedList [C]

    |—java.util.Vector [C]

        |—java.util.Stack [C]

|—java.util.Set [I]

    |—java.util.HashSet [C]

    |—java.util.SortedSet [I]

        |—java.util.TreeSet [C]

java.util.Map [I]

|—java.util.SortedMap [I]

    |—java.util.TreeMap [C]

|—java.util.Hashtable [C]

|—java.util.HashMap [C]

    |—java.util.LinkedHashMap [C]

|—java.util.WeakHashMap [C]

## Java集合类里最基本的接口 
- Collection：单列集合的根接口   
- List：元素有序  可重复    
- ArrayList：类似一个长度可变的数组 。适合查询，不适合增删
- LinkedList：底层是双向循环链表。适合增删，不适合查询。
- Set：元素无序，不可重复
- HashSet：根据对象的哈希值确定元素在集合中的位置
- TreeSet: 以二叉树的方式存储元素，实现了对集合中的元素排序
- Map：双列集合的根接口，用于存储具有键（key）、值（value）映射关系的元素。
- HashMap：用于存储键值映射关系，不能出现重复的键key
- TreeMap：用来存储键值映射关系，不能出现重复的键key，所有的键按照二叉树的方式排列