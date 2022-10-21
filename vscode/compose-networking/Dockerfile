FROM centos:7 AS build

RUN yum makecache fast
RUN yum -y update && yum groupinstall -y "Development tools"
RUN yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel hunspell-devel libcurl-devel epel-release blas-devel lapack-devel postgresql-devel libffi-devel git
RUN yum install -y sed openssh-server pkgconfig libtool autoconf automake uuid-dev gcc-c++ make mlocate dos2unix wget screen parallel policycoreutils-python ethtool nano aspell aspell-en enchant
RUN updatedb

# Build Python from source
ARG PYTHON_VERSION=3.7.7
RUN set -eux; \
  curl https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz -o python.tar.xz; \
  mkdir -p /usr/src/python; \
  tar --extract --directory /usr/src/python --strip-components=1 --file python.tar.xz;

WORKDIR /usr/src/python
RUN set -eux; \
  ./configure --with-ensurepip=upgrade; \
  make -j "$(nproc)"; \
  make altinstall; \
  ln -s $(ls /usr/local/bin/python3*[0-9]) /usr/local/bin/python3

RUN python3 -m pip install -U pip

COPY requirements*.txt ./
RUN python3 -m pip install -r requirements.txt --no-binary :all:
RUN python3 -m pip install -r requirements2.txt --no-binary :all:
RUN python3 -m pip install -r requirements3.txt --no-binary :all:
