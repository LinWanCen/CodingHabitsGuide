package io.github.linwancen.share.common;

import jakarta.servlet.ServletContext;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext;
import org.springframework.stereotype.Component;

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
    @Value("${springdoc.swagger-ui.path:}")
    private String swagger;

    @Override
    public void run(String... args) {
        int port = servletWebServerApplicationContext.getWebServer().getPort();
        ServletContext servletContext = servletWebServerApplicationContext.getServletContext();
        String contextPath = servletContext == null ? "" : servletContext.getContextPath();
        LOGGER.info("服务启动完毕 start complete {} {}", name, profile);
        String space = StringUtils.rightPad("", 15 - (LOCAL_IP.length()));
        //noinspection HttpUrlsUsage
        LOGGER.info("远程访问地址 http://{}:{}{} {}接口文档 http://{}:{}{}",
                LOCAL_IP, port, contextPath, space, LOCAL_IP, port, swagger);
        LOGGER.info("本地访问地址 http://localhost:{}{}       接口文档 http://localhost:{}{}", port, contextPath, port, swagger);
    }
}
