FROM golang:1.14-alpine AS baseGo

RUN mkdir /go/src/app

WORKDIR /go/src/app
COPY . .

RUN go get -d -v \
  && go install -v \
  && go build

FROM hello-world
COPY --from=baseGo /go/bin/app /go/bin/
EXPOSE 3000
CMD ["/go/bin/app"]
