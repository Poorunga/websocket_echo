FROM golang:1.14-alpine3.11 AS builder
RUN apk update && apk add build-base
WORKDIR /code
COPY . .
RUN make

FROM alpine:3.11
COPY --from=builder /code/client /client
COPY --from=builder /code/server /server
EXPOSE 8080
ENTRYPOINT ["/server"]
