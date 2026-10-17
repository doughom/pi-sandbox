# Pi Sandbox
Run the [Pi coding agent](https://pi.dev) inside a [Docker Sandbox](https://docs.docker.com/ai/sandboxes).

## Requirements
- Docker Sandbox v0.45.0 or newer

## Usage
```shell

sbx run ghcr.io/doughom/pi-sandbox:latest
```
See all of the available verions [here](https://github.com/doughom/pi-sandbox/pkgs/container/pi-sandbox).

## Sandbox Lifecycle
Ths scripts in the table run during the [sandbox lifecycle](https://github.com/docker/sandbox-kit-spec/blob/main/docs/spec/capabilities/com.docker.sandbox/lifecycle@1.md) if they exist.

|Path|Purpose|
|-|-|
|`.sbx/install.sh`|One time package installation (`npm install`)|
|`.sbx/startup.sh`|Commands to run before agent starts|

## Development
```shell
# Build and run
sbx rm -f sandbox-pi-sandbox; sbx run ./sandbox

# Build only
docker buildx build sandbox --file sandbox/pi.yaml
```
