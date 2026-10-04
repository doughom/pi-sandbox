# https://hub.docker.com/layers/docker/sandbox-templates/shell
FROM docker/sandbox-templates:shell@sha256:c66aa9c0212bb710089cc356501f8bde8989e02a7071bf1c6be0893be1c30adf

USER root
RUN apt install --update --yes --no-install-recommends \
    fd-find \
    nano \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/local/share/pi/ /usr/local/lib/node_modules/

COPY --chown=agent:agent models.json settings.json /home/agent/.pi/agent/
COPY package.json package-lock.json /usr/local/share/pi/
RUN cd /usr/local/share/pi/ \
    && npm install \
    && cp -a node_modules/* /usr/local/lib/node_modules/ \
    && ln -s /usr/local/lib/node_modules/@earendil-works/pi-coding-agent/dist/bundle/cli.js /usr/local/bin/pi \
    && ln -s /usr/local/lib/node_modules/@earendil-works/pi-ai/dist/cli.js /usr/local/bin/pi-ai

USER agent
CMD ["pi"]
