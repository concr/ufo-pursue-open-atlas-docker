# ufo-pursue-open-atlas-docker

Read along for building your own image.

If you just want to use my build:

```bash
docker run -p 8000:8000 poopknife/ufo-pursue-open-atlas:latest
```

Then open up your browser and open: http://localhost:8000

## prerequisites

Put `.env` file in place:

```bash
cp .env.dist .env
```

Edit empty variables with your own DockerHub credentials.

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

This will re-tag dev as latest and version and push to your DockerHub registry.

Declared in Makefile variable `dockerTag`

```bash
make release
```

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
