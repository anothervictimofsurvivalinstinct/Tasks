FROM golang:alpine AS base

RUN apk add sqlite build-base

COPY . /go/src/app

WORKDIR /go/src/app

RUN cat schema.sql | sqlite3 tasks.db

RUN go mod init

RUN go get

RUN go build -o Tasks

FROM golang:alpine

RUN apk add sqlite

COPY --from=base /go/src/app /go/src/app

WORKDIR /go/src/app
    
ENTRYPOINT ./Tasks    
