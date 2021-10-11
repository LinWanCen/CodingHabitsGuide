### 生成一个 2048 位的 RSA 私钥
openssl genrsa -out private_key.pem 2048
### 将私钥转换为 PKCS#8 格式（以便 Java 可以读取它）
openssl pkcs8 -topk8 -inform PEM -outform DER -in private_key.pem -out private_key.der -nocrypt
### 以DER格式输出公钥部分（以便Java可以读取它）
openssl rsa -in private_key.pem -pubout -outform DER -out public_key.der
### 更改为 base64：
openssl base64 -in private_key.der -out private_key_base64.der
openssl base64 -in public_key.der -out public_key_base64.der
### 记得在提交前清除空格字符和换行符！！！