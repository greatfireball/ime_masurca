FROM ubuntu:xenial

LABEL maintainer="frank.foerster@ime.fraunhofer.de"
LABEL description="Dockerfile providing the MaSuRCA hybrid assembler"

RUN apt update && apt install --yes \
    build-essential \
    curl \
    wget \
    zlib1g-dev \
    libbz2-dev
