FROM rust:slim-bookworm AS builder

#Download Base mdBook
RUN cargo install mdbook

# Download Plugins

# mdbook-admonish
RUN cargo install mdbook-admonish --vers "1.20.0" --locked
# mdbook-mermaid
RUN cargo install mdbook-mermaid
# mdbook-linkcheck
RUN cargo install mdbook-linkcheck

FROM debian:bookworm-slim

ARG PORT=3000

COPY --from=builder /usr/local/cargo/bin/mdbook /usr/local/bin/mdbook

WORKDIR /book

COPY book.toml book.toml
COPY README.md README.md
COPY src/ src/

# Install Plugins
RUN mdbook-admonish install .
RUN mdbook-mermaid install .

# Build the book at image build time to catch errors early (CI)
RUN mdbook build

EXPOSE ${PORT}

# Serve the built book; bind to 0.0.0.0 so it is reachable outside the container
CMD ["mdbook", "serve", "--port", "3000", "--hostname", "0.0.0.0"]
