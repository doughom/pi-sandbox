# https://hub.docker.com/r/astral/uv
FROM astral/uv:0.13.1@sha256:4a1f3666816dafadd20ceb71eac9a7d56d7ef30279f7d64048519ab901ada336 AS uv

# https://hub.docker.com/layers/docker/sandbox-templates/shell
FROM docker/sandbox-templates:shell@sha256:c66aa9c0212bb710089cc356501f8bde8989e02a7071bf1c6be0893be1c30adf
COPY --from=uv /uv /uvx /usr/local/bin/
COPY cmd.sh package.json package-lock.json /

USER root
RUN apt install --update --yes --no-install-recommends \
        fd-find \
        nano \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /usr/local/lib/node_modules/ \
    && tempDir=$(mktemp -d) \
    && cd $tempDir \
    && mv /package.json /package-lock.json . \
    && npm install \
    && cp -a node_modules/* /usr/local/lib/node_modules/ \
    && cd - \
    && rm -rf $tempDir \
    && ln -s /usr/local/lib/node_modules/@earendil-works/pi-coding-agent/dist/bundle/cli.js /usr/local/bin/pi \
    && ln -s /usr/local/lib/node_modules/@earendil-works/pi-ai/dist/cli.js /usr/local/bin/pi-ai

COPY --chown=agent:agent lmstudio-models.ts /home/agent/.pi/agent/extensions/

ENV UV_PROJECT_ENVIRONMENT=/home/agent/.cache/venv
USER agent
CMD ["/cmd.sh"]
