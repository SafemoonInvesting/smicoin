FROM ubuntu:22.04
COPY ./smicoin.conf /root/.smicoin/smicoin.conf
COPY . /smicoin
WORKDIR /smicoin
#shared libraries and dependencies
RUN apt update
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
RUN apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
#BerkleyDB for wallet support
RUN apt-get install -y software-properties-common
# RUN add-apt-repository ppa:bitcoin/bitcoin
# RUN apt-get update
RUN apt-get install -y libdb-dev libdb++-dev
#upnp
RUN apt-get install -y libminiupnpc-dev
#ZMQ
RUN apt-get install -y libzmq3-dev
#build smicoin source
RUN ./autogen.sh
RUN ./configure --disable-wallet
RUN make
RUN make install
#open service port
EXPOSE 9332 19332
CMD ["faithcoind", "--printtoconsole"]
