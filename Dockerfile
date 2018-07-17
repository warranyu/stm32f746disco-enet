FROM ubuntu:16.04
MAINTAINER Warranyu Walton <wwalton@gmail.com>
LABEL Description="Docker based build machine for STM32"

# Set up compiler, JTAG tools, QEMU emulator and unit test framework

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
# Development files
      build-essential \
      git \
      bzip2 \
      qemu \
      wget && \
    apt clean

ENV HOME /root
RUN mkdir -p ${HOME}/opt && \
    wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2?revision=bc2c96c0-14b5-4bb4-9f18-bceb4050fee7?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,7-2018-q2-update -O gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 && \
    tar -xjf gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 -C ${HOME}/opt && \
    rm gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2

WORKDIR ${HOME}/work
ADD . ${HOME}/work

ENV GCC_PATH="${HOME}/opt/gcc-arm-none-eabi-7-2018-q2-update/bin"
