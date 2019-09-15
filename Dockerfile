FROM golang:1.13-buster

ARG TDLIB_VERSION=1.5.0

ADD https://github.com/tdlib/td/archive/v${TDLIB_VERSION}.tar.gz /tmp/
WORKDIR /td/td-${TDLIB_VERSION}/build
RUN tar -C /td -xvzf /tmp/v${TDLIB_VERSION}.tar.gz
RUN apt-get update && \
	apt-get install -y apt-utils cmake zlib1g-dev libssl-dev gperf libreadline-dev && \
	cmake -DCMAKE_BUILD_TYPE=Release .. && \
	 # -j5 refers to number of your cpu cores + 1 for multi-threaded build.
	cmake --build . -- -j5 && \
	make install
