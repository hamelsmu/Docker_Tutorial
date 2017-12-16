# reference: https://hub.docker.com/_/ubuntu/
FROM ubuntu:16.04

# Adds metadata to the image as a key value pair example LABEL version="1.0"
LABEL maintainer="Hamel Husain <youremail@gmail.com>"

##Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    git-core \
    build-essential \
    byobu \
    curl \
    htop \
    pkg-config \
    python-pip \
    python3-dev \
    python-setuptools \
    python-virtualenv \
    unzip \
    && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN pip --no-cache-dir install --upgrade \
        altair \
        dask \
        multiprocessing \
        pandas_summary \
        sklearn_pandas

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-5.0.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

# set path for conda
ENV PATH /opt/conda/bin:$PATH

# Open Ports for Jupyter
EXPOSE 7745

#Setup File System
RUN mkdir ds
ENV HOME=/ds
ENV SHELL=/bin/bash
VOLUME /ds
WORKDIR /ds
ADD run_jupyter.sh /ds/run_jupyter.sh
RUN chmod +x /ds/run_jupyter.sh

# Run the shell
CMD  ["./run_jupyter.sh"]
