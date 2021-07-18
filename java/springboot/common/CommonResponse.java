package io.github.linwancen.common;

public class CommonResponse<T> {

    private String code;

    private String msg;

    private T data;

    public CommonResponse() {
    }

    public CommonResponse(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    // region [静态工厂方法]

    public static <T> CommonResponse<T> success() {
        return success(null);
    }

    public static <T> CommonResponse<T> success(T data) {
        return of(data, "0", "success");
    }

    public static <T> CommonResponse<T> of(String code, String msg) {
        return of(null, code, msg);
    }

    public static <T> CommonResponse<T> of(T data, String code, String msg) {
        CommonResponse<T> response = new CommonResponse<>(code, msg);
        response.setData(data);
        return response;
    }

    // endregion 静态工厂方法

    public <O> CommonResponse<O> trans() {
        return new CommonResponse<>(code, msg);
    }

    // region [判断]

    public boolean ok() {
        return "0".equals(code);
    }

    public boolean no() {
        return !"0".equals(code);
    }

    // endregion 判断


    public String getCode() {
        return code;
    }

    public CommonResponse<T> setCode(String code) {
        this.code = code;
        return this;
    }

    public String getMsg() {
        return msg;
    }

    public CommonResponse<T> setMsg(String msg) {
        this.msg = msg;
        return this;
    }

    public T getData() {
        return data;
    }

    public CommonResponse<T> setData(T data) {
        this.data = data;
        return this;
    }
}
