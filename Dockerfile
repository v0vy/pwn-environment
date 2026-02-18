FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Core dependencies
# Enable 32-bit support first
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    gcc-multilib \
    g++-multilib \
    gdb \
    gdbserver \
    python3 \
    python3-pip \
    python3-dev \
    git \
    curl \
    wget \
    netcat-openbsd \
    nasm \
    ltrace \
    strace \
    socat \
    file \
    binutils \
    libc6-dbg \
    libc6-i386 \
    libc6-dbg:i386 \
    libc6:i386 \
    libstdc++6:i386 \
    libssl-dev \
    libffi-dev \
    ruby \
    ruby-dev \
    checksec \
    unzip \
    iputils-ping \
    tmux \
    vim \
    && rm -rf /var/lib/apt/lists/*


# Enable 32-bit support
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
    libc6:i386 \
    libstdc++6:i386 \
    && rm -rf /var/lib/apt/lists/*

# Python pwn tools
RUN pip3 install --no-cache-dir \
    pwntools \
    ropper \
    capstone \
    keystone-engine \
    unicorn \
    z3-solver \
    angr \
    ropgadget

# one_gadget
RUN gem install one_gadget seccomp-tools

# pwndbg
RUN git clone https://github.com/pwndbg/pwndbg /opt/pwndbg && \
    cd /opt/pwndbg && ./setup.sh

# ROPgadget (standalone)
RUN git clone https://github.com/JonathanSalwan/ROPgadget /opt/ROPgadget && \
    cd /opt/ROPgadget && pip3 install .

# radare2
RUN git clone https://github.com/radareorg/radare2 /opt/radare2 && \
    cd /opt/radare2 && sys/install.sh

# Ghidra headless (optional, comment out if image size is a concern)
# RUN wget -q https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.0.1_build/ghidra_11.0.1_PUBLIC_20240130.zip -O /tmp/ghidra.zip && \
#     unzip /tmp/ghidra.zip -d /opt && rm /tmp/ghidra.zip


# Set up workspace
WORKDIR /ctf
VOLUME /ctf

# Shell config
RUN echo 'export PS1="\[\e[31m\]pwn\[\e[0m\]@\[\e[34m\]docker\[\e[0m\]:\w\$ "' >> /root/.bashrc

CMD ["/bin/bash"]
