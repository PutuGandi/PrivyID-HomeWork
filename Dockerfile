FROM golang:alpine

WORKDIR /app
COPY goweb.go /app
RUN go mod init webgo
RUN go mod tidy
RUN go build -o goweb .

CMD ["/app/goweb"]

