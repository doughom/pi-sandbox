# Pi Sandbox
[Docker Sandbox](https://docs.docker.com/ai/sandboxes) for [Pi](https://pi.dev).

## Usage
See all available verions [here](https://github.com/doughom/pi-sandbox/pkgs/container/pi-sandbox).

```shell
# Create new sandbox
sbx run pi --kit ghcr.io/doughom/pi-sandbox:1.0.0

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
