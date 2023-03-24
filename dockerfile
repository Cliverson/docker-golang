FROM golang:1.20 as build

WORKDIR /usr/src/app

COPY app.go ./

COPY . .

RUN go mod init fullcycle \
  && go build -ldflags "-s -w"

##

FROM busybox:musl
COPY --from=build /usr/src/app/fullcycle /go/bin/
WORKDIR /go/bin
CMD ["./fullcycle"]
