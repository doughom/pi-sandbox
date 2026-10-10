# Pi Sandbox
Run the [Pi coding agent](https://pi.dev) inside a [Docker Sandbox](https://docs.docker.com/ai/sandboxes).

## Requirements
- Docker Sandbox v0.45.0 or newer

## Usage
```shell

sbx run ghcr.io/doughom/pi-sandbox:latest
```
See all of the available verions [here](https://github.com/doughom/pi-sandbox/pkgs/container/pi-sandbox).


## Development
```shell
# Build and run
sbx rm -f sandbox-pi-sandbox; sbx run ./sandbox

# Build only
docker buildx build sandbox --file sandbox/pi.yaml
```
