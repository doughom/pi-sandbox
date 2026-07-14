# https://hub.docker.com/layers/docker/sandbox-templates/shell
FROM docker/sandbox-templates@sha256:bd90847e98720dde718fe95b24bd4c7d9d4de41966339eb8bf3ab2bb683259e5

# https://github.com/earendil-works/pi/releases
ARG PI_VERSION=v0.80.3
ARG PI_TAR_HASH=e74a34ac2505556164144d8e39a64d6d5276f092166dad914319edc30c48abee

USER root
RUN apt install --update --yes --no-install-recommends \
    fd-find \
    nano \
    && rm -rf /var/lib/apt/lists/*

USER agent
RUN curl -LO https://github.com/earendil-works/pi/releases/download/$PI_VERSION/pi-linux-x64.tar.gz \
    && sha256sum pi-linux-x64.tar.gz | grep -q $PI_TAR_HASH \
    && tar xzf pi-linux-x64.tar.gz \
    && rm pi-linux-x64.tar.gz \
    && mkdir -p $HOME/.local/bin \
    && mv pi/theme pi/pi $HOME/.local/bin \
    && rm -rf pi \
    && mkdir -p $HOME/.pi/agent

COPY --chown=agent:agent models.json /home/agent/.pi/agent
