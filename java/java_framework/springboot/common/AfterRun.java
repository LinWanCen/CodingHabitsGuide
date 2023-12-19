package io.github.linwancen.app;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * 启动后打印访问地址
 * <br>
 * <br>如果需要更复杂的参数可以使用 {@link org.springframework.boot.ApplicationRunner}
 */
@Component
public class AfterRun implements CommandLineRunner {
    private static final Logger LOGGER = LoggerFactory.getLogger(AfterRun.class);

    public static final String LOCAL_IP;

    static {
        String ip;
        try {
            ip = InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            ip = "0.0.0.0";
        }
        LOCAL_IP = ip;
    }

    private final ServletWebServerApplicationContext servletWebServerApplicationContext;

    public AfterRun(ServletWebServerApplicationContext servletWebServerApplicationContext) {
        this.servletWebServerApplicationContext = servletWebServerApplicationContext;
    }

    @Value("${spring.application.name:}")
    private String name;
    @Value("${spring.profiles.active:}")
    private String profile;

    @Override
    public void run(String... args) {
        int port = servletWebServerApplicationContext.getWebServer().getPort();
        ServletContext servletContext = servletWebServerApplicationContext.getServletContext();
        String contextPath = servletContext == null ? "" : servletContext.getContextPath();
        //noinspection HttpUrlsUsage
        LOGGER.info("服务启动完毕 start complete {} {} http://{}:{}{}", name, profile, LOCAL_IP, port, contextPath);
        LOGGER.info("本地访问地址 http://localhost:{}{}", port, contextPath);
    }
}
