FROM ubuntu:18.04
MAINTAINER Eric Zhu

RUN apt-get update && apt-get install -y \
  gcc \
  g++ \
  make \
  clang \
  cmake \
  libgtest-dev \
  libboost-all-dev \
  git \
  automake \
  autoconf \
  autoconf-archive \
	pkg-config \
  python \
  zip \
  unzip \
  libtool \
  libevent-dev \
  libdouble-conversion-dev \
  libgoogle-glog-dev \
  libgflags-dev \
  liblz4-dev \
  liblzma-dev \
  libsnappy-dev \
  zlib1g-dev \
  binutils-dev \
  libjemalloc-dev \
  libssl-dev \
  libiberty-dev \
  wget \
  doxygen \
  python-numpy \
	sudo && \
	useradd -m develop && adduser develop sudo && \
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  sudo passwd -d develop

ENV LD_LIBRARY_PATH=/libs
ENV CPLUS_INCLUDE_PATH=/libs/include

USER develop
WORKDIR /home/develop
RUN mkdir workspace
RUN wget -nv https://github.com/bazelbuild/bazel/releases/download/0.16.0/bazel-0.16.0-installer-linux-x86_64.sh && \ 
	chmod +x bazel-0.16.0-installer-linux-x86_64.sh && \
  ./bazel-0.16.0-installer-linux-x86_64.sh --user && \
  rm -f bazel-0.16.0-installer-linux-x86_64.sh
RUN echo 'export PATH="$PATH:$HOME/bin"' >> .bashrc
RUN (wget https://www.openssl.org/source/openssl-1.0.2o.tar.gz && \
  tar xf openssl-1.0.2o.tar.gz && cd openssl-1.0.2o && \
  ./Configure  no-shared linux-x86_64-clang &&\
  make  && sudo make install) && \
  rm -fr openssl-1.0.2o.tar.gz  openssl-1.0.2o

CMD ["/bin/bash"]




