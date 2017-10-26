FROM resin/rpi-raspbian:jessie

# Add build-dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
		bash \
		bzr \
		ca-certificates \
		curl \
		g++ \
		gcc \
		git \
		libc6-dev \
		make \
		mercurial \
		openssh-client \
		pkg-config \
		procps \
		subversion \
		wget \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.9.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-armv6l.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 8a6758c8d390e28ef2bcea511f62dcb43056f38c1addc06a8bc996741987e7bb

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/
