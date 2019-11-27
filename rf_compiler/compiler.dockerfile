FROM ubuntu:18.04

RUN apt-get update && \ 
    apt-get install -y \
    git \
    p7zip-full \
    cmake \ 
    lib32gcc-7-dev
RUN cd /tmp && \
    git clone --branch=master https://github.com/dreamkas/DreamkasRfCompiler.git && \
    7z x /tmp/DreamkasRfCompiler/arm-linux-compiler.7z.001 -o/usr/local && \
    7z x /tmp/DreamkasRfCompiler/arm_linux_4.8.7z -o/usr/local