FROM ubuntu:16.04
MAINTAINER Warranyu Walton <wwalton@gmail.com>
LABEL Description="Docker based build machine for STM32"

# Set up compiler, JTAG tools, QEMU emulator and unit test framework

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
# Development files
    build-essential \
    git \
    bzip2 \
    ruby \
    qemu \
    wget

# Install Debug Dependency (using OpenOCD and gdb)
RUN apt-get install --no-install-recommends -y \
    libhidapi-hidraw0 \
    libusb-0.1-4 \
    libusb-1.0-0 \
    libhidapi-dev \
    libusb-1.0-0-dev \
    libusb-dev \
    libtool \
    make \
    automake \
    pkg-config \
    autoconf \
    texinfo

#build and install OPENOCD from repository
RUN cd /usr/src/ \
    && git clone --depth 1 https://github.com/ntfreak/openocd.git \
    && cd openocd \
    && ./bootstrap \
    && ./configure --enable-stlink --enable-jlink --enable-ftdi --enable-cmsis-dap \
    && make -j"$(nproc)" \
    && make install
    #remove unneeded directories
RUN cd ..
RUN rm -rf /usr/src/openocd \
    && rm -rf /var/lib/apt/lists/
#OpenOCD talks to the chip through USB, so we need to grant our account access to the FTDI.
#RUN cp /usr/local/share/openocd/contrib/60-openocd.rules /etc/udev/rules.d/60-openocd.rules

# Modify openOCD config file to support RTOS debugging
RUN sed -i -e 48's/$/ -rtos FreeRTOS &/' /usr/local/share/openocd/scripts/target/stm32f7x.cfg

ENV HOME /root
RUN mkdir -p ${HOME}/opt && \
    wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2?revision=bc2c96c0-14b5-4bb4-9f18-bceb4050fee7?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,7-2018-q2-update -O gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 && \
    tar -xjf gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 -C ${HOME}/opt && \
    rm gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 && \
    gem install ceedling

WORKDIR ${HOME}/work
ADD . ${HOME}/work

ENV GCC_PATH="${HOME}/opt/gcc-arm-none-eabi-7-2018-q2-update/bin"
