# MMastro.dev's Wiki

Personal wiki and documentation site for [MMastro.dev](https://mmastro.dev), built with [mdBook](https://rust-lang.github.io/mdBook/). Serves as a self-hosted reference for the infrastructure, services, and configurations powering the site.

## Purpose

A living reference for future me — covering setup guides, self-hosted service configs, and any other notes worth keeping around.

## Requirements

- [Docker](https://www.docker.com/) (recommended)
- **or** [mdBook](https://rust-lang.github.io/mdBook/) installed locally

## Usage

### With Docker

Build and serve the book locally:

```bash
docker build -t mastrodocs .
docker run --rm -p 3000:3000 mastrodocs
```

Then open [http://localhost:3000](http://localhost:3000).

### Without Docker

Install mdBook and serve the book directly from the source:

```bash
mdbook serve --port 3000 --open
```

Or build only (outputs to `book/`):

```bash
mdbook build
```

## Project Structure

```
.
├── book.toml       # mdBook configuration
├── Dockerfile      # Container build & serve setup
└── src/            # Book source files (Markdown)
    └── SUMMARY.md  # Table of contents
```
