FROM alpine:latest

WORKDIR /v2board
RUN cd /v2board \
    && wget https://github.com/deepbwork/v2board-server/raw/master/v2board-server \
    && wget https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
    && unzip v2ray-linux-64.zip \
    && rm -rf v2ray-linux-64.zip \
    && chmod +x /v2board/*

ENTRYPOINT /v2board/v2board-server -api="$API" -token="$TOKEN" -node="$NODE" -localport="23333" -license="$LICENSE"