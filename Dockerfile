# Use a lightweight base image with a recent version of Ubuntu
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package lists and install Yocto dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gawk \
    wget \
    git \
    diffstat \
    unzip \
    texinfo \
    gcc-multilib \
    build-essential \
    chrpath \
    libsdl1.2-dev \
    xterm \
    locales \
    locales-all \
    python3 \
    python3-pip \
    python3-pexpect \
    python3-jinja2 \
    python3-distutils \
    python3-git \
    python3-subunit \
    libegl1-mesa \
    cpio \
    file \
    sudo \
    nano \
    lz4 \
    zstd \
    && rm -rf /var/lib/apt/lists/*

# Set up locale (optional, but often helpful)
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create a non-root user (named 'builder') to perform Yocto builds
RUN useradd -ms /bin/bash builder && \
    echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to non-root user
USER builder

# Create a work directory
WORKDIR /home/builder

# Clone Yocto (Poky) repository. Adjust the branch as needed, e.g. "dunfell", "kirkstone", etc.
RUN git clone --branch kirkstone --depth 1 git://git.yoctoproject.org/poky.git

# By default, just launch bash. You can override this CMD in your docker run command.
CMD ["/bin/bash"]
