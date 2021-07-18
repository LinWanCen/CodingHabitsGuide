# Java

## 代码

### 创建类前先搜下类名是否被使用，尽量不要重复

查找类以便用类名，类名重复查找时难以分辨


### 常量数组和枚举单独成行，最后一项也加逗号
https://github.com/alibaba/p3c/issues/563


### 数字使用下划线增加可读性

JDK 7 中的新特性
```
long a = 1_000_000L;
byte b = 0b0010_0101;
long maxLong = 0x7fff_ffff_ffff_ffffL;
```


### 修饰符按谷歌规范的顺序

```
public protected private abstract default static final transient volatile synchronized native strictfp
```

https://google.github.io/styleguide/javaguide.html#s4.8.7-modifiers

https://github.com/google/styleguide/blob/gh-pages/javaguide.html


### 不需要正则替换时优先使用`replace()`(也是替换所有)

`replaceAll()`和`split()`的参数是正则表达式

### 正则表达式应预编译

### `String.format`比直接+拼接效率低很多，应避免使用

### 使用 JVM 钩子优雅停机（断电或`kill -9`无效）


### 在多线程任务入口处设置跟踪任务的 traceId 到日志门面的 MDC 中

### 开始结束中相同的代码应该抽取或使用切面，以免忘记且减少重复

### 锁释放要放在 finally

- 独占锁：`reentrantLock.unlock();`
- 共享锁（多个线程共享）
  - 写独占读共享：`reentrantReadWriteLock.unlock();`
  - 有限资源：`semaphore.release(n);`
  - 总数`countDownLatch.countDown();`

`CountDownLatch`与`MDC`(Mapped Diagnostic Context):
```java
public class MyTask implements Runnable {
    @Override
    public void run() {
        try (MDC.MDCCloseable ignored = MDC.putCloseable(MdcKey.DEMO, traceId)) {
            if (apply()) {
                ok();
            } else {
                no();
            }
        } finally {
            // 在 finally 中 countDown 避免异常等情况导致没有执行而卡住主线程
            count.countDown();
        }
    }
}
```

### 多线程读的变量要用 volatile 修饰，特别是双检锁单例

保证修改后能被及时读取（可见性）

汇编中会多一个 lock 前缀的指令，把 CPU 缓存写到内存，并让其他核缓存该内存地址的数据无效