# Stage 1: Build
FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY . .

RUN go mod tidy

RUN CGO_ENABLED=0 go build -o parcel-app

# Stage 2: Runtime
FROM alpine:3.18

LABEL authors="shket000"

WORKDIR /app

COPY --from=builder /app/parcel-app ./
COPY --from=builder /app/tracker.db ./

ENTRYPOINT ["./parcel-app"]