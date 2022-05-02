FROM mambaorg/micromamba:0.23.0
COPY --chown=micromamba:micromamba gnomix.yaml /tmp/env.yaml
RUN apt-get update && apt-get install -y wget unzip && \
    rm -rf /var/lib/{apt,dpkg,cache,log} && \
    micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes && \
    mamba activate base && \
    wget https://github.com/AI-sandbox/gnomix/archive/refs/heads/main.zip && \
    unzip main.zip && \
    mv gnomix-main /gnomix && \
    rm -rf main.zip /gnomix/demo
ENTRYPOINT ["python3 /gnomix/gnomix.py"]
