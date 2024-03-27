FROM alpine:latest

WORKDIR /app

COPY stress-amd64 .
RUN chmod +x stress-amd64

CMD ["./stress-amd64"]