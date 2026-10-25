# https://hub.docker.com/layers/astral/uv/latest
FROM astral/uv:latest@sha256:32a7bb39b496babbd997b0a39a4d66c126bdaf5661b302bf6f06abda8deca6ff AS uv

# https://hub.docker.com/layers/docker/sandbox-templates/shell
FROM docker/sandbox-templates:shell@sha256:7a248c96459694d181d9d51ffc9e530c0b9a4cb3d1887cc070425336b1fb5115
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
