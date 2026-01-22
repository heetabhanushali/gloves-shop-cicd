FROM --platform=linux/amd64 golang:1.21-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o dispatch .

FROM --platform=linux/amd64 alpine:latest

WORKDIR /app

COPY --from=builder /app/dispatch .

CMD ["./dispatch"]