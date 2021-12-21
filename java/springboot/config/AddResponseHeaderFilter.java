package io.github.linwancen.config;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 默认响应头设置
 * <br>
 */
@Component
public class AddResponseHeaderFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(@Nullable HttpServletRequest httpServletRequest,
                                    HttpServletResponse httpServletResponse,
                                    FilterChain filterChain) throws ServletException, IOException {
        httpServletResponse.addHeader("Content-Type", "application/json;charset=UTF-8");
        httpServletResponse.addHeader("X-Frame-Options", "DENY");
        httpServletResponse.addHeader("Cache-Control", "no-cache, no-store, must-revalidate, max-age=0");
        httpServletResponse.addHeader("Cache-Control", "no-cache='set-cookie'");
        httpServletResponse.addHeader("Pragma", "no-cache");
        filterChain.doFilter(httpServletRequest, httpServletResponse);
    }
}