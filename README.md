# ufo-pursue-open-atlas-docker

## prerequisites

Put `.env` file in place:

```bash
cp .env.dist .env
```

Edit empty variables with your Docker credentials.

## build dev

This will build and start a dev container with linux/amd64 architecture:

```bash
make dev
docker compose up -d
```

Override for linux/arm64:

```bash
make dev
PLATFORM=arm64 docker compose up -d
```

## release

This will tag dev as latest and as version.

Declared in Makefile variable `dockerTag`.

```bash
make release
````

### test release

You can override the image tag in `compose.yaml`:

```bash
TAG=latest docker compose up -d
```

... or ...

```bash
TAG=0.1 docker compose up -d
```

You can also combine `TAG` and `PLATFORM`:

```bash
PLATFORM=arm64 TAG=latest docker compose up -d
```

etc.

The `TAG=dev` and `PLATFORM=amd64` is default.
