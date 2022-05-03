FROM mambaorg/micromamba:0.23.0
COPY --chown=micromamba:micromamba gnomix.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes
USER root
RUN mkdir /gnomix && \
    chown mambauser:mambauser /gnomix
USER mambauser
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN wget https://github.com/AI-sandbox/gnomix/archive/refs/heads/main.zip && \
    unzip main.zip && \
    mv gnomix-main/* /gnomix/ && \
    rm -rf main.zip /gnomix/demo
ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "python3", "/gnomix/gnomix.py"]
