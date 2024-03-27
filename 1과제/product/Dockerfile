# Go 베이스 이미지를 1.20 이상으로 설정합니다.
FROM golang:1.20 AS builder
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
# 정적 바이너리 빌드를 위한 환경 설정 추가
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o product-app .

FROM alpine:latest
# Alpine에서도 잘 작동하도록 필요한 패키지 설치
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/product-app .
CMD ["./product-app"]

