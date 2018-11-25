FROM    frolvlad/alpine-glibc
LABEL   maintainer="Aviator" \
        discord="Aviator#1024"

ENV VERSION=v0.12.3.4
ENV GITHUB_AUTOR="zocteam"
ENV GITHUB_REPO="zeroonecoin"
ENV GITHUB_TAR="zeroonecore-0.12.3-x86_64-linux-gnu.tar.gz"

RUN apk add --no-cache curl && \
    curl -L https://github.com/$GITHUB_AUTOR/$GITHUB_REPO/releases/download/$VERSION/$GITHUB_TAR | tar zx -C /tmp &&\
    find /tmp -name "zeroone-cli" -exec cp {} /usr/local/bin \; &&\ 
    find /tmp -name "zerooned" -exec cp {} /usr/local/bin \; &&\
    rm -r /tmp/* &&\
    apk del curl

VOLUME ["/root/.zeroonecore"]

EXPOSE 10000/tcp

CMD zerooned -printtoconsole
