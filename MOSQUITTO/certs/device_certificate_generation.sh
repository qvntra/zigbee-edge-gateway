O#! /bin/sh

curl -o rootCA.pem https://www.amazontrust.com/repository/AmazonRootCA1.pem
openssl genrsa -out private.key 2048
openssl req -new -key private.key -out deviceCert.csr -subj "/C=US/ST=TEXAS/L=DALLAS/O=QVNTRA/O=Global Security/OU=IT Department/CN=qvntra.io"
openssl x509 -req -in deviceCert.csr -CA bootstrapCACertificate.pem -CAkey bootstrapCACertificate.key -CAcreateserial -out deviceCert.crt -days 365 -sha256
cat deviceCert.crt bootstrapCACertificate.pem > cert.crt
rm deviceCert.crt deviceCert.csr
chmod 644 private.key
chmod 644 cert.crt
