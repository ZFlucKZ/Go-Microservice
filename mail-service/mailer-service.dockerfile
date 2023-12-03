# base go image
FROM golang:1.21.4-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o mailerServiceApp ./cmd/api

RUN chmod +x /app/mailerServiceApp

# build a tiny docker image
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/mailerServiceApp /app

CMD [ "/app/mailerServiceApp" ]