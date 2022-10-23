package io.github.linwancen.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpMethod;
import springfox.documentation.builders.*;
import springfox.documentation.service.Response;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.Arrays;
import java.util.List;


@Profile({"dev", "sit"})
@Configuration
@EnableSwagger2 // http://localhost:8081/swagger-ui/index.html
// @EnableOpenApi //Enable open api 3.0.3 spec
public class SwaggerConfiguration {

    private static final String TITLE = "示例";
    private static final String SWAGGER_SCAN_BASE_PACKAGE = "io.github.linwancen";

    @Bean
    public Docket createRestApi() {
        List<Response> resMsgList = Arrays.asList(
                new ResponseBuilder().code("200").description("成功！").build(),
                new ResponseBuilder().code("-1").description("失败！").build(),
                new ResponseBuilder().code("401").description("参数校验错误！").build(),
                new ResponseBuilder().code("403").description("没有权限操作，请后台添加相应权限！").build(),
                new ResponseBuilder().code("500").description("服务器内部异常，请稍后重试！").build(),
                new ResponseBuilder().code("501").description("请登录！").build());

        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(new ApiInfoBuilder()
                        .title(TITLE)
                        .build())
                .globalResponses(HttpMethod.GET, resMsgList)
                .globalResponses(HttpMethod.PUT, resMsgList)
                .globalResponses(HttpMethod.POST, resMsgList)
                .globalResponses(HttpMethod.DELETE, resMsgList)
                .select()
                .apis(RequestHandlerSelectors.basePackage(SWAGGER_SCAN_BASE_PACKAGE))
                .paths(
                        PathSelectors.any()
                )
                .build();
    }
}