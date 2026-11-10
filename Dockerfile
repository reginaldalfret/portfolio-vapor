FROM swift:6.0-jammy AS builder
WORKDIR /app
COPY Package.swift ./
COPY Sources/ Sources/
COPY Public/ Public/
RUN swift build -c release

FROM swift:6.0-jammy-slim
WORKDIR /app
COPY --from=builder /app/.build/release/App /app/App
COPY --from=builder /app/Public /app/Public
ENV PORT=8086
EXPOSE 8086
CMD ["/app/App", "serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8086"]
