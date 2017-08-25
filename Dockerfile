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

ENV GOLANG_VERSION 1.9
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-armv6l.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 f52ca5933f7a8de2daf7a3172b0406353622c6a39e67dd08bbbeb84c6496f487

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/
