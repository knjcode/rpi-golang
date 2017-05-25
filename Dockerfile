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

ENV GOLANG_VERSION 1.8.3
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-armv6l.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 3c30a3e24736ca776fc6314e5092fb8584bd3a4a2c2fa7307ae779ba2735e668

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/
