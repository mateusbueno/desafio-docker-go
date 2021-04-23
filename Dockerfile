FROM golang:1.14-alpine AS baseGo

RUN apk add upx
RUN mkdir /go/src/app

WORKDIR /go/src/app
COPY . .

RUN go get -d -v \
  && go install -v \
  && go build -a -ldflags="-s -w" && upx --brute app

FROM scratch
COPY --from=baseGo /go/bin/app /go/bin/app
CMD ["/go/bin/app"]
