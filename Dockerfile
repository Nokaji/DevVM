# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Europe/Paris

# Update package lists and install essential packages with better error handling
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        lsb-release \
        software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install cmake and other build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        cmake \
        ninja-build \
        build-essential \
        gdb \
        clang \
        lldb \
        ccache \
        autoconf \
        automake \
        libtool \
        meson \
        python3-pip \
        python3-dev \
        git \
        doxygen \
        graphviz \
        zip \
        unzip \
        tar \
        wget \
        nano \
        htop \
        net-tools \
        nodejs \
        npm \
        pkg-config \
        linux-libc-dev \
        libssl-dev \
        libz-dev \
        libboost-all-dev \
        libcurl4-openssl-dev \
        nlohmann-json3-dev \
        libfmt-dev \
        libyaml-cpp-dev \
        libspdlog-dev \
        clang-format \
        clang-tidy \
        cppcheck \
        strace \
        ltrace \
        valgrind \
	python3.12-venv\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Tools for any Language
RUN curl -fsSL https://bun.sh/install | bash
RUN curl -fsSL https://sh.rustup.rs | bash -s -- -y

# Add bun to PATH
ENV PATH="/root/.bun/bin:${PATH}"

WORKDIR /workspace
