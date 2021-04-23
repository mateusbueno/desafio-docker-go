FROM golang:1.14-alpine AS baseGo

RUN mkdir /go/src/app

WORKDIR /go/src/app
COPY . .

RUN go build -ldflags="-s -w" fullcycle.go

FROM scratch
COPY --from=baseGo /go/src/app .
CMD ["/fullcycle"]
