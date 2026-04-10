FROM rust:bookworm AS builder

# Each RUN is a separate cache layer — only the changed crate rebuilds on version bump
RUN cargo install mdbook --vers "0.4.40" --locked
RUN cargo install mdbook-admonish --vers "1.20.0" --locked
RUN cargo install mdbook-mermaid --vers "0.14.0" --locked
RUN cargo install mdbook-linkcheck --vers "0.7.7" --locked

FROM debian:bookworm-slim

ARG PORT=3000

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/cargo/bin/mdbook /usr/local/bin/mdbook
COPY --from=builder /usr/local/cargo/bin/mdbook-admonish /usr/local/bin/mdbook-admonish
COPY --from=builder /usr/local/cargo/bin/mdbook-mermaid /usr/local/bin/mdbook-mermaid
COPY --from=builder /usr/local/cargo/bin/mdbook-linkcheck /usr/local/bin/mdbook-linkcheck

WORKDIR /book

COPY book.toml book.toml
COPY README.md README.md
COPY src/ src/

RUN mdbook-admonish install .
RUN mdbook-mermaid install .

# Build the book at image build time to catch errors early (CI)
RUN mdbook build

EXPOSE ${PORT}

CMD ["mdbook", "serve", "--port", "3000", "--hostname", "0.0.0.0"]
