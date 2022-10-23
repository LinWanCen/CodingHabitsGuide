package io.github.linwancen.common;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.util.Set;


@ControllerAdvice
public class CommonExceptionHandler {

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public CommonResponse<String> response(Exception e) {
        //参数校验get
        if (e instanceof ConstraintViolationException) {
            StringBuilder sb = new StringBuilder();
            ConstraintViolationException exs = (ConstraintViolationException) e;
            Set<ConstraintViolation<?>> violations = exs.getConstraintViolations();
            for (ConstraintViolation<?> item : violations) {
                sb.append(item.getMessage()).append(";");
            }
            // 阿里规约 泰山版 P54 请求参数值超出允许的范围
            return new CommonResponse<>("A0420 ", sb.toString());
        }
        //参数校验post
        if (e instanceof MethodArgumentNotValidException) {
            MethodArgumentNotValidException exs = (MethodArgumentNotValidException) e;
            BindingResult bindingResult = exs.getBindingResult();
            StringBuilder sb = new StringBuilder();
            for (FieldError fieldError : bindingResult.getFieldErrors()) {
                sb.append(fieldError.getField()).append(fieldError.getDefaultMessage()).append(";");
            }
            // 阿里规约 泰山版 P54 请求参数值超出允许的范围
            return new CommonResponse<>("A0420", sb.toString());
        }
        String msg = e.getLocalizedMessage();
        if (msg == null) {
            msg = e.getStackTrace()[0].toString();
        }
        return new CommonResponse<>("500", msg);
    }
}
