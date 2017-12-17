FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
LABEL maintainer="Hamel Husain <www.github.com/hamelsmu>"

# Add this to the path for TensorFlow
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

#################### Install Anaconda
# Why Anaconda?  Its recommended Package Manager For PyTorch
# The following section is from https://hub.docker.com/r/continuumio/anaconda3/~/dockerfile/
# You may have to check this periodically and update

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git-core git mercurial subversion \
    build-essential \
    byobu \
    curl \
    htop \
    libcupti-dev \
    libfreetype6-dev \
    libpng12-dev \
    libzmq3-dev \
    pkg-config \
    python3-pip \
    python3-dev \
    python-virtualenv \
    rsync \
    software-properties-common \
    unzip \
    && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-5.0.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENV PATH /opt/conda/bin:$PATH
##################

# Install TensorFlow GPU Support
RUN pip --no-cache-dir install --upgrade \
        https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0-cp36-cp36m-linux_x86_64.whl \
        altair \
        bcolz \
        dask \
        gensim \
        graphviz \
        h5py \
        isoweek \
        keras \
        more_itertools \
        multiprocessing \
        pandas_summary \
        Pillow \
        sklearn_pandas \
        textacy \
        torchtext \
        tqdm


# Install Pytorch Instructions at http://pytorch.org/
RUN conda install -y pytorch torchvision cuda80 -c soumith
RUN conda install -y opencv
RUN conda install -c conda-forge numpy spacy

# Download Spacy Parser For English
RUN python -m spacy download en

# Open Ports for TensorBoard, Jupyter, and SSH
EXPOSE 6006
EXPOSE 7745
EXPOSE 22

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
