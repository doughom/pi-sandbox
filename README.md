# Pi Sandbox
[Docker Sandbox](https://docs.docker.com/ai/sandboxes) for [Pi](https://pi.dev).

## Requirements
- Docker Sandbox v0.45.0 or newer

## Usage
See all available verions [here](https://github.com/doughom/pi-sandbox/pkgs/container/pi-sandbox).

```shell
# Create new sandbox
sbx run ghcr.io/doughom/pi-sandbox

# List sandboxes
sbx ls

# Run existing sandbox
sbx run --name sandbox-name
```

## Development
```shell
# Run local version of sandbox
sbx run ./sandbox

# Build
docker buildx build sandbox --file sandbox/pi.yaml
```
