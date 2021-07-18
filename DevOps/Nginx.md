# Nginx

### 不要用 root 启动避免后面非 root 报 Premature EOF

在 nginx.conf 中配置 user 启动用户

### 设置 Nginx 的 body 大小避免请求失败
```
client_max_body_size 8m;
```
说明：
```
默认：client_max_body_size 1m;
默认：client_body_timeout 60s;
默认：proxy_connect_timeout 60s; # 通常不超过 75 秒
默认：proxy_read_timeout 60s;
默认：proxy_send_timeout 60s;
语境：http, server, location

默认：client_header_timeout 60s;
语境：http, server
```
https://nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size

### 设置 X-Forwarded-For 以便服务能根据请求头获取到请求 IP

最外层 Nginx：
```
proxy_set_header X-Forwarded-For $remote_addr;
```
里层 Nginx：
```
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
```
说明:
```
默认：
proxy_set_header Host $proxy_host;
proxy_set_header Connection close;
语境：http, server, location
```

https://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_set_header

## 配置指南

一级成员

contexts | 说明
---      | ---
events   | 一般连接处理
http     | HTTP 流量
mail     | 邮件流量
stream   | TCP 和 UDP 流量

    server {
        # configuration of HTTP virtual server 1       
        location /one {
            # configuration for processing URIs starting with '/one'
        }
        location /two {
            # configuration for processing URIs starting with '/two'
        }
    }

