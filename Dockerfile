ARG osversion=xenial
FROM ubuntu:${osversion}

ARG VERSION=master
ARG VCS_REF
ARG BUILD_DATE

RUN echo "VCS_REF: "${VCS_REF}", BUILD_DATE: "${BUILD_DATE}", VERSION: "${VERSION}

LABEL maintainer="frank.foerster@ime.fraunhofer.de" \
      description="Dockerfile providing the MaSuRCA hybrid assembler" \
      version=${VERSION} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-url="https://github.com/greatfireball/ime_masurca.git"

WORKDIR /opt/

RUN apt update && apt install --yes --no-install-recommends \
        build-essential \
	ca-certificates \
        curl \
        file \
	libboost-dev \
        libbz2-dev \
        libstatistics-descriptive-perl \
        zlib1g-dev && \
    curl https://github.com/alekseyzimin/masurca/releases/download/3.2.6/MaSuRCA-3.2.6.tar.gz > MaSuRCA-3.2.6.tar.gz && \
    tar xzf MaSuRCA-3.2.6.tar.gz && \
    rm MaSuRCA-3.2.6.tar.gz && \
    cd MaSuRCA-3.2.6 && \
    ./install.sh && \
    apt remove --yes \
        curl && \
    rm -rf /var/lib/apt/lists/*

VOLUME /data

WORKDIR /data

ENV MASURCAPATH=/opt/MaSuRCA-3.2.6
ENV PATH=$MASURCAPATH/bin:$PATH
ENV SR_CONFIG_EXAMPLE=$MASURCAPATH/sr_config_example.txt

CMD masurca
