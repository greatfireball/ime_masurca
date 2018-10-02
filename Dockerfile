FROM ubuntu:xenial

LABEL maintainer="frank.foerster@ime.fraunhofer.de"
LABEL description="Dockerfile providing the MaSuRCA hybrid assembler"

WORKDIR /opt/

RUN apt update && apt install --yes --no-install-recommends \
        build-essential \
	libboost-dev \
        curl \
        file \
        libstatistics-descriptive-perl \
        zlib1g-dev \
        libbz2-dev && \
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
