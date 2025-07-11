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

# Add Kitware repository for latest cmake
RUN curl -fsSL https://apt.kitware.com/keys/kitware-archive-latest.asc | gpg --dearmor -o /usr/share/keyrings/kitware-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/kitware.list

# Install cmake and other build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        cmake \
        ninja-build \
        build-essential \
        git \
        doxygen \
        graphviz \
        zip \
        unzip \
        tar \
        wget \
        htop \
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
        valgrind \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Verify that cmake and ninja are installed and available
RUN cmake --version && ninja --version
# Install vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git /opt/vcpkg && \
    cd /opt/vcpkg && \
    ./bootstrap-vcpkg.sh && \
    chmod +x vcpkg

# Add vcpkg to PATH
ENV PATH="/opt/vcpkg:${PATH}"

# Verify vcpkg installation
RUN vcpkg version

# Install dependencies using vcpkg
RUN vcpkg install \
    nlohmann-json \
    fmt \
    yaml-cpp \
    curl[tool] \
    spdlog \
    --clean-after-build

RUN curl -fsSL https://bun.sh/install | bash

# Add bun to PATH
ENV PATH="/root/.bun/bin:${PATH}"

WORKDIR /workspace
