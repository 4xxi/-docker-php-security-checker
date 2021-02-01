# ---- Base Image ----
FROM alpine AS base
## ---- security-checker ----
FROM base AS security-checker
## install vendors
RUN apk add --no-cache curl git make musl-dev go
ARG SECURITY_VERSION=1.0.0
# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /usr/src/go
ENV PATH /usr/src/go/bin:$PATH
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin /usr/src/go /usr/src/security-checker
RUN curl -Lo /usr/src/security-checker.tar.gz https://github.com/fabpot/local-php-security-checker/archive/v$SECURITY_VERSION.tar.gz
RUN tar -xvzf /usr/src/security-checker.tar.gz -C /usr/src/
RUN cd /usr/src/local-php-security-checker-$SECURITY_VERSION && go build
RUN chmod +x /usr/src/local-php-security-checker-$SECURITY_VERSION/local-php-security-checker && cp /usr/src/local-php-security-checker-$SECURITY_VERSION/local-php-security-checker /usr/local/bin/
