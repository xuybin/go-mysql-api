FROM alpine

ENV API_HOST_LS :80
RUN apk add --update curl && \
    tag=`curl -s -L https://api.github.com/repos/xuybin/go-mysql-api/releases/latest |awk -F "[tag_name]" '/tag_name/{print$0}' | sed  's/.*"\(v[0-9.]*\)".*/\1/'` && \
    curl  -L https://github.com/xuybin/go-mysql-api/releases/download/${tag}/go-mysql-api-linux-amd64 > /go-mysql-api  && \
    chmod +x /go-mysql-api && \
    apk del curl && \
    rm -rf /var/cache/apk/*
COPY docs /docs
EXPOSE 80

CMD ["/go-mysql-api"]
