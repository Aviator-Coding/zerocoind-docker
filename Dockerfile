FROM ubuntu:16.04

RUN apt-get update && \
    apt-get --no-install-recommends --yes install \
         git \
         automake \
         build-essential \
         libtool \
         autotools-dev \
         autoconf \
         pkg-config \
         libssl-dev \ 
         libboost-all-dev \
         libevent-dev \
         bsdmainutils \
         vim \
         software-properties-common && \
         rm -rf /var/lib/apt/lists/* 

RUN add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
          libdb4.8-dev \
          libdb4.8++-dev \
          libminiupnpc-dev && \
          rm -rf /var/lib/apt/lists/* 

WORKDIR /zero

## Copy logrotate for shriniking logfiles
#COPY ./scripts/ipsd_logrotate /etc/logrotate.d/

ENV WALLET_VERSION v0.12.3.2

RUN git clone https://github.com/zocteam/zeroonecoin.git . && \
    git checkout $WALLET_VERSION && \
    ./autogen.sh && \
    ./configure && \
    make &&\
    strip /zero/src/zerooned /zero/src/zeroone-cli && \
    mv /zero/src/zerooned /usr/local/bin/ && \
    mv /zero/src/zeroone-cli /usr/local/bin/ && \
    # clean
    rm -rf /zero 

VOLUME ["/root/.zeroonecore"]

EXPOSE 10000

CMD exec /usr/local/bin/zerooned && tail -f /root/.zerocoin/debug.log

