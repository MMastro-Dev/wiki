FROM debian:bookworm-slim

ARG MDBOOK_VERSION=0.5.2
ARG PORT=3000

# Install curl and ca-certificates to download the precompiled binary
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    # Install mdBook precompiled binary directly to PATH
    && curl -sSL "https://github.com/rust-lang/mdBook/releases/download/${MDBOOK_VERSION}/mdbook-${MDBOOK_VERSION}-x86_64-unknown-linux-gnu.tar.gz" \
       | tar -xz --directory=/usr/local/bin \
    && mdbook --version

WORKDIR /book

COPY book.toml book.toml
COPY src/ src/

# Build the book at image build time to catch errors early (CI)
RUN mdbook build

EXPOSE ${PORT}

# Serve the built book; bind to 0.0.0.0 so it is reachable outside the container
CMD ["mdbook", "serve", "--port", "3000", "--hostname", "0.0.0.0"]
