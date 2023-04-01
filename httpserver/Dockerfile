FROM golang:1.20-bullseye as builder

WORKDIR /app

COPY . .

# Build the helloworld binary
RUN go build -v -o /app/helloworld

# Base Slim Debian Image with nothing in it
FROM debian:bookworm-slim

# Completely useless I think
WORKDIR /app

# Copy from the previous step (builder) the helloworld binary
COPY --from=builder /app/helloworld /app/helloworld

# Run the HelloWorld server
CMD ["/app/helloworld"]

