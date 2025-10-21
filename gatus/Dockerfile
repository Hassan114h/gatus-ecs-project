# Build stage
FROM golang:alpine AS builder
WORKDIR /app
COPY . .
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -installsuffix cgo -o gatus .

# Final stage
FROM gcr.io/distroless/base:nonroot
WORKDIR /app

# Copy the built binary and config
COPY --from=builder /app/gatus .
COPY --from=builder /app/config.yaml ./config/config.yaml

ENV PORT="8080"
EXPOSE ${PORT}
ENTRYPOINT ["/app/gatus"]

