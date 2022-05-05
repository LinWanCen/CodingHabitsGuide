# Java Concurrent 并发 多线程

### 在多线程任务入口处设置跟踪任务的 traceId 到日志门面的 MDC 中

### 开始结束中相同的代码应该抽取或使用切面，以免忘记且减少重复

### 使用函数式设计（无状态），慎用成员变量和线程上下文，避免造成线程污染

- 新手最容易写出的生产问题就是成员变量，或者误认为线程安全的静态变量，比如`SimpleDateFormat`
- 线程上下文的问题比如使用`PageHelper.startPage(1, 10)`后没有在`finally`中`clearPage()`


### 锁释放要放在 finally

- 独占锁：可重入锁 `reentrantLock.unlock();`
- 共享锁（多个线程共享）
  - 写独占读共享：`reentrantReadWriteLock.unlock();`
  - 有限资源：`semaphore.release(n);`
  - 总数`countDownLatch.countDown();`

- AQS: 抽象队列同步器 AbstractQueuedSynchronizer, 上面几个锁都是基于此实现
- CAS:

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

|        | synchronized                      | lock                |
| ------ | --------------------------------- | ------------------- |
| 实现   | monitorenter/~exit 系统监视器+1-1 | volatile 和 CAS     |
| 类型   | 悲观锁                            | 乐观锁              |
| 排队   | 非公平                            | 可公平              |
| 锁状态 | 不可判断                          | 可判断，快速反馈    |
| 锁释放 | 执行完或异常 JVM 自动释放         | 要在 finally 中释放 |
| 编码   | 方法或方法内，简洁                | 方法内，灵活        |
| 使用   | 竞争不激烈                        | 竞争激烈            |

- 共同点：可重入
- synchronized 1.6前重量级；后面自旋、自适应、轻量标记、偏向升级重量、锁消除、锁粗化到循环外

### 多线程读的变量要用 volatile 修饰，特别是双检锁单例

保证修改后能被及时读取（可见性）

汇编中会多一个 lock 前缀的指令，把 CPU 缓存写到内存，并让其他核缓存该内存地址的数据无效