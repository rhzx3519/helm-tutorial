FROM golang:1.17 as builder
COPY tcp_server.go /
RUN go build -o /server /tcp_server.go

FROM gcr.io/distroless/base-debian10
WORKDIR /
COPY --from=builder /server /server
EXPOSE 8080
ENTRYPOINT ["/server"]