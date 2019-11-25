FROM ubuntu:17.10

RUN apt-get update && apt-get install -y \
    git \
    p7zip-full \
    cmake \ 
    lib32gcc-7-dev

RUN cd /tmp 

RUN git clone --branch=master https://github.com/dreamkas/DreamkasRfCompiler.git  

RUN 7z x /tmp/DreamkasRfCompiler/arm-linux-compiler.7z.001 -o/usr/local 

RUN 7z x /tmp/DreamkasRfCompiler/arm_linux_4.8.7z -o/usr/local