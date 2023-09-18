FROM golang:1.18-alpine
COPY . /app
WORKDIR /app
RUN go mod download ; go build -o ./app/main
USER nobody
CMD ["./app/main"]
