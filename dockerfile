FROM golang:1.20 as build

WORKDIR /usr/src/app

COPY app.go ./

COPY . .

RUN go mod init fullcycle \
  && go build

##

FROM alpine:3.14
RUN apk add --no-cache --no-network --purge
COPY --from=build /usr/src/app/fullcycle /go/bin/
WORKDIR /go/bin
CMD ["./fullcycle"]