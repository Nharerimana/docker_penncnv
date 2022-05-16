FROM mambaorg/micromamba:0.23.0
COPY --chown=micromamba:micromamba penncnv.yaml /tmp/env.yaml
#COPY autoactivate.sh /etc/init.d/autoactivate.sh
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes
USER root
RUN mkdir /penncnv && \
    chown mambauser:mambauser /penncnv
USER mambauser
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN wget https://github.com/WGLab/PennCNV/archive/refs/tags/v1.0.5.tar.gz && \
    tar -xf v1.0.5.tar.gz && \
    rm -rf PennCNV-1.0.5/affy && \
    mv PennCNV-1.0.5/* /penncnv/ && \
    rm -rf v1.0.5.tar.gz PennCNV-1.0.5
ENV PATH "$MAMBA_ROOT_PREFIX/bin:/penncnv:$PATH"
ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "bash"]
