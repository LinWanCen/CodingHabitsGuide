# Java ThreadPool 线程池

```
public ThreadPoolExecutor(
int corePoolSize, 核心线程数：优先创建一直存活，不叫最小是因为一开始不创建
int maximumPoolSize, 最大线程数：超过时根据拒绝策略处理
long keepAliveTime, 保持存活时间：大于核心线程数的空闲摧毁时间
TimeUnit unit, 单位：用于 keepAliveTime
BlockingQueue<Runnable> workQueue,， 工作队列：
ThreadFactory threadFactory, 线程工厂：设置线程名，是否守护线程daemon
RejectedExecutionHandler handler 处理器：拒绝策略
) {
}
```

workQueue：

- SynchronousQueue 同步队列：没有容量，超过最大线程数直接拒绝
- ArrayBlockingQueue 数组阻塞队列：
- LinkedBlockingQueue 链表阻塞队列：最大Integer.MAX
- PriorityBlockingQueue 优先级阻塞队列：可传 Comparator

handler

- AbortPolicy 拒绝策略
- CallerRunsPolicy 调用者线程运行策略
- DiscardOldestPolicy 忽略最老策略
- DiscardPolicy 忽略策略


```
// availableProcessors() 该值在特定的虚拟机调用期间可能发生更改。
// 因此，对可用处理器数目很敏感的应用程序应该不定期地轮询该属性，并相应地调整其资源用法。
int corePoolSize = Runtime.getRuntime().availableProcessors() * threadMultiplier;
```

```java
import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
import org.springframework.aop.interceptor.SimpleAsyncUncaughtExceptionHandler;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;

@EnableAsync
public class TreadPoolConfig implements AsyncConfigurer {
    @Override
    public Executor getAsyncExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(Runtime.getRuntime().availableProcessors());
        executor.setMaxPoolSize(Runtime.getRuntime().availableProcessors()*5);
        executor.setQueueCapacity(Runtime.getRuntime().availableProcessors()*2);
        executor.setThreadNamePrefix("a-");
        executor.initialize();
        return executor;
    }
    @Override
    public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
        return new SimpleAsyncUncaughtExceptionHandler();
    }
}
```